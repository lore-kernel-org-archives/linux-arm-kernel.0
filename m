From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 07 Nov 2013 16:02:26 -0800
Subject: [PATCH v5] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <1383863549-7438-1-git-send-email-zonque@gmail.com> (Daniel
 Mack's message of "Thu, 7 Nov 2013 23:32:29 +0100")
References: <1383863549-7438-1-git-send-email-zonque@gmail.com>
Message-ID: <87siv7pxpp.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>
> All information can be reconstructed by already known runtime
> information.
>
> As we now use some functions that were previously only used from __init
> context, annotations had to be dropped.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
> Ok, here is v5.
>
> v4 -> v5:
>
> 	* dropped pm_runtime_* function calls entirely
> 	* moved the function pointers to .suspend/resume _noirq

[...]

> +static const struct dev_pm_ops edma_pm_ops = {
> +	.suspend	= edma_pm_suspend,

I suspect you intended to use the _noirq version like the changelog
says?

> +	.resume_noirq	= edma_pm_resume,
> +};

Also, I believe it was already suggested by Nishanth, but the late/early
callbacks are probably more appropriate here than the noirq callbacks.
Unless there's a *really* good reason to use the noirq callbacks, they
should be avoided.

That being said, I wonder if the whole approach here is the right one.
I know you're basing your stuff on some TI tree, but that doesn't make
it the right way (usually, it's the opposite, but I digress...)  ;)

IMO, EDMA should be done like we currently do I2C and not implement
suspend/resume at all.  Instead, the driver should do runtime PM done on
a per xfer basis.  Then when suspend comes along, all that needs to be
done is ensure all in-flight xfers are done, then runtime PM will kick
in.

Kevin
