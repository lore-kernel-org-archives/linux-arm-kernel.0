From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 18 May 2012 15:27:41 +0400
Subject: usb, davinci: usb 2.0 problem on an am1808 based board
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3E97C9C1@DBDE01.ent.ti.com>
References: <4EBC9DF1.90604@denx.de>
 <20111111091912.GB19090@legolas.emea.dhcp.ti.com>
 <4EBEB29E.50705@mvista.com>	<4EC0F87B.4010104@denx.de>
 <4FA3AB27.7060205@denx.de> <4FB49CA3.2080906@denx.de>
 <A73F36158E33644199EB82C5EC81C7BC3E97C9C1@DBDE01.ent.ti.com>
Message-ID: <4FB6322D.5070602@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-05-2012 14:07, Manjunathappa, Prakash wrote:

> I do not know how putting delay helped MSC device detection.
> Can you please check if MUSB is coming up in "b_idle" state(by
> $cat /sys/devices/platform/musb-da8xx/musb-hdrc/mode)?
> State should move to b_peripheral on connecting gadget cable.
> If you connect MSC device via mini-A connector, state should change to "a_host".
> OTG timer is responsible for above state changes, can you please check if below
> changes are present?
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c index 4da7492..a1a692e 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -76,6 +76,7 @@
>   #define DA8XX_INTR_TX_SHIFT    0
>   #define DA8XX_INTR_TX_MASK     (DA8XX_USB_TX_EP_MASK<<  DA8XX_INTR_TX_SHIFT)
>
> +#define A_WAIT_BCON_TIMEOUT     1100            /* in ms */
>   #define DA8XX_MENTOR_CORE_OFFSET 0x400
>
>   #define CFGCHIP2       IO_ADDRESS(DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG)
> @@ -443,6 +444,7 @@ static int da8xx_musb_init(struct musb *musb)
>                   rev, __raw_readl(CFGCHIP2),
>                   musb_readb(reg_base, DA8XX_USB_CTRL_REG));
>
> +       musb->a_wait_bcon = A_WAIT_BCON_TIMEOUT;
>          musb->isr = da8xx_musb_interrupt;
>          return 0;
>   fail:

    This change shouldn't be needed as musb->a_wait_bcon is set in 
musb_core.c::allocate_instance().

> Thanks,
> Prakash

WBR, Sergei
