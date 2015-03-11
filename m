From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 11 Mar 2015 17:52:27 +0100
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid
 crash on armada-xp
In-Reply-To: <54FF21BE.2040506@list.ru>
References: <54FF21BE.2040506@list.ru>
Message-ID: <20150311175227.499612af@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stas Sergeev,

On Tue, 10 Mar 2015 19:54:22 +0300, Stas Sergeev wrote:
> Hello, the patch below is needed for a successful boot on armada-xp.
> 
> 
> -=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-
> This fixes the following crash at boot:
> 
>  Unhandled fault: external abort on non-linefetch (0x808) at 0xf00ca018
>  Internal error: : 808 [#1] SMP ARM
> 
>  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc1 #3
>  Hardware name: Marvell Armada 370/XP (Device Tree)
>  task: ed41e800 ti: ed43e000 task.ti: ed43e000
>  PC is at _set_bit+0x28/0x50
>  LR is at n_tty_set_termios+0x328/0x358
>  pc : [<c01bc858>]    lr : [<c0207314>]    psr: 40000113
>  sp : ed43fd00  ip : 00000000  fp : 00000000
>  r10: 00000002  r9 : 00000000  r8 : ec930200
>  r7 : 00000000  r6 : f00ca018  r5 : f00ca000  r4 : ed69cc00
>  r3 : 00002000  r2 : 00002000  r1 : f00ca018  r0 : 00000000
>  Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>  Control: 10c5387d  Table: 0000406a  DAC: 00000015
>  Process swapper/0 (pid: 1, stack limit = 0xed43e220)
> 
> The offending instruction in _set_bit() is "strex r0, r2, [r1]"
> For some reason the exclusive access instructions do not like the
> vmalloc() space... While there may be another fix to make them
> fine about vmalloc() space, it still looks like a good idea to
> use kmalloc() for allocating a small (sub-page) struct.
> 
> Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>
> ---
>  drivers/tty/n_tty.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

No, this is not the right fix. The right fix is to upgrade your
bootloader to a non-buggy one.

Basically, the problem is that the memory information passed by the
bootloader to the kernel is not consistent with the MBus base address
which is the limit between RAM (below the MBus base address) and I/O
registers (above the MBus base address).

The bootloader tells the kernel that the RAM up to 0xf0000000 is
usable, but sets the MBus base address to 0xe0000000. So whenever the
kernel accesses 0xe0000000 -> 0xf0000000, it crashes, because you're
not hitting RAM but MBus windows (and there are most likely no MBus
window mapped in this space).

Since kmalloc() relies on the identity mapping, it happens to mainly
use pages at the beginning of the physical memory, which are OK. But
vmalloc() happens to start using pages at the end of the physical
memory (which are not part of the identity mapping), so that's why
you're seeing this on the first access to a vmalloc()ed area.

This problem has already been reported to Marvell and they have fixed
it in their U-Boot. Please upgrade your bootloader, since there is not
much the kernel can do about this: the bootloader is simply lying to
the kernel about the amount of memory that is accessible.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
