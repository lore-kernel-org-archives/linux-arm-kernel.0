From: balbi@ti.com (Felipe Balbi)
Date: Tue, 14 Jan 2014 07:10:52 -0600
Subject: [PATCHv4 6/7] hwspinlock/omap: enable module before reading
 SYSSTATUS register
In-Reply-To: <1389658764-39199-7-git-send-email-s-anna@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-7-git-send-email-s-anna@ti.com>
Message-ID: <20140114131052.GA10818@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 06:19:23PM -0600, Suman Anna wrote:
> The number of hwspinlocks are determined based on the value read
> from the IP block's SYSSTATUS register. However, the module may
> not be enabled and clocked, and the read may result in a bus error.
> 
> This particular issue is seen rather easily on AM33XX, since the
> module wakeup is software controlled, and it is disabled out of
> reset. Make sure the module is enabled and clocked before reading
> the SYSSTATUS register.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/hwspinlock/omap_hwspinlock.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
> index 9f56fb2..194886e 100644
> --- a/drivers/hwspinlock/omap_hwspinlock.c
> +++ b/drivers/hwspinlock/omap_hwspinlock.c
> @@ -101,10 +101,23 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>  	if (!io_base)
>  		return -ENOMEM;
>  
> +	/*
> +	 * make sure the module is enabled and clocked before reading
> +	 * the module SYSSTATUS register
> +	 */
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
>  	/* Determine number of locks */
>  	i = readl(io_base + SYSSTATUS_OFFSET);
>  	i >>= SPINLOCK_NUMLOCKS_BIT_OFFSET;
>  
> +	/*
> +	 * runtime PM will make sure the clock of this module is
> +	 * enabled again iff at least one lock is requested
> +	 */
> +	pm_runtime_put(&pdev->dev);

there is a small race here (which was already present previously) where
you could return from probe() in a failure case before your PM runtime
put request then you would disable pm_runtime while the device was still
alive.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/0dd1b400/attachment.sig>
