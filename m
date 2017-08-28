From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 28 Aug 2017 12:55:23 -0700
Subject: ARM64 kernel Image size limitations?
Message-ID: <02d56481-bba0-fd32-17d8-9f3760d09148@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have been fighting with a reasonably large kernel Image: 46MB and
found unable to boot it. This is on v4.13-rc6, but I could go back as
far as v4.9~ish. It is so big, because it's got some debugging enabled,
and the initramfs compression is disabled, but still that ought to be
possible.

After some experimentation I found that the breaking size is somewhere
around 33MB total for arch/arm64/boot/Image and when that happens, I get
the following backtrace which suggests that there is some memory
corruption of some kind (or so it seems to me), other experiments
indicated that the backtrace may point back to where the bootloader had
set up its exception vector. I am fairly confident that the bootloader
is not responsible for corrupting the Image that is loaded.

Is there such a size limitation or am I possibly tripping over something
else?

(gdb) bt
#0  0xffffff800880721c in arch_spin_lock (lock=<optimized out>)
    at ./arch/arm64/include/asm/spinlock.h:89
#1  do_raw_spin_lock_flags (flags=<optimized out>, lock=<optimized out>)
    at ./include/linux/spinlock.h:155
#2  __raw_spin_lock_irqsave (lock=<optimized out>)
    at ./include/linux/spinlock_api_smp.h:119
#3  _raw_spin_lock_irqsave (lock=0xffffff800a1100f8)
    at kernel/locking/spinlock.c:159
#4  0xffffff80080888b4 in die (str=0xffffff800894a490 "Oops",
    regs=0xffffff800a013630, err=-1778384892) at
arch/arm64/kernel/traps.c:279
#5  0x80ffffff080952c4 in ?? ()
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
(gdb) info reg
x0             0xffffff800a1100f8       18446743524122624248
x1             0x1c0    448
x2             0x10000  65536
x3             0x1      1
x4             0x0      0
x5             0xffffff8008857dc8       18446743524096703944
x6             0xffffff800a00494f       18446743524121528655
x7             0x6572646461206c65       7310015527464758373
x8             0x65676e6172207373       7306930285237531507
x9             0x0      0
x10            0xffffff800a0134e0       18446743524121588960
x11            0xffffff800a0134e0       18446743524121588960
x12            0x40d00  265472
x13            0x72422820352e382e       8233187187582973998
x14            0x73206d6f6364616f       8295750838792773999
x15            0x0      0
x16            0x0      0
x17            0x0      0
x18            0x0      0
x19            0xffffff800a110000       18446743524122624000
x20            0x96000004       2516582404
x21            0xffffff800894a490       18446743524097696912
x22            0xffffff800a013630       18446743524121589296
x23            0xffffff800a013630       18446743524121589296
x24            0x25     37
x25            0xffffff800a018000       18446743524121608192
x26            0xffffff8008955622       18446743524097742370
x27            0xffffff8008955622       18446743524097742370
x28            0xffffff800a01dd80       18446743524121632128
x29            0xffffff800a0134d0       18446743524121588944
x30            0xffffff80080888b4       18446743524088514740
sp             0xffffff800a0134d0       0xffffff800a0134d0
pc             0xffffff800880721c       0xffffff800880721c
<_raw_spin_lock_irqsave+44>
CPSR           0x600001c5       1610613189
(gdb)

-- 
Florian
