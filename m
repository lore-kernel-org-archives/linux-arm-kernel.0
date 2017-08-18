From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Aug 2017 16:35:31 +0100
Subject: [PATCH] arm64: kaslr: Adjust the offset to avoid Image across
 alignment boundary
In-Reply-To: <CAKv+Gu-Q_NZf9rGzUqVWt_7yhJ0ZpWZ8Lvu8i3T6z-z63iTsHw@mail.gmail.com>
References: <20170818150435.35224-1-catalin.marinas@arm.com>
 <20170818151920.jpugpcgwiavgwgaf@armageddon.cambridge.arm.com>
 <CAKv+Gu8kXLGNc+iGc8ERUfFR=po5tL7ZBaSrqH_fOzythkHA6Q@mail.gmail.com>
 <20170818152257.dbllbeuxwm5nugno@armageddon.cambridge.arm.com>
 <CAKv+Gu-Q_NZf9rGzUqVWt_7yhJ0ZpWZ8Lvu8i3T6z-z63iTsHw@mail.gmail.com>
Message-ID: <20170818153531.GA22970@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 04:24:46PM +0100, Ard Biesheuvel wrote:
> On 18 August 2017 at 16:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Aug 18, 2017 at 04:20:16PM +0100, Ard Biesheuvel wrote:
> >> On 18 August 2017 at 16:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > On Fri, Aug 18, 2017 at 04:04:34PM +0100, Catalin Marinas wrote:
> >> >> With 16KB pages and a kernel Image larger than 16MB, the current
> >> >> kaslr_early_init() logic for avoiding mappings across swapper table
> >> >> boundaries fails since increasing the offset by kimg_sz just moves the
> >> >> problem to the next boundary.
> >> >>
> >> >> This patch decreases the offset by the boundary overflow amount, with
> >> >> slight risk of reduced entropy as the kernel is more likely to be found
> >> >> at kimg_sz below a swapper table boundary.
> >> >>
> >> >> Trying-to-fix: afd0e5a87670 ("arm64: kaslr: Fix up the kernel image alignment")
> >> >> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> >> Cc: Will Deacon <will.deacon@arm.com>
> >> >> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> >> >> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> >> >> ---
> >> >>
> >> >> While preparing this email, I noticed that the kernel eventually failed
> >> >> to boot, though after a lot more reboot iterations. Mark Rutland also
> >> >> managed to make the KASLR kernel fail to boot with 64K pages which
> >> >> wouldn't be explained by this patch.
> >> >>
> >> >> So, any suggestions are welcome. My testing method, qemu starting a
> >> >> guest in a loop with virtio-rng-pci.
> >> >
> >> > Apparently, the booting gets much more stable if I disable the physical
> >> > relocation in arm64-stub.c (but keep the virtual one with the fix in
> >> > this patch). So I guess we are chasing two different issues.
> >>
> >> So this is using QEMU with 16k pages support?
> >
> > Qemu running on a ThunderX, so native KVM support.
> >
> 
> Ah ok. I did not realize QEMU supports 16 KB pages in that case. Nice!
> 
> However, that makes it rather difficult to reproduce on my side.

FWIW, I was testing with 64K pages, under QEMU+KVM on a SoftIrorn
OverDrive 1000 (i.e. a 4-core A57 system).

I'd hacked early_kaslr_init() so that I could override the seed on the
command line. I accidentally blatted that hack, but hopefully the below
is equivalent.

I had a script that iterated the seed in 2M increments, launch a VM for
each seed. The fileststem was configured to power down immediately once
it reached userspace.

I found that it hung with seed value: 0x0000000016c00000, which would
generate an offset of 0x17e00000. I tried nearby seeds, which worked:

  seed                  offset
  0x0000000016a00000    0x16a00000	worked
  0x0000000016c00000    0x17e00000	failed
  0x0000000016e00000    0x18000000	worked

... but I assume that failing values are dependent on the kernel Image
layout.

Thanks,
Mark.

---->8----
t a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index a9710ef..df50442 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -102,8 +102,8 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_offset)
         * Retrieve (and wipe) the seed from the FDT
         */
        seed = get_kaslr_seed(fdt);
-       if (!seed)
-               return 0;
+       //if (!seed)
+       //      return 0;

        /*
         * Check if 'nokaslr' appears on the command line, and
@@ -114,6 +114,12 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_offset)
        if (str == cmdline || (str > cmdline && *(str - 1) == ' '))
                return 0;

+       str = strstr(cmdline, "kaslr_seed=")
+       if (str) {
+               str += strlen("kaslr_seed=");
+               seed = simple_strtoull(str, NULL, 16);
+       }
+
        /*
         * OK, so we are proceeding with KASLR enabled. Calculate a suitable
         * kernel image offset from the seed. Let's place the kernel in the
