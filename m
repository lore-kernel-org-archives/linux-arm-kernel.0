From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 23 Dec 2015 16:52:51 -0800
Subject: arm64 qemu tests failing in linux-next since 'arm64: kernel: enforce
 pmuserenr_el0 initialization and restore'
Message-ID: <567B41E3.5060800@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

since commit 60792ad349f3 ("arm64: kernel: enforce pmuserenr_el0 initialization
and restore"), my arm64 qemu tests of linux-next are failing. After this commit,
qemu does not display any output.

Qemu version is 2.5.0. Linux kernel configuration is arm64:defconfig.

qemu command line is as follows:

	qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=virt -nographic -smp 1 \
		-m 512 -kernel arch/arm64/boot/Image -initrd rootfs.arm64.cpio -no-reboot \
		-append "console=ttyAMA0"

Any idea what might cause this problem and how to fix it (presumably in qemu) ?

Bisect log is attached below. Reverting commit 60792ad349f3 on top of linux-next
fixes the problem.

Thanks,
Guenter

---
# bad: [80c75a0f1d81922bf322c0634d1e1a15825a89e6] Add linux-next specific files for 20151223
# good: [4ef7675344d687a0ef5b0d7c0cee12da005870c0] Linux 4.4-rc6
git bisect start 'HEAD' 'v4.4-rc6'
# bad: [52c8be920db8e42d195ca7fe93fe31aa9958100e] Merge remote-tracking branch 'drm/drm-next'
git bisect bad 52c8be920db8e42d195ca7fe93fe31aa9958100e
# bad: [ef1ebde6af4d839a07d787440e35f0ae3b02e567] Merge remote-tracking branch 'v4l-dvb/master'
git bisect bad ef1ebde6af4d839a07d787440e35f0ae3b02e567
# bad: [1e4012d4f91fd118167f14c4172bf779a7884d26] Merge remote-tracking branch 'tegra/for-next'
git bisect bad 1e4012d4f91fd118167f14c4172bf779a7884d26
# good: [392fd3291c93094ca65853cca5e168016c4e08b1] Merge branch 'next/dt64' into for-next
git bisect good 392fd3291c93094ca65853cca5e168016c4e08b1
# bad: [49fc6d2449b0cebd9738694a9c9ee794c3686797] Merge remote-tracking branch 'omap/for-next'
git bisect bad 49fc6d2449b0cebd9738694a9c9ee794c3686797
# bad: [f5a47ef34509cbce244c18bef02b175d0e48dc4f] Merge remote-tracking branch 'at91/at91-next'
git bisect bad f5a47ef34509cbce244c18bef02b175d0e48dc4f
# good: [59f8d523983105e8490603ae1c0798207e9781e6] Merge remote-tracking branch 'arc/for-next'
git bisect good 59f8d523983105e8490603ae1c0798207e9781e6
# good: [40499303a6c59c96da587a91fca617017106e908] Merge branch 'next/defconfig' into for-next
git bisect good 40499303a6c59c96da587a91fca617017106e908
# good: [ea07b401d16052b43782c6389c9c2115aa3077ff] Merge branches 'component' and 'misc' into for-next
git bisect good ea07b401d16052b43782c6389c9c2115aa3077ff
# bad: [5d7ee87708d4d86fcc32afc9552d05f7625d303d] arm64: perf: add support for Cortex-A72
git bisect bad 5d7ee87708d4d86fcc32afc9552d05f7625d303d
# good: [9e9caa6a496174e53d7753baa4779717771da4a7] arm64: perf: Add event descriptions
git bisect good 9e9caa6a496174e53d7753baa4779717771da4a7
# bad: [60792ad349f3c6dc5735aafefe5dc9121c79e320] arm64: kernel: enforce pmuserenr_el0 initialization and restore
git bisect bad 60792ad349f3c6dc5735aafefe5dc9121c79e320
# good: [aae881ad73460e1b2aea01f079a0541bd5a9136c] arm64: perf: Correct Cortex-A53/A57 compatible values
git bisect good aae881ad73460e1b2aea01f079a0541bd5a9136c
# first bad commit: [60792ad349f3c6dc5735aafefe5dc9121c79e320] arm64: kernel: enforce pmuserenr_el0 initialization and restore
