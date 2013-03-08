From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Mar 2013 12:29:47 -0800
Subject: [PATCH 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <513A4774.3040605@codeaurora.org>
References: <1362614646-24113-1-git-send-email-sboyd@codeaurora.org>
 <1362614646-24113-4-git-send-email-sboyd@codeaurora.org>
 <20130308004011.GD11806@atomide.com>
 <51393B59.3070200@codeaurora.org>
 <20130308180730.GE11806@atomide.com>
 <513A2B20.30805@codeaurora.org>
 <20130308194802.GG11806@atomide.com>
 <513A40EF.8050403@codeaurora.org>
 <20130308200811.GJ11806@atomide.com>
 <513A4774.3040605@codeaurora.org>
Message-ID: <20130308202947.GK11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Boyd <sboyd@codeaurora.org> [130308 12:22]:
> On 03/08/13 12:08, Tony Lindgren wrote:
> > * Stephen Boyd <sboyd@codeaurora.org> [130308 11:54]:
> >> On 03/08/13 11:48, Tony Lindgren wrote:
> >>> * Stephen Boyd <sboyd@codeaurora.org> [130308 10:21]:
> >>>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> >>>> index 081de6f..4ea3e9d 100644
> >>>> --- a/arch/arm/kernel/smp_twd.c
> >>>> +++ b/arch/arm/kernel/smp_twd.c
> >>>> @@ -227,7 +227,7 @@ static void __cpuinit twd_calibrate_rate(void)
> >>>>  
> >>>>  static irqreturn_t twd_handler(int irq, void *dev_id)
> >>>>  {
> >>>> -       struct clock_event_device *evt = *(struct clock_event_device **)dev_id;
> >>>> +       struct clock_event_device *evt = dev_id;
> >>>>  
> >>>>         if (twd_timer_ack()) {
> >>>>                 evt->event_handler(evt);
> >>>>
> >>> Yup thanks that fixes it, both fixes are needed. So for this patch + the
> >>> two fixes please feel free to add:
> >>>
> >>> Acked-by: Tony Lindgren <tony@atomide.com>
> >> Great. Thanks for testing.
> > Hmm noticed one more thing: vexpress no longer boots in qemu for
> > me after applying this. Sorry did not get any debug_ll output, but
> > maybe you can take a look at it. I tested with omap2plus_defconfig +
> > linaro-qemu:
> >
> > $ qemu-system-arm -machine vexpress-a9 -m 1024 -curses -net nic -net \
> > user -serial stdio -append console=ttyAMA0,115200n8 rw \
> > root=/dev/mmcblk0p2 rootwait physmap.enabled=0 -kernel zImage \
> > -initrd initrd.img -sd rootfs.img
> >
> >
> 
> I wonder if you're hitting something similar to this issue on versatile
> boards [1]. Can you try that patch? Otherwise I will try to get qemu
> running (something I've never done, do you have instructions?).

Applying that does not seem to help, but you might want to get vexpress
running anyways for some multiplatform sanity checks.

I just built and installed qemu-linaro from their git, then ran the
command above. Looks like stock qemu does not work for vexpress for some
reason. You can probably use a dummy initrd and rootfs to debug this
though :)

More info on qemu-linaro at:

https://launchpad.net/qemu-linaro

Regards,

Tony
 
> [1] http://article.gmane.org/gmane.linux.ports.arm.kernel/221539
