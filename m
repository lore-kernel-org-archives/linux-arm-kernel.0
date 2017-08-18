From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Aug 2017 16:33:37 +0100
Subject: [PATCH] arm64: kaslr: Adjust the offset to avoid Image across
 alignment boundary
In-Reply-To: <CAKv+Gu_LR_cAccT-osai3yMTML_kq8_1Meb5RhR+iVxwrmaH3Q@mail.gmail.com>
References: <20170818150435.35224-1-catalin.marinas@arm.com>
 <20170818151920.jpugpcgwiavgwgaf@armageddon.cambridge.arm.com>
 <CAKv+Gu8kXLGNc+iGc8ERUfFR=po5tL7ZBaSrqH_fOzythkHA6Q@mail.gmail.com>
 <20170818152257.dbllbeuxwm5nugno@armageddon.cambridge.arm.com>
 <CAKv+Gu-Q_NZf9rGzUqVWt_7yhJ0ZpWZ8Lvu8i3T6z-z63iTsHw@mail.gmail.com>
 <CAKv+Gu_LR_cAccT-osai3yMTML_kq8_1Meb5RhR+iVxwrmaH3Q@mail.gmail.com>
Message-ID: <20170818153336.jik2xn753cpbllrl@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 04:29:44PM +0100, Ard Biesheuvel wrote:
> On 18 August 2017 at 16:24, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 18 August 2017 at 16:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> On Fri, Aug 18, 2017 at 04:20:16PM +0100, Ard Biesheuvel wrote:
> >>> On 18 August 2017 at 16:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>> > On Fri, Aug 18, 2017 at 04:04:34PM +0100, Catalin Marinas wrote:
> >>> >> With 16KB pages and a kernel Image larger than 16MB, the current
> >>> >> kaslr_early_init() logic for avoiding mappings across swapper table
> >>> >> boundaries fails since increasing the offset by kimg_sz just moves the
> >>> >> problem to the next boundary.
> >>> >>
> >>> >> This patch decreases the offset by the boundary overflow amount, with
> >>> >> slight risk of reduced entropy as the kernel is more likely to be found
> >>> >> at kimg_sz below a swapper table boundary.
> >>> >>
> >>> >> Trying-to-fix: afd0e5a87670 ("arm64: kaslr: Fix up the kernel image alignment")
> >>> >> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> >> Cc: Will Deacon <will.deacon@arm.com>
> >>> >> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> >>> >> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> >>> >> ---
> >>> >>
> >>> >> While preparing this email, I noticed that the kernel eventually failed
> >>> >> to boot, though after a lot more reboot iterations. Mark Rutland also
> >>> >> managed to make the KASLR kernel fail to boot with 64K pages which
> >>> >> wouldn't be explained by this patch.
> >>> >>
> >>> >> So, any suggestions are welcome. My testing method, qemu starting a
> >>> >> guest in a loop with virtio-rng-pci.
> >>> >
> >>> > Apparently, the booting gets much more stable if I disable the physical
> >>> > relocation in arm64-stub.c (but keep the virtual one with the fix in
> >>> > this patch). So I guess we are chasing two different issues.
> >>>
> >>> So this is using QEMU with 16k pages support?
> >>
> >> Qemu running on a ThunderX, so native KVM support.
> >
> > Ah ok. I did not realize QEMU supports 16 KB pages in that case. Nice!
> >
> > However, that makes it rather difficult to reproduce on my side.

As I said, we triggered it with 64K pages. Mark R is following up
shortly.

> Are you booting with an initrd?

No, just:

qemu-system-aarch64 \
	-s \
	-machine virt,accel=kvm,gic_version=3 \
	-smp 1 -m 8192 \
	-cpu $CPU \
	-kernel $IMAGE \
	-semihosting \
	-nographic -serial mon:stdio \
	-monitor tcp:0.0.0.0:4000,server,nowait \
	-netdev user,id=net0 -device virtio-net-device,netdev=net0 \
	-bios /usr/share/qemu-efi/QEMU_EFI.fd \
	-device virtio-rng-pci \
	-append "$CONSOLE $ROOT init=/sbin/poweroff -f"

-- 
Catalin
