From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 10:52:08 +0100
Subject: [PATCH] usb: musb: dsps: handle the
 otg_state_a_wait_vrise_timeout case
In-Reply-To: <87a8rde96m.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Tue, 20 Oct 2015 19:33:53 +0200")
References: <1440087153-31084-1-git-send-email-gregory.clement@free-electrons.com>
 <55D719B1.8010700@free-electrons.com>
 <87twrfsbed.fsf@free-electrons.com> <87d1wtf5ir.fsf@saruman.tx.rr.com>
 <87a8rde96m.fsf@free-electrons.com>
Message-ID: <87poyiegc7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

I am going back on this subject (again :) )
 
 On mar., oct. 20 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Felipe,
>  
>  On lun., oct. 05 2015, Felipe Balbi <balbi@ti.com> wrote:
>
>
>>> So after many tests on different devices, 200ms is enough for most of
>>> them, but for one, 2000ms (2s) was needed!
>>>
>>> I see several option:
>>> - adding a sysfs entry to setup the time
>>> - adding a debugs entry entry
>>> - adding configuration option in menuconfig
>>> - using 2000ms and hopping it was enough for everyone
>>>
>>> My preference would go to the first option, what is your opinion?
>>
>> I'm not sure if either of them is good. man 2s is just too large. If the

Well 2s is lon I agree, but currently instead of 2s we have an infinite
wait, which is worse!

>> device isn't following the specification, I'm afraid that device needs
>> to be fixed.

I agree but these devices are for most of them USB stick that we find in
retail. We have no influence on them, so we have to do with them, even
if they do not follow the sepc.

So what about using configfs or sysfs to let the user confgiure this
value if needed?

I go back on this because, your suggestion didn't work. At least, I
didn't manage to make it improve the situation.

Thanks,

>>
>> I think the real issue here is the lack of a disconnect IRQ from AM335x
>> devices. But here's something I've been meaning to test but never had
>> time. If you look into AM335x address space, there's a bit in the
>> wrapper which tells it to use the standard MUSB registers for IRQ,
>> instead of the TI-specific thing. Can you see if we get a disconnect IRQ
>> with that ?
>>
>> TRM is at [1], see page 2566. Basically, if you set bit 3 in register
>> offset 0x1014, then it should use Mentor IRQ registers. If that works,
>> quite a few problems will actually vanish :-p
>
> So I tried it with the following patch:
>
> -------------------------------------
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index c791ba5..c714500 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -470,6 +470,7 @@ static int dsps_musb_init(struct musb *musb)
>  
>         /* Reset the musb */
>         dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
> +       dsps_writel(musb->ctrl_base, wrp->control, BIT(3));
>  
>         musb->isr = dsps_interrupt;
>  
> @@ -625,6 +626,7 @@ static int dsps_musb_reset(struct musb *musb)
>         if (session_restart || !glue->sw_babble_enabled) {
>                 dev_info(musb->controller, "Restarting MUSB to recover from Babble\n");
>                 dsps_writel(musb->ctrl_base, wrp->control, (1 << wrp->reset));
> +               dsps_writel(musb->ctrl_base, wrp->control, BIT(3));
>                 usleep_range(100, 200);
>                 usb_phy_shutdown(musb->xceiv);
>                 usleep_range(100, 200);
> ------------------------------------
>
> I am not very familiar with that driver but my understanding was that
> the Mentor IRQ registeres are managed by the musb_interrupt() function
> which is called from the dsps_interrupt() interrupt handler.
>
> Am I right?
>
> if it is the case then it didn't fix the issue I had.
>
> I activated the following debug line:
>
> [musb_hdrc]musb_interrupt =_ "** IRQ %s usb%04x tx%04x rx%04x\012"
> [musb_dsps]dsps_interrupt =p "usbintr (%x) epintr(%x)\012"
>
> But I didn't get any interrupt while disconnecting the cable without any
> device connected on it (whereas I got an interrupt when I connected it).
>
> Note that I applied this patch instead of the "usb: musb: dsps: handle
> the otg_state_a_wait_vrise_timeout case", is what you had in mind ?
>
> Gregory
>
>>
>> [1] http://www.ti.com/lit/ug/spruh73l/spruh73l.pdf
>>
>> -- 
>> balbi
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
