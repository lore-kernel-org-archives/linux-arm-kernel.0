From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 28 Jul 2014 16:38:12 +0100
Subject: Kexec on arm64
In-Reply-To: <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
References: <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
Message-ID: <20140728153812.GA2576@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 04:00:18PM +0100, Arun Chandran wrote:
> Hi Geoff
> 
> On Sat, Jul 26, 2014 at 5:48 AM, Geoff Levand <geoff@infradead.org> wrote:
> > Hi Arun,
> >
> > On Fri, 2014-07-25 at 17:18 +0530, Arun Chandran wrote:
> >> I got this working. As 'Mark Rutland' pointed in another mail that
> >> it could be problem with flushing the cache; I did a read of
> >> 1GB data from start of RAM to a volatile var. I assume that
> >> this will clear and invalidate all that in cache (L1=32K, L2=256 K, L3=8M)
> >
> > I wasn't flushing out all the data used by relocate_new_kernel.  I added
> > a routine that should flush all the pages in the kimage list out to PoC.
> > Please try a UP build with L3 enabled.
> >
> 
> Yes I verified this new kernel by stopping just before jumping to the
> kexeced kernel and taking the memory dump for the kernel
> and dtb.
> 
> CPU#0>dump 0x0000004000080000 0x7F2000 uImage
> CPU#0>rd
> GPR00: 0000004000880000 0000000000000000 0000000000000000 0000000000000000
> GPR04: 0000004000080004 000000000000001b 0000000000000000 ffffffffffffffff
> GPR08: 0000000000000020 ffffffffffffffff 0000000000000004 0000000000000002
> GPR12: 00000043ea439fd8 0000004000883000 00000043ea631000 ffffffffffffffff
> GPR16: ffffffc0000cc31c 0000000000435260 0000007fe9328b90 00000043eaddc002
> GPR20: 0000004000883000 00000043ea632000 0000000000000000 0000000000000000
> GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR28: 0000000000000000 0000000000000000 ffffffc000085074 ffffffc3eae53d00
> 
> And compared this image with the one taken after booting with
> my working one(The one with 1GB read of RAM). Both are Identical.
> That means kexec code now flushes data properly. Note that in both
> cases I used the same secondary kernel.
> 
> But It fails to boot kexeced kernel. If I break the target I can see
> CPU#0>h
>     Core number       : 0
>     Core state        : debug (AArch64 EL1)
>     Debug entry cause : External Debug Request
>     Current PC        : 0xffffffc000083200
>     Current CPSR      : 0x600003c5 (EL1h)
> 
> 
> So I guess there may be something wrong with
> the booting of kernel.
> 
> I have these changes to the code.
> 1)
> #########
> diff --git a/arch/arm64/kernel/machine_kexec.c
> b/arch/arm64/kernel/machine_kexec.c
> index 00cfbd6..da3672b 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -684,7 +691,7 @@ void machine_kexec(struct kimage *image)
>         /* Flush the reboot_code_buffer in preparation for its execution. */
> 
>         flush_icache_range((unsigned long)reboot_code_buffer,
> -               relocate_new_kernel_size);
> +               (unsigned long)(reboot_code_buffer + relocate_new_kernel_size));
> 
>         /*
>          * Flush any data used by relocate_new_kernel in preparation for
> #########
> Passing of second variable to flush_icache_range() is wrong
> it expects an address not length.

A simpler option would be to nuke the entire icache before branching to
the new image.

> 
> 2)
> 
> #######
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 9ed7327..e3fc8d6 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> 
> @@ -84,12 +91,17 @@ void soft_restart(unsigned long addr)
>  {
>         typedef void (*phys_reset_t)(unsigned long);
>         phys_reset_t phys_reset;
> +       unsigned long jump_addr = addr;
> +
> +       phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
> +
> +       __flush_dcache_area(&jump_addr, 8);
> +       __flush_dcache_area(&phys_reset, 8);

Are these values really not getting stashed in registers?

If the compiler is spilling, then we have absolutely no guarantee about
any part of the stack. If that's the case, then we can't use the stack
at all. These need to be rewritten in asm if the compiler is spilling.

Thanks,
Mark.

> 
>         setup_restart();
> 
>         /* Switch to the identity mapping */
> -       phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
> -       phys_reset(addr);
> +       phys_reset(jump_addr);
> 
>         /* Should never get here */
>         BUG();
> ########
> 
> Without this flushing it will jump to wrong addr.
> 
> --Arun
> 
