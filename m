From: stefan@agner.ch (Stefan Agner)
Date: Wed, 25 May 2016 14:54:07 -0700
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <alpine.DEB.2.11.1604271212290.3941@nanos>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160421034520.GA19965@shlinux2.ap.freescale.net>
 <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
 <CAA+hA=REqJ8JhmKt5_jCAaRTUy2E14ww_MqWSSLpNBKgnf=U9A@mail.gmail.com>
 <alpine.DEB.2.11.1604271212290.3941@nanos>
Message-ID: <c3368a10135e304051a56562a1ae0f99@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-04-27 03:15, Thomas Gleixner wrote:
> On Wed, 27 Apr 2016, Dong Aisheng wrote:
>> Why Stefan's patch works (checking irqs_disabled()) is because during kernel
>> time init, the irq is still not enabled. It fixes the issue indirectly.
>> See:
>> asmlinkage __visible void __init start_kernel(void)
>> {
>>         /*
>>          * Set up the scheduler prior starting any interrupts (such as the
>>          * timer interrupt). Full topology setup happens at smp_init()
>>          * time - but meanwhile we still have a functioning scheduler.
>>          */
>>         sched_init();
>>         .............
>>         time_init();
>>         ..............
>>         WARN(!irqs_disabled(), "Interrupts were enabled early\n");
>>         early_boot_irqs_disabled = false;
>>         local_irq_enable();
>> }
>>
>> The issue can only happen when PLL enable causes a schedule during
>> imx_clock_init().
> 
> Calling a function which might sleep _BEFORE_ kernel_init() is wrong. Don't
> try to work around such an issue by doing magic irq_disabled() checks and busy
> loops. Fix the call site and be done with it.

What do you mean exactly by fix the call site? The patch I proposed
(https://lkml.org/lkml/2016/1/29/695) fixes the call site...

But I see Dong's argument here, irqs_disabled is the wrong way to figure
out whether we are in kernel_init. What is the right approach to
distinguish whether we are allowed to sleep?

--
Stefan
