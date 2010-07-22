From: kanru@0xlab.org (Kan-Ru Chen)
Date: Thu, 22 Jul 2010 23:16:08 +0800
Subject: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
In-Reply-To: <1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
	<1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
Message-ID: <877hknwnrb.fsf@anar.kanru.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--text follows this line--
Hi,

On Mon, 15 Mar 2010 18:23:42 +0800, Wang Hui <Hui.Wang@windriver.com> wrote:
> On omap2/3 series platforms, the musb can't raise id pin change
> detection interrupt, so we must change otg mode through sysfs
> interface manually. Currently when the musb is in B mode, if we
> want musb to be changed to A mode, we should plug a mini-A cable
> and then execute echo host > /sys/devices/platform/musb_hdrc/mode.
> But if the musb is in A mode, we can't change it to B mode through
> this method.
> To solve this problem, add a process for sending end session request.
> This process works like this, if the musb is in A mode, it will send
> an end session request first, then it will follow original routine:
> start a new session, during this session, it will identify whether
> A or B is plugging in the socket,  then it will init controller to A
> or B mode according to its identification.

Just curious about how to do this in a more automatic way.

I think setup a daemon to monitor the musb_hdrc mode and try to alter
it's state via sysfs interface will work, but it may be error prone and
not always desirable solution.

Can we query the id pin state periodically in the kernel and change to
corresponding role?

Regards,
Kanru 
> 
> Usage: change cable as you desired,
>        change musb mode by #>echo host[peripheral] > /sys/devices/\
>        platform/musb_hdrc/mode,
>        then you will get required musb mode.
> 
> Signed-off-by: Wang Hui <Hui.Wang@windriver.com>
> ---
>  drivers/usb/musb/omap2430.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 3fe1686..b02897e 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -194,6 +194,11 @@ int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
>  {
>  	u8	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>  
> +	if ((devctl & MUSB_DEVCTL_BDEVICE) == 0x0) {
> +		devctl &= ~MUSB_DEVCTL_SESSION;
> +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> +	}
> +
>  	devctl |= MUSB_DEVCTL_SESSION;
>  	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
>  
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
