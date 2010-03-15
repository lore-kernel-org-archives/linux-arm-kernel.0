From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 15 Mar 2010 14:22:38 +0300
Subject: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
In-Reply-To: <1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
	<1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
Message-ID: <4B9E187E.6090802@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Wang Hui wrote:

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

   The whole musb_platform_set_mode() seems to be implemented 
incorrectly on OMAPs -- it shouldn't touch the DevCtl.Session bit. This 
function should control the ID pin override instead -- if the controller 
supports it. SRP must be initiated thru other means, i.e. 'srp' file in 
sysfs.

WBR, Sergei
