From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 25 Jul 2014 12:29:46 +0100
Subject: Kexec on arm64
In-Reply-To: <CAFdej02Ty82_0BHFqizbs2DWr5mC5KWjq8CdcPemsayGM9pjjg@mail.gmail.com>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <CAFdej02Ty82_0BHFqizbs2DWr5mC5KWjq8CdcPemsayGM9pjjg@mail.gmail.com>
Message-ID: <20140725112946.GA19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 11:26:46AM +0100, Arun Chandran wrote:
> On Thu, Jul 24, 2014 at 3:06 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jul 24, 2014 at 01:38:07AM +0100, Geoff Levand wrote:
> >> Hi Arun,
> >>
> >> On Tue, 2014-07-22 at 18:55 +0530, Arun Chandran wrote:
> >>
> >> > I tried the same dtb with UP configuration. For UP kernel to compile
> >> > did the below modifications
> >>
> >> I'll test and fixup the kexec UP build in the next few days.
> >>
> >> ...
> >>
> >> > With the default target configuration "kexec -e" failed to execute
> >> > in UP scenario also.
> >
> > It would be helpful to know _how_ it failed. Do you have any log output?
> >
> >> >
> >> > But I had some luck when I did the same steps with L3 cache
> >> > disabled. According to http://www.spinics.net/lists/arm-kernel/msg329541.html
> >> > it has an L3 cache. Luckily I was able to disable it in u-boot.
> >> >
> >> > With the L3 cache disabled configuration I am able to
> >> > do "kexec -e". Please see the log attached.
> >
> > Hmm. We don't expect the kernel to do any L3 management. It seems that
> > memory subsystems with L3 caches respecting cache maintenance by VA are
> > going to become relatively common, and we expect to handle them all by
> > performing maintenance by VA. See commit c218bca74eea (arm64: Relax the
> > kernel cache requirements for boot) for what we do at boot time.
> >
> >>
> >> All memory management for the main cpu is done by the arch code.  Kexec
> >> and cpu hot plug only work with the secondary cpus, so the problem would
> >> be in the arch memory code, either in setup_restart() for shutdown, or
> >> in the startup code.
> >
> > It's possible that soft_restart and setup_restart are a little dodgy, as
> > they also rely on the compiler being smart and not touching the stack
> > after setup_restart().
> >
> Could you please explain why this is required?

It's a requirement because we have no guarantee that the stack (or any
other memory addresses) will be flushed out to the PoC and become
visible to non-cacheable accesses.

Any use of the stack after we disable the d-cache is a bug. If you need
a VA range visible to non-cacheable accesses (i.e. after the cache is
disabled), you must flush that range to the PoC by VA.

The kernel text _should_ be out at the PoC per the boot protocol
requirements, so we don't have to flush it to execute correctly unless
we've performed some kernel text patching.

Arguably the first __flush_dcache_all call here is unnecessary; it
doesn't provide any guarantee we can rely on. The __flush_dcache_all
_after_ disabling the caches will ensure that the local caches are empty
(avoiding unexpected hits for non-cacheable accesses).

> 
> This is my disassembled output of  soft_restart()
> With the latest code from
> https://git.linaro.org/people/geoff.levand/linux-kexec.git
> 
> ffffffc000085014 <soft_restart>:
> ffffffc000085014:       a9be7bfd        stp     x29, x30, [sp,#-32]!
> ffffffc000085018:       910003fd        mov     x29, sp
> ffffffc00008501c:       f9000fa0        str     x0, [x29,#24]
> ffffffc000085020:       94003c49        bl      ffffffc000094144
> <setup_mm_for_reboot>
> ffffffc000085024:       94003a6b        bl      ffffffc0000939d0
> <flush_cache_all>
> ffffffc000085028:       94003cde        bl      ffffffc0000943a0 <cpu_cache_off>
> ffffffc00008502c:       94003a69        bl      ffffffc0000939d0
> <flush_cache_all>
> ffffffc000085030:       90006201        adrp    x1, ffffffc000cc5000
> <reset_devices>
> ffffffc000085034:       f9400fa0        ldr     x0, [x29,#24]
> ffffffc000085038:       f940fc22        ldr     x2, [x1,#504]
> ffffffc00008503c:       f0000061        adrp    x1, ffffffc000094000
> <arch_pick_mmap_layout+0x150>
> ffffffc000085040:       910f0021        add     x1, x1, #0x3c0
> ffffffc000085044:       8b010041        add     x1, x2, x1
> ffffffc000085048:       d2c00802        mov     x2, #0x4000000000
>          // #274877906944
> ffffffc00008504c:       8b020021        add     x1, x1, x2
> ffffffc000085050:       d63f0020        blr     x1
> ffffffc000085054:       f0002940        adrp    x0, ffffffc0005b0000
> <kallsyms_token_table+0x200>
> ffffffc000085058:       f0002941        adrp    x1, ffffffc0005b0000
> <kallsyms_token_table+0x200>
> ffffffc00008505c:       90002143        adrp    x3, ffffffc0004ad000
> <__start_rodata>
> ffffffc000085060:       91128000        add     x0, x0, #0x4a0
> ffffffc000085064:       913de021        add     x1, x1, #0xf78
> ffffffc000085068:       52800c22        mov     w2, #0x61
>          // #97
> ffffffc00008506c:       91072063        add     x3, x3, #0x1c8
> ffffffc000085070:       941071d0        bl      ffffffc0004a17b0 <printk>
> ffffffc000085074:       f0002940        adrp    x0, ffffffc0005b0000
> <kallsyms_token_table+0x200>
> ffffffc000085078:       91134000        add     x0, x0, #0x4d0
> ffffffc00008507c:       9410712c        bl      ffffffc0004a152c <panic>
> 
> If I single step the code,
> 
> This is how my stack looks like @ffffffc00008501c
> CPU#0>mdd 0xffffffc3eb83fcf0
> ffffffc3_eb83fcf0 : ffffffc3eb83fd10  ........
> ffffffc3_eb83fcf8 : ffffffc000092778  ......'x
> ffffffc3_eb83fd00 : ffffffc000cc9f70  .......p
> ffffffc3_eb83fd08 : 00000043eae32000  ...C.. .
> ffffffc3_eb83fd10 : ffffffc3eb83fd70  .......p
> ffffffc3_eb83fd18 : ffffffc0000fc018  ........
> ffffffc3_eb83fd20 : ffffffc000c95000  ......P.
> ffffffc3_eb83fd28 : 0000000000000000  ........
> ffffffc3_eb83fd30 : ffffffc000cd06a0  ........
> ffffffc3_eb83fd38 : 0000000000000000  ........
> ffffffc3_eb83fd40 : 0000000080000000  ........
> ffffffc3_eb83fd48 : 0000000000000015  ........
> ffffffc3_eb83fd50 : 0000000000000115  ........
> ffffffc3_eb83fd58 : 000000000000008e  ........
> ffffffc3_eb83fd60 : ffffffc000c8b000  ........
> ffffffc3_eb83fd68 : ffffffc3eb83c000  ........
> 
> And this is how it looks like @ffffffc000085030
> CPU#0>mdd 0xffffffc3eb83fcf0
> ffffffc3_eb83fcf0 : 0000000000000115  ........
> ffffffc3_eb83fcf8 : 000000000000003f  .......?
> ffffffc3_eb83fd00 : ffffffc3eb83fd30  .......0
> ffffffc3_eb83fd08 : ffffffc000120360  .......`
> ffffffc3_eb83fd10 : 0000000000000002  ........
> ffffffc3_eb83fd18 : ffffffbcedb611c0  ........
> ffffffc3_eb83fd20 : ffffffbcedb611c0  ........
> ffffffc3_eb83fd28 : ffffffc3eae08000  ........
> ffffffc3_eb83fd30 : ffffffc3000200d0  ........
> ffffffc3_eb83fd38 : ffffffc000120708  ........
> ffffffc3_eb83fd40 : 0000000000000000  ........
> ffffffc3_eb83fd48 : 72a00040528f8fe0  r.. at R...
> ffffffc3_eb83fd50 : 540002a16a00003f  T...j..?
> ffffffc3_eb83fd58 : 3627fe60f8538260  6'.`.S.`
> ffffffc3_eb83fd60 : 97fff80daa1303e0  ........
> ffffffc3_eb83fd68 : 97fc01ffaa1403e0  ........
> 
> It is clearly getting corrupted.

No it is not getting corrupted.

At ffffffc00008501c the CPU's cache is enabled (i.e. the CPU can make
cacheable accesses). The stack is normal cacheable (WBWA) memory, so
accesses will look-up and allocate in the cache. As the stack is being
accessed often it is warm, and the cache hierarchy does not decide to
evict it and/or write-back to the next level of the cache hierarchy.

At ffffffc000085030 the cache is disabled (i.e. the CPU cannot make
cacheable accesses). The effective attributes for the stack are
non-cacheable, so the CPU will bypass the cache hierarchy and go
straight to the PoC when it tried to read stack addresses. As we have
not flushed the stack by VA, (dirty) cachelines covering the stack might
be anywhere in the cache hierarchy, and aren't guaranteed to have
reached to PoC.

So the CPU reads _stale_ data from the PoC. There is no corruption; the
cache lines are still valid somewhere (we never invalidated them without
cleaning them first), but are simply not visible to non-cacheable
accesses.

Are we actually accessing the stack? If not, then there's no need to
worry. If we are, then the code which is doing so is buggy and either
needs to flush the stack by VA to the PoC, or (better) not use the stack
in this case and just use registers.

Does that all make sense? Or do I need to get my ascii-art paintbrush
out?

> 
> Now with keeping caches on
> ######
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 786daa6..6ff3d9f 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -76,10 +76,10 @@ static void setup_restart(void)
>         flush_cache_all();
> 
>         /* Turn D-cache off */
> -       cpu_cache_off();
> +       //cpu_cache_off();
> 
>         /* Push out any further dirty data, and ensure cache is empty */
> -       flush_cache_all();
> +       //flush_cache_all();
>  }
> 
>  void soft_restart(unsigned long addr)
> #######
> 
> ffffffc000085014 <soft_restart>:
> ffffffc000085014:       a9be7bfd        stp     x29, x30, [sp,#-32]!
> ffffffc000085018:       910003fd        mov     x29, sp
> ffffffc00008501c:       f9000fa0        str     x0, [x29,#24]
> ffffffc000085020:       94003c49        bl      ffffffc000094144
> <setup_mm_for_reboot>
> ffffffc000085024:       94003a6b        bl      ffffffc0000939d0
> <flush_cache_all>
> ffffffc000085028:       90006201        adrp    x1, ffffffc000cc5000
> <reset_devices>
> ffffffc00008502c:       f9400fa0        ldr     x0, [x29,#24]
> ffffffc000085030:       f940fc22        ldr     x2, [x1,#504]
> ffffffc000085034:       f0000061        adrp    x1, ffffffc000094000
> <arch_pick_mmap_layout+0x150>
> ffffffc000085038:       910f0021        add     x1, x1, #0x3c0
> ffffffc00008503c:       8b010041        add     x1, x2, x1
> ffffffc000085040:       d2c00802        mov     x2, #0x4000000000
>          // #274877906944
> ffffffc000085044:       8b020021        add     x1, x1, x2
> ffffffc000085048:       d63f0020        blr     x1
> ffffffc00008504c:       f0002940        adrp    x0, ffffffc0005b0000
> <kallsyms_token_table+0x200>
> ffffffc000085050:       f0002941        adrp    x1, ffffffc0005b0000
> <kallsyms_token_table+0x200>
> ffffffc000085054:       90002143        adrp    x3, ffffffc0004ad000
> <__start_rodata>
> ffffffc000085058:       91128000        add     x0, x0, #0x4a0
> ffffffc00008505c:       913de021        add     x1, x1, #0xf78
> ffffffc000085060:       52800c22        mov     w2, #0x61
>          // #97
> ffffffc000085064:       91072063        add     x3, x3, #0x1c8
> ffffffc000085068:       941071d2        bl      ffffffc0004a17b0 <printk>
> ffffffc00008506c:       f0002940        adrp    x0, ffffffc0005b0000
> <kallsyms_token_table+0x200>
> ffffffc000085070:       91134000        add     x0, x0, #0x4d0
> ffffffc000085074:       9410712e        bl      ffffffc0004a152c <panic>
> 
> Now my stack @ffffffc00008501c and @ffffffc000085028 are same.

Sure, with the caches on you have the guarantee that prior writes are
still visible.

You either need to perform maintenance by VA to make the stack visible,
or (better) don't access memory once the cache is disabled. Just load
everything you need into registers in advance.

Thanks,
Mark.
