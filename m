From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 22 Oct 2009 20:05:24 +0100
Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to
	suspend
In-Reply-To: <200910201719.41102.anarsoul@gmail.com>
References: <200910201719.41102.anarsoul@gmail.com>
Message-ID: <20091022190524.GB8096@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2009 at 05:19:30PM +0300, Vasily Khoruzhick wrote:
> Fix for a bug that shows when the s3c2410 TS driver requests
> a conversion from the s3c-adc driver and the machine goes into suspend.
> In this case the touchscreen stops working.

Ok, thanks for pointing this out.

> From ff091bbc781c7182611be3de3e9b3a078d770336 Mon Sep 17 00:00:00 2001
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> Date: Tue, 20 Oct 2009 17:14:26 +0300
> Subject: [PATCH] s3c24xx-adc: resume convertions interrupted by going to suspend
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/plat-s3c24xx/adc.c |   47 ++++++++++++++++++++++++++++++++++++------
>  1 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c24xx/adc.c
> index 4d36b78..45024e6 100644
> --- a/arch/arm/plat-s3c24xx/adc.c
> +++ b/arch/arm/plat-s3c24xx/adc.c
> @@ -46,6 +46,7 @@ struct s3c_adc_client {
>  	int			 result;
>  	unsigned char		 is_ts;
>  	unsigned char		 channel;
> +	unsigned int		 selected;
>  
>  	void	(*select_cb)(struct s3c_adc_client *c, unsigned selected);
>  	void	(*convert_cb)(struct s3c_adc_client *c,
> @@ -67,6 +68,7 @@ struct adc_device {
>  };
>  
>  static struct adc_device *adc_dev;
> +static struct work_struct resume_work;
>  
>  static LIST_HEAD(adc_pending);
>  
> @@ -85,7 +87,10 @@ static inline void s3c_adc_select(struct adc_device *adc,
>  {
>  	unsigned con = readl(adc->regs + S3C2410_ADCCON);
>  
> -	client->select_cb(client, 1);
> +	if (!client->selected) {
> +		client->selected = 1;
> +		client->select_cb(client, 1);
> +	}

You seem to have added something other than just a bugfix to this patch,
you've changed the behaviour of the select callback. Is this really
necessary for the function of the fix or something that dropped in by
accident?
  
>  	con &= ~S3C2410_ADCCON_MUXMASK;
>  	con &= ~S3C2410_ADCCON_STDBM;
> @@ -109,13 +114,9 @@ static void s3c_adc_try(struct adc_device *adc)
>  {
>  	struct s3c_adc_client *next = adc->ts_pend;
>  
> -	if (!next && !list_empty(&adc_pending)) {
> +	if (!next && !list_empty(&adc_pending))
>  		next = list_first_entry(&adc_pending,
>  					struct s3c_adc_client, pend);
> -		list_del(&next->pend);
> -	} else
> -		adc->ts_pend = NULL;
> -
>  	if (next) {
>  		adc_dbg(adc, "new client is %p\n", next);
>  		adc->cur = next;
> @@ -224,6 +225,7 @@ struct s3c_adc_client *s3c_adc_register(struct platform_device *pdev,
>  	client->is_ts = is_ts;
>  	client->select_cb = select;
>  	client->convert_cb = conv;
> +	client->selected = 0;
>  
>  	return client;
>  }
> @@ -278,13 +280,20 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
>  	if (client->nr_samples > 0) {
>  		/* fire another conversion for this */
>  
> +		client->selected = 1;
>  		client->select_cb(client, 1);
>  		s3c_adc_convert(adc);
>  	} else {
>  		local_irq_save(flags);
> -		(client->select_cb)(client, 0);
> +		client->selected = 0;
> +		if (!adc->cur->is_ts)
> +			list_del(&adc->cur->pend);
> +		else
> +			adc->ts_pend = NULL;
>  		adc->cur = NULL;
>  
> +		(client->select_cb)(client, 0);
> +
>  		s3c_adc_try(adc);
>  		local_irq_restore(flags);
>  	}
> @@ -389,18 +398,42 @@ static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
>  	writel(con, adc->regs + S3C2410_ADCCON);
>  
>  	clk_disable(adc->clk);
> +	disable_irq(IRQ_ADC);
> +	if (!list_empty(&adc_pending) || adc->ts_pend)
> +		dev_info(&pdev->dev, "We still have adc clients pending\n");
>  
>  	return 0;
>  }
>  
> +static void adc_resume_work(struct work_struct *work)
> +{
> +	if (!adc_dev) {
> +		/* Have no ADC here */
> +		return;
> +	}
> +
> +	if (!list_empty(&adc_pending) || adc_dev->ts_pend)
> +		/* We still have adc clients pending */
> +		s3c_adc_try(adc_dev);
> +}
> +
> +
>  static int s3c_adc_resume(struct platform_device *pdev)
>  {
>  	struct adc_device *adc = platform_get_drvdata(pdev);
>  
> +	enable_irq(IRQ_ADC);
>  	clk_enable(adc->clk);
>  
>  	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
>  	       adc->regs + S3C2410_ADCCON);
> +	/* Schedule task if there are clients pending. */
> +	if (!list_empty(&adc_pending) || adc_dev->ts_pend) {
> +		INIT_WORK(&resume_work, adc_resume_work);
> +		if (!schedule_work(&resume_work))
> +			dev_err(&pdev->dev,
> +				"Failed to schedule adc_resume work!\n");
> +	}

Is the work being used here to avoid trying to do things that may
sleep? IIRC, none of the calls should need to sleep.

I was just wondering whether it would be better to abort any calls in
progress before sleep and get the clients themselves to restart once
they themselves have been resumed. We may end up with the case where the
callbacks are being triggered before the client has been resumed.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
