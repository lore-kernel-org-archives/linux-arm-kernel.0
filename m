From: metan@ucw.cz (Cyril Hrubis)
Date: Wed, 18 May 2011 23:47:44 +0200
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
Message-ID: <20110518214744.GA22034@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
I've applied this patch over 2.6.39-rc3 and did couple of suspends. After about
ten of them I've got attached trace (instead of the usuall NULL pointer
dereference in complete()).

And yes, the MMC is still broken after this change it seems that there are more
bugs in zaurus SPI drivers.

-- 
metan
-------------- next part --------------
PM: Syncing filesystems ... done.
mmc0: card 0002 removed
Freezing user space processes ... (elapsed 0.03 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.07 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
------------[ cut here ]------------
WARNING: at lib/kref.c:34 kref_get+0x20/0x44()
Modules linked in:
---[ end trace 435fc8b0048da5e9 ]---
sd 0:0:0:0: [sda] Stopping disk
------------[ cut here ]------------
WARNING: at lib/kref.c:34 kref_get+0x20/0x44()
Modules linked in:
---[ end trace 435fc8b0048da5ea ]---
PM: suspend of devices complete after 81.489 msecs
------------[ cut here ]------------
WARNING: at lib/kref.c:34 kref_get+0x20/0x44()
Modules linked in:
---[ end trace 435fc8b0048da5eb ]---
PM: late suspend of devices complete after 1.993 msecs
------------[ cut here ]------------
WARNING: at lib/kref.c:34 kref_get+0x20/0x44()
Modules linked in:
---[ end trace 435fc8b0048da5ec ]---
PM: early resume of devices complete after 728.029 msecs
------------[ cut here ]------------
WARNING: at lib/kref.c:34 kref_get+0x20/0x44()
Modules linked in:
---[ end trace 435fc8b0048da5ed ]---
sd 0:0:0:0: [sda] Starting disk
PM: resume of devices complete after 232.192 msecs
Restarting tasks ... done.
mmc0: error -95 whilst initialising SD card
PM: Syncing filesystems ... done.

haruka-chan login: root
kernel BUG at kernel/cred.c:171!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c399c000
[00000000] *pgd=a39ac831, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1] PREEMPT
last sysfs file: /sys/devices/platform/pxa2xx-spi.2/spi2.1/backlight/corgi_bl/brightness
Modules linked in:
CPU: 0    Tainted: G        W    (2.6.39-rc7-00259-g09c1ce4 #14)
PC is at __bug+0x18/0x24
LR is at __bug+0x14/0x24
pc : [<c00258bc>]    lr : [<c00258b8>]    psr: 40000013
sp : c3bc5f78  ip : 00000000  fp : bef2ea2c
r10: 00020000  r9 : c3bc4000  r8 : fffffffe
r7 : ffffff9c  r6 : c38d2d80  r5 : 00000000  r4 : c38d2d80
r3 : 00000000  r2 : c3bc5f6c  r1 : c02d6e9b  r0 : 00000027
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a399c000  DAC: 00000015
Process login (pid: 1105, stack limit = 0xc3bc4278)
Stack: (0xc3bc5f78 to 0xc3bc6000)
5f60:                                                       c38d2d80 c0054c2c
5f80: c38d2d80 c009c0e0 ffffff9c 400e6c14 00000000 00000001 00000000 00000021
5fa0: c0023184 c0023000 00000000 00000001 400e6c14 00000000 400f0f18 00000000
5fc0: 00000000 00000001 00000000 00000021 400f1000 400f1000 fffffdc8 bef2ea2c
5fe0: 00000000 bef2e9b8 400e0ed8 400e247c 60000010 400e6c14 00000000 00000000
Code: e1a01000 e59f000c eb08ff53 e3a03000 (e5833000)
Unable to handle kernel NULL pointer dereference at virtual address 00000002
pgd = c397c000
[00000002] *pgd=a3b71831, *pte=00000000, *ppte=00000000
Internal error: Oops: f3 [#2] PREEMPT
last sysfs file: /sys/devices/platform/pxa2xx-spi.2/spi2.1/backlight/corgi_bl/brightness
Modules linked in:
CPU: 0    Tainted: G      D W    (2.6.39-rc7-00259-g09c1ce4 #14)
PC is at kmem_cache_alloc+0x2c/0x78
LR is at scsi_pool_alloc_command+0x38/0x60
pc : [<c0099904>]    lr : [<c0172ed8>]    psr: 20000093
sp : c388bd88  ip : 00000000  fp : ec300000
r10: c38f0000  r9 : c38bd0b8  r8 : 00001000
r7 : 00000002  r6 : 00000020  r5 : a0000093  r4 : c3802100
r3 : c03c8018  r2 : 00000000  r1 : 00000020  r0 : c3802100
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0000397f  Table: a397c000  DAC: 00000017
Process sync_supers (pid: 139, stack limit = 0xc388a278)
Stack: (0xc388bd88 to 0xc388c000)
bd80:                   c0329330 c380fdc0 00000020 00000020 00001000 c0172ed8
bda0: c38bd000 00000020 c38bc800 c0172f38 c38bd000 c38bc800 c38bd0b8 c0173010
bdc0: c38bd000 c38bd0b8 c38bd0b8 c01730e4 00000000 c38f4a90 c38bd000 0000003f
bde0: 00001000 c0178834 c38f4a90 c38bd000 c393c340 c0181918 c380fd20 c38f80a4
be00: 00001000 c38f9638 c393c340 00000001 c38f4a90 c38f4ad8 00000007 c0117d64
be20: c38f4a90 c38f4a90 c38f4a90 c393c340 00000000 c393c340 c38bd0b8 00000008
be40: ec300000 c01197f8 c38bd000 c38bc800 c38bd024 c388a000 c393c340 c0177e44
be60: c393c340 c393c498 00012a00 c393c340 c3b1fc00 00000003 00000091 c393c340
be80: 00000001 00000008 ec300000 c0118060 c393c340 c011ad38 c393c340 c38f4a90
bea0: c3b1fc00 c388a000 c388beb8 00000000 c393c340 c0119150 c3896b00 c388a000
bec0: c388beec c0265b20 c388a000 c3854aa0 00011210 c388bef4 00000000 00000000
bee0: c3896b00 c3b1fc00 00000008 00000001 00000001 c0322fdc 00000000 00000000
bf00: 00000000 c01192d8 c388bf40 c3408000 c3854a60 00000091 00000010 00000001
bf20: 00000000 c00c85fc c3b1fc00 c00c86b4 00000010 0000000f c3408000 c3408000
bf40: c3b1fc00 00000091 00000001 c0322fdc 00000000 c00c3540 c3408000 00000091
bf60: 00000002 c00c6300 c38e6c00 c388a000 c3ffc400 c00f2750 00000001 c3ffc400
bf80: c38e6c00 c38e6c40 c0322fdc c00f27d8 c38e6c00 c388a000 00000000 c009efec
bfa0: c388a000 00000001 c388bfd4 c008103c 00000000 c0081070 c3831f78 00000000
bfc0: c388bfd4 c004f380 c0023890 00000000 00000000 00000000 c388bfd8 c388bfd8
bfe0: 00000000 c3831f78 c004f2fc c0023890 00000013 c0023890 0000074e 00000000
Code: e5903000 e5937000 e3570000 15902014 (17972002)
---[ end trace 435fc8b0048da5ee ]---
note: sync_supers[139] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at virtual address 00000002
pgd = c3b80000
[00000002] *pgd=a3b05831, *pte=00000000, *ppte=00000000
Internal error: Oops: f3 [#3] PREEMPT
last sysfs file: /sys/devices/platform/pxa2xx-spi.2/spi2.1/backlight/corgi_bl/brightness
Modules linked in:
CPU: 0    Tainted: G      D W    (2.6.39-rc7-00259-g09c1ce4 #14)
PC is at kmem_cache_alloc+0x2c/0x78
LR is at prepare_creds+0x24/0x8c
pc : [<c0099904>]    lr : [<c0054af4>]    psr: 20000093
sp : c3b39f60  ip : 0000397f  fp : bed7dfc4
r10: 00020000  r9 : c3b38000  r8 : 401ea280
r7 : 00000002  r6 : 000000d0  r5 : 40000013  r4 : c3802100
r3 : c03c8018  r2 : 00000000  r1 : 000000d0  r0 : c3802100
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3b80000  DAC: 00000015
Process syslogd (pid: 940, stack limit = 0xc3b38278)
Stack: (0xc3b39f60 to 0xc3b3a000)
9f60: 401fa000 c389fb80 000004b0 ffffff9c 401ea280 c0054af4 401fa000 00000000
9f80: 000004b0 c009bf90 ffffff9c 401ea280 401fa000 000002c8 000004b0 00000021
9fa0: c0023184 c0023000 401fa000 000002c8 401ea280 00000000 00000000 0000000d
9fc0: 401fa000 000002c8 000004b0 00000021 ffff0270 bed7df08 401fa4b0 bed7dfc4
9fe0: 401ea280 bed7d6c8 401cc30c 40185c7c 60000010 401ea280 00000000 00000000
Code: e5903000 e5937000 e3570000 15902014 (17972002)
---[ end trace 435fc8b0048da5ef ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000002
pgd = c3918000
[00000002] *pgd=a391d831, *pte=00000000, *ppte=00000000
Internal error: Oops: f3 [#4] PREEMPT
last sysfs file: /sys/devices/platform/pxa2xx-spi.2/spi2.1/backlight/corgi_bl/brightness
Modules linked in:
CPU: 0    Tainted: G      D W    (2.6.39-rc7-00259-g09c1ce4 #14)
PC is at kmem_cache_alloc+0x2c/0x78
LR is at prepare_creds+0x24/0x8c
pc : [<c0099904>]    lr : [<c0054af4>]    psr: 20000093
sp : c3831f60  ip : 0000397f  fp : 0000e704
r10: 00020000  r9 : c3830000  r8 : 0000e708
r7 : 00000002  r6 : 000000d0  r5 : 40000013  r4 : c3802100
r3 : c03c8018  r2 : 00000000  r1 : 000000d0  r0 : c3802100
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3918000  DAC: 00000015
Process init (pid: 1, stack limit = 0xc3830278)
Stack: (0xc3831f60 to 0xc3832000)
1f60: 00000008 c382e000 00000451 ffffff9c 0000e708 c0054af4 00000008 00000002
1f80: 00000451 c009bf90 ffffff9c 0000e708 00000008 0000e5c4 00000451 00000021
1fa0: c0023184 c0023000 00000008 0000e5c4 0000e708 00000002 00000451 00000008
1fc0: 00000008 0000e5c4 00000451 00000021 00000000 beff18c0 00000008 0000e704
1fe0: 00019724 beff1588 0000dc30 402fec7c 20000010 0000e708 00000000 00000000
Code: e5903000 e5937000 e3570000 15902014 (17972002)
---[ end trace 435fc8b0048da5f0 ]---
Kernel panic - not syncing: Attempted to kill init!
