From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Tue, 13 Mar 2018 01:44:14 +0530
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
Message-ID: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I remember we had a discussion on this topic some time ago, but I was
working on enabling KASLR support on arm64 boards internally and
wanted to check your opinion on the following points (especially to
understand if there are any changes in the opinions of the ARM
maintainers now):

A. Randomness / Seeding for arm64 kaslr:

- Currently the arm64 kernel requires a bootloader to provide entropy,
by passing a
 random u64 value in '/chosen/kaslr-seed' at kernel entry (please see [1])

- On platforms which support UEFI firmware, its the responsibility of
the UEFI firmware to implement EFI_RNG_PROTOCOL to supply the
'/chosen/kaslr-seed' property.

- I was wondering if we have any possibility to support a random seed
generation like the x86 in the efistub only rather than relying on the
UEFI firmwares with EFI_RNG_PROTOCOL for the same - for e.g. by using
a randomness seed like the boot time or more proper entropy sources
like arm64 system timer (see [2] for x86 example).

- I guess that the main problem is that most arm64 UEFI firmware
vendors still do not support EFI_RNG_PROTOCOL out of the box. We can
use the ChaosKey (see [3]) EFI driver and use this USB key as the
source of entropy on the arm64 systems for EFI firmwares which do not
provide a EFI_RNG_PROTOCOL implementation, but it might not be very
feasible to connect it to all boards in a production environment.

B. Regarding the arm64 kaslr support in kdump (I have Cc'ed AKASHI and
kexec list in this thread as well for their inputs), but currently we
don't seem to have a way to support kaslr in arm64 kdump kernel:

- '/chosen/kaslr-seed' a property is zeroed out in the primary kernel
(to avoid leaking out randomness secret), but how should this be then
handed over to the kdump kernel.
- We pass the dtb over to the kdump kernel for arm64 kdump, but the
'/chosen/kaslr-seed' property would be zeroed out already by the
primary kernel and the secondary would work in a *nokaslr* environment
due to the same (see [4] for example)

[1]. https://elixir.bootlin.com/linux/v4.9/source/arch/arm64/Kconfig#L906
[2]. https://github.com/torvalds/linux/blob/master/arch/x86/lib/kaslr.c#L49
[3]. https://github.com/bhupesh-sharma/edk2-platforms/tree/master/Silicon/Openmoko/ChaosKeyDxe
[4]. https://elixir.bootlin.com/linux/v4.12.9/source/arch/arm64/kernel/kaslr.c#L104

Please share your views.

Regards,
Bhupesh
