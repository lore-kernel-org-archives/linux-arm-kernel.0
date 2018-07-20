From: hari.vyas@broadcom.com (Hari Vyas)
Date: Fri, 20 Jul 2018 13:01:39 +0530
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <20180720064027.GA3901@jagdpanzerIV>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
 <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
 <20180719100140.GA424@jagdpanzerIV>
 <CAM5rFu_N-=26LddRy1mO010h9yLcGuKqK6=y+h=h3-HbfEP+FQ@mail.gmail.com>
 <20180719103916.g763zmsm7wnngwop@lakrids.cambridge.arm.com>
 <CAM5rFu-MFbH_2Pohmjydy232Rpt7_E84-K=e67wAu3iQzvTLiA@mail.gmail.com>
 <20180720062609.2haxhf23zyouoxmh@salmiak> <20180720064027.GA3901@jagdpanzerIV>
Message-ID: <CAM5rFu8rQaVne22cYxx3YZTaxh9Dnq2wJWNu1uierBxZfogPeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 12:10 PM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (07/20/18 07:26), Mark Rutland wrote:
>> > >
>> > This die() is called from so many places i.e. entry.S shows so many ways i.e
>> > el1_sync_invalid,irq,fiq_invalid,error_invalid.
>
> [..]
>
>> Indeed, but *none* of these should fire unless something has gone wrong already.
>
> [..]
>
> Agreed.
>
> I see that all those arm64/kernel/entry.S el0_sync_invalid,
> el0_irq_invalid, el0_fiq_invalid, and so on, invoke inv_entry macro
> which calls into bad_mode, which ends up in panic() anyway:
>
> asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
> {
>         console_verbose();
>
>         pr_crit("Bad mode in %s handler detected on CPU%d, code 0x%08x -- %s\n",
>                 handler[reason], smp_processor_id(), esr,
>                 esr_get_class_string(esr));
>
>         die("Oops - bad mode", regs, 0);
>         local_daif_mask();
>         panic("bad mode");
> }
>
> bad_mode is always fatal.
>
> When the kernel becomes suicidal and wants to die() we better have
> verbose consoles. So, no, I don't think I'm buying the patch.
>
>         -ss
This was the behavior observed with 4.14 kernel version and proposed
patch. I understand, giving access to system memory access to user is
bad and should be avoided so one may argue
simplest but bad example and unpredictable results may be observed.
For other examples, I may need to work and find out. Please decide.

root at bcm958802a8021:~# uname -a

Linux bcm958802a8021 4.14.49+g8f1356a #1 SMP Mon Jul 9 22:37:03 UTC
2018 aarch64 aarch64 aarch64 GNU/Linux

root at bcm958802a8021:~# cat /proc/sys/kernel/printk

7       4       1       7 <==CONSOLE LOGLEVEL IS SET TO 7

root@bcm958802a8021:~# echo 1 > /sys/bus/pci/rescan  <=== NO PRINT

root at bcm958802a8021:~# devmem 0x0

[   46.166083] Bad mode in Error handler detected on CPU1, code
0xbf000000 -- SError

[   46.173805] Internal error: Oops - bad mode: 0 [#1] SMP

[   46.179194] Modules linked in: bnxt_re(O) rdma_ucm ib_uverbs
rdma_cm iw_cm ib_cm ib_core bnxt_en(O) nfsd ipv6

[   46.189435] CPU: 1 PID: 4862 Comm: devmem Tainted: G           O
4.14.49+g8f1356a #1

[   46.197692] Hardware name: Stingray PS225xx (BCM958802A8021) (DT)

[   46.203978] task: ffff800b67619900 task.stack: ffff000013a00000

[   46.210084] PC is at 0x406530

[   46.213144] LR is@0x40cdec

[   46.216203] pc : [<0000000000406530>] lr : [<000000000040cdec>]
pstate: 60000000

[   46.223833] sp : 0000ffffc6560a50

[   46.227250] x29: 0000ffffc6560b70 x28: 0000000000000000

[   46.232731] x27: 0000000000000000 x26: 0000000000000000

[   46.238210] x25: 0000ffffc6560ca0 x24: 0000000000000003

[   46.243688] x23: 0000000000001000 x22: 0000ffffc6560ca8

[   46.249167] x21: 0000000000000000 x20: 0000ffffb0a05000

[   46.254645] x19: 0000000000000020 x18: 00000000000004ca

[   46.260124] x17: 00000000004b79a8 x16: 0000ffffb0896ad0

[   46.265603] x15: 0000ffffb07cdde0 x14: 0000ffffb07db2c8

[   46.271081] x13: 0000ffffb091cac8 x12: 0000000000000000

[   46.276561] x11: 0000000000000000 x10: 0101010101010101

[   46.282040] x9 : 0000ffffb08dc300 x8 : 00000000000000de

[   46.287519] x7 : 0000ffffb08dcc00 x6 : 0000000000000000

[   46.292998] x5 : 0000000000000000 x4 : 0000000000000003

[   46.298477] x3 : 0000000000000001 x2 : 0000000000000000

[   46.303955] x1 : 0000000000000008 x0 : 000000000048c4e8

[   46.309434] Process devmem (pid: 4862, stack limit = 0xffff000013a00000)

[   46.316347] ---[ end trace f57fc7b196a41802 ]---



Message from syslogd at bcm958802a8021 at Jul  9 22:08:54 ...

kernel:[   46.173805] Internal error: Oops - bad mode: 0 [#1] SMP



Message from syslogd at bcm958802a8021 at Jul  9 22:08:54 ...

kernel:[   46.309434] Process devmem (pid: 4862, stack limit =
0xffff000013a00000)

Segmentation fault

root at bcm958802a8021:~# cat /proc/sys/kernel/printk

15      4       1       7  <==== CONSOLE LOGLEVEL IS SET TO 15

root@bcm958802a8021:~# echo 1 > /sys/bus/pci/rescan <=== UNNECESSARY
DEBUG MESSAGES

[   53.861448] pci_bus 0008:00: scanning bus

[   53.865599] pci 0008:00:00.0: scanning [bus 01-01] behind bridge, pass 0

[   53.872521] pci_bus 0008:00: 2-byte config write to 0008:00:00.0
offset 0x3e may corrupt adjacent RW1C bits

[   53.882579] pci_bus 0008:01: scanning bus

[   53.886742] pci_bus 0008:01: bus scan returning with max=01

[   53.892496] pci_bus 0008:00: 2-byte config write to 0008:00:00.0
offset 0x3e may corrupt adjacent RW1C bits

[   53.902552] pci 0008:00:00.0: scanning [bus 01-01] behind bridge, pass 1

[   53.909469] pci_bus 0008:00: 2-byte config write to 0008:00:00.0
offset 0x3e may corrupt adjacent RW1C bits

[   53.919523] pci_bus 0008:00: 2-byte config write to 0008:00:00.0
offset 0x3e may corrupt adjacent RW1C bits

[   53.929578] pci_bus 0008:00: bus scan returning with max=01

[   53.935331] pci_bus 0008:00: 2-byte config write to 0008:00:00.0
offset 0x1c may corrupt adjacent RW1C bits

[   53.945385] pci_bus 0008:00: 2-byte config write to 0008:00:00.0
offset 0x1c may corrupt adjacent RW1C bits

root@bcm958802a8021:~#
