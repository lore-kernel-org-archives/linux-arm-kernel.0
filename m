From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 May 2014 12:53:31 +0800
Subject: [PATCH v5 08/14] ARM: hisi: add hip04 SoC support
In-Reply-To: <alpine.LFD.2.11.1405151602140.17310@knanqh.ubzr>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
 <1399473888-12947-9-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1405071259300.980@knanqh.ubzr>
 <CAD6h2NQU0NR1PO=x6pz62B4QWqkPz7F+Fp65YeQJ62vumF8_Aw@mail.gmail.com>
 <CAD6h2NTMJ5GNkUdcTvx_MoKnGSnmQ15vUWBoj7GcKdBTBf7MJw@mail.gmail.com>
 <alpine.LFD.2.11.1405121510130.980@knanqh.ubzr>
 <CAD6h2NTz6h+GSM7BKr_Om3VHjKOXebO6hRD0BHCjzyT57qHeLQ@mail.gmail.com>
 <alpine.LFD.2.11.1405131433580.980@knanqh.ubzr>
 <CAD6h2NR3=uq7uQ3JMjGKo0-QjM18B-pdOoeGTsMtfkdf_uSQ=A@mail.gmail.com>
 <alpine.LFD.2.11.1405151602140.17310@knanqh.ubzr>
Message-ID: <CAD6h2NQ_eD-K_i6VryjZK-7WHyNsOtz8y3kiTJPHrKjxi3X2_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2014 04:10, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 15 May 2014, Haojian Zhuang wrote:
>
>> On 14 May 2014 02:44, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> >>
>> >> There's no CCI in HiP04. Their own fabric is used instead.
>> >
>> > OK.  Still, in order to support deep C-States with cpuidle, the
>> > waking-up of CPUs must happen asynchronously, and in that case the CPU
>> > being awaken must do snooping setup by itself.  So I'd be interested to
>> > see if that can be down that way as well for HiP04, at least to be
>> > similar in structure to other backend implementations, and possibly for
>> > being cpuidle ready as well.
>> >
>>
>> But it fails on my platform if I execute snooping setup on the new CPU.
>
> It fails how?  I want to make sure if the problem is with the hardware
> design or the code.
>
The failure isn't caused by your assembly code. I even rewrite it.

It's caused by hardware design. Hisilicon guys said the snooping setup
should be set before new CPU on. I tried and got the same result.

>> >> >> >
>> >> >> >>> +     spin_unlock_irq(&boot_lock);
>> >> >> >>> +     msleep(POLL_MSEC);
>> >> >> >>
>> >> >> >> What is that msleep() for?
>> >> >> >>
>> >> >> > Without this delay, I'll meet hang.
>> >> >> >
>> >> >> > Since I'm using reset to wakeup CPU from wfi/wfe status, I don't need
>> >> >> > IPI at here. If I remove the msleep() here, it seems that IPI caused my
>> >> >> > system hang. So it's a workaround in my system.
>> >> >
>> >> > Could you confirm that the IPI is actually what causes you trouble?
>> >> >
>> >> > If so maybe you should make sure that the CPU is actually masking out
>> >> > IRQs at all times before they're unmasked by the kernel.
>> >> >
>> >>
>> >> I think so. But I don't have any hardware debugger to confirm it.
>> >>
>> >> I think that unnecessary interrupt causes new CPU in interrupt mode,
>> >> then this CPU can't be online.
>> >>
>> >> If I remove the code to send IPI, the new CPU could be online right.
>> >
>> > If so that's a bug in the firmware/bootloader/whatever code that needs
>> > to be fixed.  CPUs must never unmasq IRQs if they're not ready to cope
>> > with them.
>> >
>>
>> I agree that it should be fixed in firmware. But I need some time. So I
>> want to keep the workaround until the bug is fixed in firmware.
>
> This is still a very bad workaround.  As an alternative, there might be
> a way to simply mask the IPI at the GIC level and unmask it from the
> powered_up method.
>
> Also... if this is going to be fixed in the firmware, maybe not
> including such a workaround into the upstream submission will keep the
> incentive alive for having it actually fixed.
>


OK. Let me remove the workaround.

Regards
Haojian
