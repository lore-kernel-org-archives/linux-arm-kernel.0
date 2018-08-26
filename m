From: stefan@agner.ch (Stefan Agner)
Date: Sun, 26 Aug 2018 21:22:25 +0200
Subject: Function Tracing with clang on ARM32
In-Reply-To: <20180824212006.GS160295@google.com>
References: <35ae3d464c7b77a5fe86a732079e32bc@agner.ch>
 <20180824212006.GS160295@google.com>
Message-ID: <71400574f8e914ee994c82564485b79e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.08.2018 23:20, Matthias Kaehlcke wrote:
> Hi Stefan,
> 
> A similar/related issue was fixed for arm64 by
> https://reviews.llvm.org/rL266039
> 
> The corresponding LLVM bug is
> https://bugs.llvm.org//show_bug.cgi?id=27311
> 
> Apparently for arm32 the use of '-meabi gnu' was chosen as solution:
> 
> http://llvm.org/viewvc/llvm-project?view=revision&revision=265888

Yes I did saw that, and using -meabi gnu allows to compile the kernel
with CONFIG_FUNCTION_TRACER=y (see below). Unfortunately, when trying to
boot the kernel crashes very early.

I dig a bit deeper and found that the function entry looks slightly
different when using clang:

clang v6.0.1 with 

0000026c <proc_caches_init>:
 26c:   b5d0            push    {r4, r6, r7, lr}
 26e:   af02            add     r7, sp, #8
 270:   b084            sub     sp, #16
 272:   f7ff fffe       bl      0 <__gnu_mcount_nc>

GCC 7.2.1:

000001d6 <proc_caches_init>:
 1d6:   b530            push    {r4, r5, lr}
 1d8:   b085            sub     sp, #20
 1da:   b500            push    {lr}
 1dc:   f7ff fffe       bl      0 <__gnu_mcount_nc>


It seems that GCC stores the link register on the stack, whereas clang
stores a reference to the location of the stack where r7/lr has been
stored.

Changing mcount_exit to not restore lr seems to help:

.macro mcount_exit
	ldmia	sp!, {r0-r3, ip}
	ret	ip
.endm


However, this leads to a broken trace, since mcount_get_lr can't find
the link register...

...
          <idle>-0     [000] dn..    59.055202: hrtimer_start_range_ns
<-init_stack
          <idle>-0     [000] dn..    59.055203: _raw_spin_lock_irqsave
<-__gnu_mcount_nc
          <idle>-0     [000] dn..    59.055205: hrtimer_reprogram
<-0xdf946580
          <idle>-0     [000] dn..    59.055206: tick_program_event
<-0x0000000d
          <idle>-0     [000] dn..    59.055208:
clockevents_program_event <-0xdf946860
...

It seems somewhat odd that clang uses the GCC function name but does not
provide lr on the stack...

--
Stefan


> 
> Cheers
> 
> Matthias
> 
> On Sat, Aug 11, 2018 at 02:29:24PM +0200, Stefan Agner wrote:
>> Hi,
>>
>> I am currently looking into function tracing support when compiling an
>> ARM32 kernel with clang.
>>
>> With v4.18-rc1 and:
>> CONFIG_FTRACE=y
>>
>> CONFIG_FUNCTION_TRACER=y
>>
>> Building fails:
>>
>>   LD      vmlinux.o
>>
>>   MODPOST vmlinux.o
>> kernel/softirq.o: In function `_local_bh_enable':
>> /home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:152:
>> undefined reference to `mcount'
>> kernel/softirq.o: In function `__local_bh_enable_ip':
>> /home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:159:
>> undefined reference to `mcount'
>> kernel/softirq.o: In function `do_softirq':
>> /home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:316:
>> undefined reference to `mcount'
>> kernel/softirq.o: In function `irq_enter':
>> /home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:337:
>> undefined reference to `mcount'
>> kernel/softirq.o: In function `irq_exit':
>> /home/ags/projects/toradex/imx/linux-vanilla-llvm/kernel/softirq.c:395:
>> undefined reference to `mcount'
>>
>> It seems that clang/LLVM uses a different mcount interface. However,
>> there is an option to use the gcc compatible symbol __gnu_mcount_nc when
>> using -meabi gnu. So adding
>> CFLAGS_ABI     +=-meabi gnu
>>
>> Builds the kernel successfully. However, the kernel crashes immediately
>> on boot. Even with earlyprintk enabled, I only get:
>>
>> Uncompressing Linux... done, booting the kernel.
>>
>> I poked a bit around in arch/arm/kernel/entry-ftrace.S. Not calling
>> __mcount in __gnu_mcount_nc produces a bootable kernel. Removing the
>> call into the ftrace logic by only using mcount_enter/exit in the
>> __mcount macro does not boot...
>>
>> I guess the mcount ABI is slightly different in LLVM/clang still then?
>> Before I dive deeper, maybe anyone has an idea?
>>
