From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun, 25 Jun 2017 14:19:31 -0700
Subject: [PATCH 4/4] remoteproc/davinci: streamline the interrupt
 management
In-Reply-To: <20170518220902.2846-5-s-anna@ti.com>
References: <20170518220902.2846-1-s-anna@ti.com>
 <20170518220902.2846-5-s-anna@ti.com>
Message-ID: <20170625211931.GC26155@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 18 May 15:09 PDT 2017, Suman Anna wrote:

> The davinci remoteproc driver is currently requesting its interrupt
> that deals with the virtio kicks in probe, and that too before all
> the associated variables used by the handler are initialized. This
> is a lot in advance before the DSP remote processor is even loaded
> and booted and is not essential. Streamline the interrupt request
> and freeing operations instead alongside the boot and shutdown of
> the remote processor.
> 

I do prefer that all resources are acquired at probe() time, rather than
handled upon each start/stop. In the current handle_event()
implementation the remoteproc code will not find the yet unallocated
notify-id's and do nothing. So this seems okay.

[..]
> @@ -213,15 +224,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, rproc);
>  
> -	/* everything the ISR needs is now setup, so hook it up */
> -	ret = devm_request_threaded_irq(dev, irq, da8xx_rproc_callback,
> -					handle_event, 0, "da8xx-remoteproc",
> -					rproc);
> -	if (ret) {
> -		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
> -		goto free_rproc;
> -	}

In the error paths after this the driver will end up freeing the rproc
context before disabling the irq, so these cases need a call to
disable_irq().

> -
>  	/*
>  	 * rproc_add() can end up enabling the DSP's clk with the DSP
>  	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
> @@ -254,14 +256,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  static int da8xx_rproc_remove(struct platform_device *pdev)
>  {
>  	struct rproc *rproc = platform_get_drvdata(pdev);
> -	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
> -
> -	/*
> -	 * The devm subsystem might end up releasing things before
> -	 * freeing the irq, thus allowing an interrupt to sneak in while
> -	 * the device is being removed.  This should prevent that.
> -	 */

devres _will not_ disable the IRQ until after remove() returns, making it
possible for the interrupt handler to be executed after the rproc
context is freed.

So this comment would benefit from an update.

> -	disable_irq(drproc->irq);
>  
>  	rproc_del(rproc);
>  	rproc_free(rproc);

Regards,
Bjorn
