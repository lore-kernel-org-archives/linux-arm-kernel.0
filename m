From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Oct 2014 13:02:31 -0500
Subject: [PATCH 08/12] rtc: omap: restore irq state after reading TC
 registers
In-Reply-To: <1412881594-25678-9-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-9-git-send-email-johan@kernel.org>
Message-ID: <20141010180225.GT31348@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 09, 2014 at 09:06:30PM +0200, Johan Hovold wrote:
> Make sure to restore local irq state when reading the timer/calendar
> (TC) registers, so that omap_rtc_read_time() can be called with
> interrupts disabled.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/rtc/rtc-omap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 0ef016553a97..62e2e9a9887a 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -239,8 +239,10 @@ static void bcd2tm(struct rtc_time *tm)
>  
>  static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> +	unsigned long flags;
> +
>  	/* we don't report wday/yday/isdst ... */
> -	local_irq_disable();
> +	local_irq_save(flags);

you should really convert these to a real spin_lock_irq*(), that's
because local_irq* do not get re-written with RT patchset, so this
pretty much "breaks" RT.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/bd63d886/attachment-0001.sig>
