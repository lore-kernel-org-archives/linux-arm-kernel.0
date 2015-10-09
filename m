From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Oct 2015 10:28:14 +0200
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZhJfsH0wU0VBotT=yomDqBkKWrz3MNFOin=CCz62v_nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 5:42 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Provide a software-based implementation of the priviledged no access
> support found in ARMv8.1.
>
> Userspace pages are mapped using a different domain number from the
> kernel and IO mappings.  If we switch the user domain to "no access"
> when we enter the kernel, we can prevent the kernel from touching
> userspace.
>
> However, the kernel needs to be able to access userspace via the
> various user accessor functions.  With the wrapping in the previous
> patch, we can temporarily enable access when the kernel needs user
> access, and re-disable it afterwards.
>
> This allows us to trap non-intended accesses to userspace, eg, caused
> by an inadvertent dereference of the LIST_POISON* values, which, with
> appropriate user mappings setup, can be made to succeed.  This in turn
> can allow use-after-free bugs to be further exploited than would
> otherwise be possible.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For some reason this patch explodes on my ARM PB11MPCore, it
is a weird beast and corner case machine so I guess that is why
it wasn't noticed. This happens a bit into the boot when freeing
unused pages:

Freeing unused kernel memory: 2672K (c0448000 - c06e4000)
Unable to handle kernel paging request at virtual address b6f069f4
pgd = c6e58000
[b6f069f4] *pgd=76e09831, *pte=77ff759f, *ppte=77ff7e6e
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 2 PID: 1 Comm: init Not tainted 4.3.0-rc4-00015-gf6702681a0af #48
Hardware name: ARM-RealView PB11MPCore
task: c7827bc0 ti: c782c000 task.ti: c782c000
PC is at v6wbi_flush_user_tlb_range+0x28/0x48
LR is at on_each_cpu_mask+0x58/0x60
pc : [<c001abf0>]    lr : [<c007c18c>]    psr: 20000093
sp : c782deb8  ip : 00000000  fp : 00000000
r10: c6e5adc8  r9 : 00000001  r8 : b6f02000
r7 : c7a17180  r6 : c782ded4  r5 : c0015118  r4 : 20000013
r3 : 00000002  r2 : 00100075  r1 : b6f02000  r0 : b6f01002
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 00c5787d  Table: 76e5800a  DAC: 00000051
Process init (pid: 1, stack limit = 0xc782c190)
Stack: (0xc782deb8 to 0xc782e000)
dea0:                                                       b6f02000 c6e09408
dec0: c6e09404 b6f02000 b6f02000 c0015378 706db5df c7988f50 b6f01000 b6f02000
dee0: 706db55f c00ad710 00000001 b6f02000 b6f01fff c7988f50 00000181 706db5df
df00: c7fd313c c6e5adc0 c7a17020 b6f01000 c79885b0 00000000 c7988f50 00100075
df20: b6f01000 b6f02000 00000000 00100077 c7a17020 c00ad84c 00000000 00000000
df40: c78c7aa0 00000056 00000000 c7a17058 c782df8c 00000001 00000000 b6f02000
df60: b6f02000 00000005 00000001 b6f01000 c782c000 00000000 bee4ab2c c00ada8c
df80: 00100075 00000000 ffffffff c7988f50 b6f2ef78 b6f2c490 00000000 0000007d
dfa0: c000f624 c000f460 b6f2ef78 b6f2c490 b6f01000 00001000 00000001 b6f01cd8
dfc0: b6f2ef78 b6f2c490 00000000 0000007d b6f2ef78 00000004 00000004 bee4ab2c
dfe0: b6f2d2a8 bee4ab18 b6f24eb0 b6f2214c 80000010 b6f01000 45355559 dd550555
[<c001abf0>] (v6wbi_flush_user_tlb_range) from [<b6f01000>] (0xb6f01000)
Code: e20330ff e1830600 e1a01601 e5922028 (ee080f36)
---[ end trace c90cca4faa737700 ]---
Kernel panic - not syncing: Fatal exception
CPU3: stopping
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D
4.3.0-rc4-00015-gf6702681a0af #48
Hardware name: ARM-RealView PB11MPCore
[<c0015f64>] (unwind_backtrace) from [<c0012dc0>] (show_stack+0x10/0x14)
[<c0012dc0>] (show_stack) from [<c01778c4>] (dump_stack+0x84/0x9c)
[<c01778c4>] (dump_stack) from [<c0014f24>] (handle_IPI+0x174/0x1b4)
[<c0014f24>] (handle_IPI) from [<c00094b0>] (gic_handle_irq+0x80/0x8c)
[<c00094b0>] (gic_handle_irq) from [<c00138f4>] (__irq_svc+0x54/0x70)
Exception stack(0xc785bf90 to 0xc785bfd8)
bf80:                                     00003228 00000000 00000000 00000000
bfa0: c785a000 c06edac4 00000000 c06eda78 c06e1284 c785bfe8 c033d738 00000001
bfc0: 00000000 c785bfe0 c000ff58 c000ff5c 60000113 ffffffff
[<c00138f4>] (__irq_svc) from [<c000ff5c>] (arch_cpu_idle+0x28/0x30)
[<c000ff5c>] (arch_cpu_idle) from [<c0052c24>] (cpu_startup_entry+0xf8/0x184)
[<c0052c24>] (cpu_startup_entry) from [<70009548>] (0x70009548)
CPU0: stopping
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
4.3.0-rc4-00015-gf6702681a0af #48
Hardware name: ARM-RealView PB11MPCore
[<c0015f64>] (unwind_backtrace) from [<c0012dc0>] (show_stack+0x10/0x14)
[<c0012dc0>] (show_stack) from [<c01778c4>] (dump_stack+0x84/0x9c)
[<c01778c4>] (dump_stack) from [<c0014f24>] (handle_IPI+0x174/0x1b4)
[<c0014f24>] (handle_IPI) from [<c00094b0>] (gic_handle_irq+0x80/0x8c)
[<c00094b0>] (gic_handle_irq) from [<c00138f4>] (__irq_svc+0x54/0x70)
Exception stack(0xc06e5f58 to 0xc06e5fa0)
5f40:                                                       00002fa4 00000000
5f60: 00000000 00000000 c06e4000 c06edac4 00000000 c06eda78 c06e1284 c06e5fb0
5f80: c033d738 00000001 00000000 c06e5fa8 c000ff58 c000ff5c 60000013 ffffffff
[<c00138f4>] (__irq_svc) from [<c000ff5c>] (arch_cpu_idle+0x28/0x30)
[<c000ff5c>] (arch_cpu_idle) from [<c0052c24>] (cpu_startup_entry+0xf8/0x184)
[<c0052c24>] (cpu_startup_entry) from [<c0448bec>] (start_kernel+0x32c/0x3a0)
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
4.3.0-rc4-00015-gf6702681a0af #48
Hardware name: ARM-RealView PB11MPCore
[<c0015f64>] (unwind_backtrace) from [<c0012dc0>] (show_stack+0x10/0x14)
[<c0012dc0>] (show_stack) from [<c01778c4>] (dump_stack+0x84/0x9c)
[<c01778c4>] (dump_stack) from [<c0014f24>] (handle_IPI+0x174/0x1b4)
[<c0014f24>] (handle_IPI) from [<c00094b0>] (gic_handle_irq+0x80/0x8c)
[<c00094b0>] (gic_handle_irq) from [<c00138f4>] (__irq_svc+0x54/0x70)
Exception stack(0xc7857f90 to 0xc7857fd8)
7f80:                                     0000290a 00000000 00000000 00000000
7fa0: c7856000 c06edac4 00000000 c06eda78 c06e1284 c7857fe8 c033d738 00000001
7fc0: 00000000 c7857fe0 c000ff58 c000ff5c 60000113 ffffffff
[<c00138f4>] (__irq_svc) from [<c000ff5c>] (arch_cpu_idle+0x28/0x30)
[<c000ff5c>] (arch_cpu_idle) from [<c0052c24>] (cpu_startup_entry+0xf8/0x184)
[<c0052c24>] (cpu_startup_entry) from [<70009548>] (0x70009548)
---[ end Kernel panic - not syncing: Fatal exception

(I configured to treat oops as panic so it takes down all CPUs.)

Sometimes I get this instead, earlier:

INFO: rcu_sched detected stalls on CPUs/tasks:
        1: (0 ticks this GP) idle=8af/140000000000000/0 softirq=242/244 fqs=1373
        (detected by 0, t=2103 jiffies, g=-256, c=-257, q=235)
Task dump for CPU 1:
modprobe        R running      0   351    350 0x00000002
[<c032eab4>] (__schedule) from [<c00a2734>] (handle_mm_fault+0x978/0xa9c)
[<c00a2734>] (handle_mm_fault) from [<c0017218>] (do_page_fault+0x1e0/0x2a4)
[<c0017218>] (do_page_fault) from [<c0009310>] (do_DataAbort+0x34/0xb4)
[<c0009310>] (do_DataAbort) from [<c001361c>] (__dabt_usr+0x3c/0x40)
Exception stack(0xc698dfb0 to 0xc698dff8)
dfa0:                                     b6f7cd2c 00000020 0000eed4 b6f7d450
dfc0: b6f7c000 b6f8af78 00000000 00000000 b6f82040 6defe040 be903ec4 be903ebc
dfe0: 00000108 be903cf0 00000021 b6f81490 20000010 ffffffff

Reverting the patch makes everything boot smoothly again.

Feeling kind of clueless on where the problem may be, the first backtrace
seem to be in pure assembly so I'm a bit lost. The second one from
RCU is a bit more clear but I don't know the context of how this is
affected by the patch. Been scratching my head for a while...

Any ideas?

Yours,
Linus Walleij
