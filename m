From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 17 Dec 2015 11:31:17 +0100
Subject: [PATCH] ARM: PJ4: move coprocessor register access sequences to
 iwmmxt.S
In-Reply-To: <20151217102757.GF8644@n2100.arm.linux.org.uk>
References: <1447397933-13379-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151113184807.GA21047@codeaurora.org>
 <CAKv+Gu9tjeMska_1EUwcCgPoX=uXZkv0q+goew3q59T1UwEsyg@mail.gmail.com>
 <20151217102757.GF8644@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8nyjEd7n=aWjMHa0Lziu9qy=gTvyBL4ckieQLcTo-H3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 December 2015 at 11:27, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 13, 2015 at 08:23:34PM +0100, Ard Biesheuvel wrote:
>> On 13 November 2015 at 19:48, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 11/13, Ard Biesheuvel wrote:
>> >> The PJ4 inline asm sequences in pj4-cp0.c cannot be built in Thumb-2 mode,
>> >> due to the way it performs arithmetic on the program counter, so it is
>> >> built in ARM mode instead. However, building C files in ARM mode under
>> >> CONFIG_THUMB2_KERNEL is problematic, since the instrumentation performed
>> >> by subsystems like ftrace does not expect having to deal with interworking
>> >> branches.
>> >>
>> >> So instead, revert to building pj4-cp0.c in Thumb-2 mode, and move the
>> >> offending sequence to iwmmxt.S, which is not instrumented anyway, and is
>> >> already built in ARM mode unconditionally.
>> >>
>> >> Reported-by: Stephen Boyd <sboyd@codeaurora.org>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> ---
>> >
>> > Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>> >
>>
>> Thanks.
>>
>> I've put this into the patch system (8452/1)
>
> And I've dropped it from my tree because it's broken.
>
> Come on guys, you can do better than this:
>
> arch/arm/kernel/built-in.o: In function `pj4_cp0_init':
> arch/arm/kernel/psci-call.o:(.init.text+0x22d0): undefined reference to `pj4_cp_access_write'
> arch/arm/kernel/psci-call.o:(.init.text+0x22e0): undefined reference to `pj4_cp_access_write'
> arch/arm/kernel/psci-call.o:(.init.text+0x2304): undefined reference to `pj4_cp_access_read'
> arch/arm/kernel/psci-call.o:(.init.text+0x2310): undefined reference to `pj4_cp_access_write'
> arch/arm/kernel/psci-call.o:(.init.text+0x2314): undefined reference to `pj4_cp_access_read'
>
> Let's look at the makefile:
>
> obj-$(CONFIG_CPU_PJ4)           += pj4-cp0.o
> obj-$(CONFIG_CPU_PJ4B)          += pj4-cp0.o
> obj-$(CONFIG_IWMMXT)            += iwmmxt.o
>
> Now, you're moving code from pj4-cp0.c to iwmmxt.S, and of course, you
> checked that IWMMXT would always be enabled if either PJ4 or PJ4B are
> enabled.
>
> config IWMMXT
>         bool "Enable iWMMXt support"
>         depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
>         default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
>
> Err, no, IWMMXT can be disabled.  Hence the build errors.
>
> Please, take more time when moving code around to ensure that this kind
> of build breakage doesn't creep in.  It's *really* easy to check, it
> only takes a couple of additional minutes.
>

Yes, I was just looking into it after Arnd mentioned it over IRC

If you can live with not having the pr_info() that warns you when
running on a PJ4 with iWMMXt while CONFIG_IWMMXT is disabled, I could
just drop pj4-cp0.c from the build entirely, i.e.,

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index af9e59bf3831..9d798fb17359 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -67,13 +67,12 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)    += hw_breakpoint.o
 obj-$(CONFIG_CPU_XSCALE)       += xscale-cp0.o
 obj-$(CONFIG_CPU_XSC3)         += xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)       += xscale-cp0.o
-obj-$(CONFIG_CPU_PJ4)          += pj4-cp0.o
-obj-$(CONFIG_CPU_PJ4B)         += pj4-cp0.o
-obj-$(CONFIG_IWMMXT)           += iwmmxt.o
+iwmmxt-obj-$(CONFIG_CPU_PJ4)   := pj4-cp0.o
+iwmmxt-obj-$(CONFIG_CPU_PJ4B)  := pj4-cp0.o
+obj-$(CONFIG_IWMMXT)           += iwmmxt.o $(iwmmxt-obj-y)
 obj-$(CONFIG_PERF_EVENTS)      += perf_regs.o perf_callchain.o
 obj-$(CONFIG_HW_PERF_EVENTS)   += perf_event_xscale.o perf_event_v6.o \
                                   perf_event_v7.o
