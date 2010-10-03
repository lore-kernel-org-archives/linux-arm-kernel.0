From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Oct 2010 12:41:03 +0100
Subject: I.MX35 GPIO IRQ + Preempt -> Oops
In-Reply-To: <4CA739B4.1020506@eukrea.com>
References: <4CA739B4.1020506@eukrea.com>
Message-ID: <20101003114103.GC32736@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 02, 2010 at 03:55:00PM +0200, Eric B?nard wrote:
> Do you have any idea of where to search for this problem's reason ?

Well...

> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT
> last sysfs file: /sys/class/vc/vcs3/dev
> Modules linked in:
> CPU: 0    Not tainted  (2.6.36-rc6-00050-g4ac6ae6-dirty #33)
> PC is at default_idle+0x24/0x28
> LR is at default_idle+0x20/0x28
> pc : [<c0026fa8>]    lr : [<c0026fa4>]    psr: 60000013
> sp : c0425fc8  ip : c7be8044  fp : 00000000
> r10: 8001d9a0  r9 : 4117b363  r8 : 8001da08
> r7 : c0427ba0  r6 : c001ef04  r5 : c001ef08  r4 : c0424000
> r3 : 00000000  r2 : c0425fc8  r1 : 00000000  r0 : 00000001
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 00c5387d  Table: 87b70008  DAC: 00000017
> Process swapper (pid: 0, stack limit = 0xc0424268)
> Stack: (0xc0425fc8 to 0xc0426000)
> 5fc0:                   c0026f84 c002748c c0453054 c00088f0 c00084a8 00000000
> 5fe0: 00000000 c001ef08 00000000 00c5387d c044b9e0 80008034 00000000 00000000
> [<c0026fa8>] (default_idle+0x24/0x28) from [<c002748c>] (cpu_idle+0x40/0x8c)
> [<c002748c>] (cpu_idle+0x40/0x8c) from [<c00088f0>] (start_kernel+0x20c/0x250)
> [<c00088f0>] (start_kernel+0x20c/0x250) from [<80008034>] (0x80008034)
> Code: e3130002 1a000000 eb001f1f f1080080 (e8bd8008)

This disassembles to:

   0:   e3130002        tst     r3, #2  ; 0x2
   4:   1a000000        bne     0xc
   8:   eb001f1f        bl      0x7c8c
   c:   f1080080        cpsie   i
  10:   e8bd8008        pop     {r3, pc}

Doesn't look like any undefined instructions there.

> Unable to handle kernel paging request at virtual address 80020054
> pgd = c0004000
> [80020054] *pgd=00000000
> Internal error: Oops: 805 [#1] PREEMPT
> last sysfs file: /sys/class/i2c-dev/i2c-0/dev
> Modules linked in:
> CPU: 0    Not tainted  (2.6.36-rc6-00046-g6e4172c-dirty #4)
> PC is at default_idle+0x24/0x2c
> LR is at default_idle+0x20/0x2c
> pc : [<c002a008>]    lr : [<c002a004>]    psr: 60000013
> sp : c043bfc0  ip : c0440438  fp : 00000000
> r10: 8001ffb8  r9 : 4117b363  r8 : 80020020
> r7 : c043daf8  r6 : c045e850  r5 : c043db04  r4 : c043a000
> r3 : 00000000  r2 : 60000013  r1 : 00000000  r0 : 2625a000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 00c5387d  Table: 87018008  DAC: 00000017
> Process swapper (pid: 0, stack limit = 0xc043a268)
> Stack: (0xc043bfc0 to 0xc043c000)
> bfc0: 00000000 c002a4f8 c0465f5c c045e7c4 c0021520 c0008964 c00084c0 00000000
> bfe0: 00000000 c0021520 00c5387d c045e890 c0021924 80008034 00000000 00000000
> [<c002a008>] (default_idle+0x24/0x2c) from [<c002a4f8>] (cpu_idle+0x44/0x9c)
> [<c002a4f8>] (cpu_idle+0x44/0x9c) from [<c0008964>] (start_kernel+0x21c/0x26c)
> [<c0008964>] (start_kernel+0x21c/0x26c) from [<80008034>] (0x80008034)
> Code: e3130002 1a000000 eb0020e7 f1080080 (e28dd004)

This disassembles to:

   0:   e3130002        tst     r3, #2  ; 0x2
   4:   1a000000        bne     0xc
   8:   eb0020e7        bl      0x83ac
   c:   f1080080        cpsie   i
  10:   e28dd004        add     sp, sp, #4      ; 0x4

Doesn't make sense for that last instruction to cause a data abort.

> Unable to handle kernel NULL pointer dereference at virtual address 00000085
> pgd = c0004000
> [00000085] *pgd=00000000
> Internal error: Oops: 17 [#1] PREEMPT
> last sysfs file: /sys/class/vc/vcs3/dev
> Modules linked in:
> CPU: 0    Not tainted  (2.6.36-rc6-00050-g4ac6ae6-dirty #35)
> PC is at arch_randomize_brk+0x8/0x24
> LR is at default_idle+0x20/0x28
> pc : [<c0026fb4>]    lr : [<c0026fa4>]    psr: 60000013
> sp : c0425fc0  ip : c753e044  fp : 00000000
> r10: 8001d99c  r9 : 4117b363  r8 : 8001da04
> r7 : c0427ba0  r6 : c001ef04  r5 : c001ef08  r4 : 00000001
> r3 : 00000000  r2 : c0425fc8  r1 : 00000000  r0 : 00000001
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 00c5387d  Table: 874e4008  DAC: 00000017
> Process swapper (pid: 0, stack limit = 0xc0424268)
> Stack: (0xc0425fc0 to 0xc0426000)
> 5fc0: c0424000 c0026fa4 c0026f84 c002748c c0453054 c00088f0 c00084a8 00000000
> 5fe0: 00000000 c001ef08 00000000 00c5387d c044b9e0 80008034 00000000 00000000
> [<c0026fb4>] (arch_randomize_brk+0x8/0x24) from [<c0026fa4>] (default_idle+0x20/0x28)
> [<c0026fa4>] (default_idle+0x20/0x28) from [<c002748c>] (cpu_idle+0x40/0x8c)
> [<c002748c>] (cpu_idle+0x40/0x8c) from [<c00088f0>] (start_kernel+0x20c/0x250)
> [<c00088f0>] (start_kernel+0x20c/0x250) from [<80008034>] (0x80008034)
> Code: f1080080 e8bd8008 e92d4010 e1a04000 (e5900084)

Doesn't make sense for the PC to get into arch_randomize_brk() from
default_idle().

The common theme here looks like instruction cache corruption in
default_idle() - iow, the CPU isn't executing the code which is in
memory.
