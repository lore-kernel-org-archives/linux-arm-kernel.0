From: stripathi@apm.com (Suman Tripathi)
Date: Thu, 30 Jul 2015 21:43:57 +0530
Subject: arch/arm/kernel/setup.c does not compile at -O0
In-Reply-To: <20150730155048.GS7557@n2100.arm.linux.org.uk>
References: <55BA1E62.9080103@free.fr>
 <CAOHikRBW+OnYvduFMVnssYAxDP4u+E+Q9NJ+5iDhnc21OvFRpg@mail.gmail.com>
 <20150730155048.GS7557@n2100.arm.linux.org.uk>
Message-ID: <CAOHikRBe=e7UMuEdbs8KhCc59MxhOP2DGwQVMOhtC6VmJW2JBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 9:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 30, 2015 at 08:53:45PM +0530, Suman Tripathi wrote:
>> Hi,
>>
>> On Thu, Jul 30, 2015 at 6:23 PM, Mason <slash.tmp@free.fr> wrote:
>> >
>> > Hello everyone,
>> >
>> > I'm trying to debug a live kernel (v3.14) using a DS-5 JTAG probe.
>> >
>> > In order to make the control flow easier to follow, I disabled
>> > optimizations by adding
>> >
>> >   subdir-ccflags-y := -O0
>> >
>> > to arch/arm/kernel/Makefile
>> >
>> > With that change, linking fails:
>> >
>> > arch/arm/kernel/setup.c:924: undefined reference to `psci_smp_ops'
>> >
>> >       if (psci_smp_available())
>> >         smp_set_ops(&psci_smp_ops);
>> >
>> > #ifdef CONFIG_ARM_PSCI
>> > void psci_init(void);
>> > bool psci_smp_available(void);
>> > #else
>> > static inline void psci_init(void) { }
>> > static inline bool psci_smp_available(void) { return false; }
>> > #endif
>> >
>> > The optimizer is able to remove the entire block, but this
>> > does not happen when optimizations are disabled.
>> >
>> > Is compiling at -O0 not supported?
>>
>> If you have inline functions, it won't compile at -O0
>
> That's incorrect.
>
> If you have static inline functions, there isn't a problem irrespective
> of optimisation level - they'll become merely static functions which
> won't be inlined, and you'll end up with a copy of the function per
> compilation unit.
>
> If you have extern inline functions, they also won't be inlined, but
> unlike static inline, the compiler won't emit a static function.
> Instead, the compiler expects the function to be provided via another
> compilation unit or library (which won't happen in the Linux kernel.)
> However, Linux kernel coding style does not allow the use of extern
> inline functions.
>
> The problem which the Linux kernel has is that we rely on the compiler
> performing optimisations in multiple places - such as eliminating code
> which can't be reached.  Disabling the optimiser prevents such
> eliminations from happening, and ends up leaving symbols behind which
> are purposely not-defined (which are so in order to detect errors for
> accessors like get_user(), etc. which are only defined to operate on
> 1, 2, 4 and maybe 8 byte values.)
>
> For example:
>
> #define __put_user_check(x, p)                                          \
>         ({                                                              \
>                 unsigned long __limit = current_thread_info()->addr_limit - 1; \                const typeof(*(p)) __user *__tmp_p = (p);               \
>                 register const typeof(*(p)) __r2 asm("r2") = (x);       \
>                 register const typeof(*(p)) __user *__p asm("r0") = __tmp_p; \
>                 register unsigned long __l asm("r1") = __limit;         \
>                 register int __e asm("r0");                             \
>                 switch (sizeof(*(__p))) {                               \
>                 case 1:                                                 \
>                         __put_user_x(__r2, __p, __e, __l, 1);           \
>                         break;                                          \
>                 case 2:                                                 \
>                         __put_user_x(__r2, __p, __e, __l, 2);           \
>                         break;                                          \
>                 case 4:                                                 \
>                         __put_user_x(__r2, __p, __e, __l, 4);           \
>                         break;                                          \
>                 case 8:                                                 \
>                         __put_user_x(__r2, __p, __e, __l, 8);           \
>                         break;                                          \
>                 default: __e = __put_user_bad(); break;                 \
>                 }                                                       \
>                 __e;                                                    \
>         })
>
> which relies on the optimiser removing all the cases which don't apply to
> the access size.  Disabling optimisation prevents that happening, so you
> end up with the entire switch() statement coded in the output assembly
> for every invocation of this macro - which includes a call to
> __put_user_bad() just in case sizeof(*__p) changes unexpectedly.
>
> Building the kernel with optimisation disabled is not supported.

Thanks for the info Russell !!

>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.



-- 
Thanks,
with regards,
Suman Tripathi
