From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Thu, 06 Aug 2015 10:22:59 +0200
Subject: [linux-sunxi] [PATCH] musb: sunxi: Ignore VBus errors in host-only
 mode
In-Reply-To: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
Message-ID: <55C31963.2010701@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Hans,

I've tried getting your musb stuff working on a cubietruck, but i don't 
seem to see this patch on your linux-sunxi/sunxi-wip branch on github? 
Is your github branch fully functional at the moment?

What I have done so far, is build the kernel using sunxi_defconfig and 
enabled USB_MUSB_SUNXI with its dependancies (musb isn't enabled there 
by default): USB_SUPPORT [=y] && USB_MUSB_HDRC [=y] && ARCH_SUNXI [=y] 
&& NOP_USB_XCEIV [=y] && PHY_SUN4I_USB [=y] && EXTCON [=y] && 
GENERIC_PHY [=y]  Selects: SUNXI_SRAM [=y]

I changed the dts from dr_mode='otg' to dr_mode='host', a) we only need 
host mode anyway (the id pin isn't properly connected) and b) I got an 
error about an known dr_mode before and this was the quick and easy way.

Dmesg produces the following related to musb.

[    1.691062] usb_phy_generic.0.auto supply vcc not found, using dummy 
regulator
[    1.691445] musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk 
combine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
[    1.691453] musb-hdrc: MHDRC RTL version 0.0
[    1.691467] musb-hdrc: 11/11 max ep, 5184/8192 memory
[    1.691543] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
[    1.691553] musb-hdrc musb-hdrc.1.auto: new USB bus registered, 
assigned bus number 5
[    1.692470] hub 5-0:1.0: USB hub found
[    1.692529] hub 5-0:1.0: 1 port detected
[    1.699956] sunxi-rtc 1c20d00.rtc: setting system clock to 2015-08-06 
07:59:08 UTC (1438847948)
[    1.704733] usb0-vbus: disabling
[    1.765695] ldo4: disabling
[    1.808351] ldo3: disabling
[    1.848769] vcc5v0: disabling
[    1.848774] vcc3v0: disabling

The usb_phy_generic missing shouldn't be too bad? But the usb0-vbus 
being disabled obviously might be related to the musb port not working? 
What causes this though? I went through all the musb patch series mails 
but don't recall seing anything special being needed.

If there are fixes missing in the sunxi-next stuff that could explain 
this, could you be so kind and push your latest work so I can try it? 
Thanks Hans!

Olliver

On 04-08-15 23:25, Hans de Goede wrote:
> For some unclear reason sometimes we get VBus errors in host-only mode,
> even though we do not have any vbus-detection then. Ignore these.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/usb/musb/sunxi.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index f9f6304..34ce5df 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -194,6 +194,10 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
>   		musb_writeb(musb->mregs, MUSB_FADDR, 0);
>   	}
>   
> +	/*  Ignore Vbus errors when in host only mode */
> +	if (musb->port_mode == MUSB_PORT_MODE_HOST)
> +		musb->int_usb &= ~MUSB_INTR_VBUSERROR;
> +
>   	musb->int_tx = readw(musb->mregs + SUNXI_MUSB_INTRTX);
>   	if (musb->int_tx)
>   		writew(musb->int_tx, musb->mregs + SUNXI_MUSB_INTRTX);
