From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 2 Feb 2016 18:59:22 +0000
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <HKXPR06MB0565A2CFF95AD7C000F43E6A8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Feb 2016, Ard Biesheuvel wrote:

> This series applies on top of today's -next, and addresses an issue 
> with the new kallsyms code that is queued there, that enables base 
> relative kallsyms tables for all architectures (except IA-64)
> 
> Two issues have surfaced on ARM with the new kallsyms code:
> a) CONFIG_HAVE_TCM creates a virtual region that is too far away for the
>    relative kallsyms code to reach it;
> b) CONFIG_XIP_KERNEL=y kernel symbols are not filtered against PAGE_OFFSET,
>    as is the case for kernels that execute from RAM, resulting in symbols
>    that are out of range.


For whatever it's worth:


I applied my XIP_KERNEL fixes (for ARMv7) on top of -next and attempted to boot which resulted in a flood of these:

  "Unable to handle kernel NULL pointer dereference at virtual address 00000000"

and of course it dies.


I then applied the 3 patches and tried again and this time it booted up....almost.
It looks like it makes it all the way up to when it is going to mount my rootfs, but then dies.

My kernel (.text) starts at 0xbf000000 (MODULES_VADDR), so the "LR is at 0xb6f87e88" is obviously bad.


Chris



================ boot log ======================


VFS: Mounted root (squashfs filesystem) readonly on device 31:0.
devtmpfs: mounted
Freeing unused kernel memory: 36K (c000a000 - c0013000)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c05f0000
[00000000] *pgd=205f5831, *pte=00000000, *ppte=00000000
Internal error: Oops: 80000007 [#1] ARM
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 4.5.0-rc2-next-20160202-dirty #3
Hardware name: Generic R7S72100 (Flattened Device Tree)
task: c0613000 ti: c0614000 task.ti: c0614000
PC is at 0x0
LR is at 0xb6f87e88
pc : [<00000000>]    lr : [<b6f87e88>]    psr: 80000093
sp : c0615ff8  ip : 00000054  fp : beca8ba4
r10: b6f8b9ab  r9 : 00000000  r8 : 00000014
r7 : 000000c0  r6 : b6f93f74  r5 : 00000000  r4 : ffffffff
r3 : 04000022  r2 : 00000003  r1 : 00001000  r0 : 00000000
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 18c5347d  Table: 205f0059  DAC: 00000055
Process init (pid: 1, stack limit = 0xc0614208)
Stack: (0xc0615ff8 to 0xc0616000)
5fe0:                                                       fde4be6f 89031a8e
Backtrace: invalid frame pointer 0xbeca8ba4
Code: bad PC value
---[ end trace ed7071b866b0f003 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
