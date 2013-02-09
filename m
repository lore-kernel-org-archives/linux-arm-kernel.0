From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 10:22:44 +0000
Subject: [PATCH v2 3/4] mtd: devices: elm: Low power transition support
In-Reply-To: <1360240618-11094-4-git-send-email-avinashphilip@ti.com>
References: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
 <1360240618-11094-4-git-send-email-avinashphilip@ti.com>
Message-ID: <20130209102243.GH17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 06:06:57PM +0530, Philip Avinash wrote:
> +static int elm_suspend(struct device *dev)
> +{
> +	struct elm_info *info = dev_get_drvdata(dev);
> +	wait_queue_head_t wq;
> +	DECLARE_WAITQUEUE(wait, current);
> +
> +	init_waitqueue_head(&wq);
> +	while (1) {
> +		/* Make sure that ELM not running */
> +		if (info->idle) {
> +			add_wait_queue(&wq, &wait);
> +			schedule();
> +			remove_wait_queue(&wq, &wait);
> +		} else {
> +			break;
> +		}
> +	}

The above code looks really wrong - it will just spin endlessly with the
waitqueues doing nothing useful.  What are you trying to do here?
