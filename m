From: hs@denx.de (Heiko Schocher)
Date: Thu, 17 May 2012 08:37:23 +0200
Subject: usb, davinci: usb 2.0 problem on an am1808 based board
In-Reply-To: <4FA3AB27.7060205@denx.de>
References: <4EBC9DF1.90604@denx.de>
 <20111111091912.GB19090@legolas.emea.dhcp.ti.com> <4EBEB29E.50705@mvista.com>
 <4EC0F87B.4010104@denx.de> <4FA3AB27.7060205@denx.de>
Message-ID: <4FB49CA3.2080906@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Heiko Schocher wrote:
> Hello,
> 
> a while ago (see discussion here:
> http://comments.gmane.org/gmane.linux.usb.general/54505), I found this
> "USB timing Bug" on an am1808 based board:
> 
> Heiko Schocher wrote:
>> Hello Sergei,
> [...]
>> Sergei Shtylyov wrote:
>>> Hello.
>>>
>>> On 11.11.2011 11:19, Felipe Balbi wrote:
>>>
>>>>> I try to bring up usb 2.0 support on an am1808 based
>>>>> board and Linux version 3.1.0-rc10 and I am facing
>>>>> some issues:
> [...]
>>>>>   But if I add in drivers/usb/musb/da8xx.c
>>>>>    da8xx_musb_interrupt() a 10ms delay befor the
>>>>>    "if (status&  (DA8XX_INTR_DRVVBUS<<  DA8XX_INTR_USB_SHIFT)) {"
>>>>>    line usb works fine!
>>>>>    It also works without this timeout if I change the
>>>>>    "dev_dbg(musb->controller, "USB IRQ %08x\n", status);"
>>>>>    to
>>>>>    "printk(musb->controller, "USB IRQ %08x\n", status);"
>>>>>
>>>>>    ->  some timing issue, but I have no idea why!
>>>>>       (Maybe you have an idea?)
>>>> unfortunately I don't know any details about DaVinci.
>>>    AM1808 is not exactly DaVinci, to be precise...
>>>
>>>> Sergei, are you able to help on this question ?
>>>    Maybe. :-)
>> I hope it ;-)
> 
> now I digged deeper and found this patch, which solves the
> problem (without adding a 10 ms delay):
> 
> -----------------------------
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index d32aa4d..6a6b17b 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -297,6 +297,7 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
>         unsigned long           flags;
>         irqreturn_t             ret = IRQ_NONE;
>         u32                     status;
> +       int                     flag = 1;
> 
>         spin_lock_irqsave(&musb->lock, flags);
> 
> @@ -368,6 +363,7 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
>                         musb->xceiv->default_a = 0;
>                         musb->xceiv->state = OTG_STATE_B_IDLE;
>                         portstate(musb->port1_status &= ~USB_PORT_STAT_POWER);
> +                       flag = 0;
>                 }
> 
>                 dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
> @@ -378,7 +374,7 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
>                 ret = IRQ_HANDLED;
>         }
> 
> -       if (musb->int_tx || musb->int_rx || musb->int_usb)
> +       if (flag && ((musb->int_tx || musb->int_rx || musb->int_usb)))
>                 ret |= musb_interrupt(musb);
> 
>   eoi:
> -----------------------------
> 
> If we get an DA8XX_INTR_DRVVBUS IRQ, in the else case
> 
> musb->xceiv->state = OTG_STATE_B_IDLE;
> 
> is set, but overwritten in the musb_interrupt() call, which results
> in not starting the "Poll for ID change" timer ... as I am not an USB
> expert, posting this intermediate result here, maybe someone have an
> idea/explanation if this patch is the way to go, or what would be a
> better solution?

ping? Some comments/ideas?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
