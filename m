From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 23 May 2013 16:55:04 -0700
Subject: [rtc-linux] [PATCH] rtc: max8998: Check for pdata presence
 before dereferencing
In-Reply-To: <1368630968-30460-1-git-send-email-t.figa@samsung.com>
References: <1368630968-30460-1-git-send-email-t.figa@samsung.com>
Message-ID: <20130523165504.364bebf5f999e4a12d51e176@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 May 2013 17:16:08 +0200 Tomasz Figa <t.figa@samsung.com> wrote:

> Currently the driver can crash with a NULL pointer dereference if no pdata
> is provided, despite of successful registration of MFD part. This patch
> fixes the problem by adding a NULL check before dereferencing the pdata
> pointer.
> 
> ...
>
> --- a/drivers/rtc/rtc-max8998.c
> +++ b/drivers/rtc/rtc-max8998.c
> @@ -285,7 +285,7 @@ static int max8998_rtc_probe(struct platform_device *pdev)
>  			info->irq, ret);
>  
>  	dev_info(&pdev->dev, "RTC CHIP NAME: %s\n", pdev->id_entry->name);
> -	if (pdata->rtc_delay) {
> +	if (pdata && pdata->rtc_delay) {
>  		info->lp3974_bug_workaround = true;
>  		dev_warn(&pdev->dev, "LP3974 with RTC REGERR option."
>  				" RTC updates will be extremely slow.\n");

Looking at your description I'm unable to determine which kernel
versions we should fix.  This is because the changelog didn't describe
the circumstances under which the bug triggers.

It's pretty simple: when fixing a bug, include a full description of
the bug!  As if you were sending a bug report, not a patch.
