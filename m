From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 29 Jul 2012 21:17:36 +0200
Subject: ltp abort01  Unable to handle kernel NULL pointer dereference at
 virtual address 00000150
Message-ID: <20120729191736.GA12756@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will

I've not use the Linux Test Project before. So i decided to give it a
go on my ARM Kirkwood QNAP NAS. To my surprise, it exploded on the
very first test:

Jul 29 17:36:54 qnap kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000150
Jul 29 17:36:54 qnap kernel: pgd = cd014000
Jul 29 17:36:54 qnap kernel: [00000150] *pgd=0cc91831, *pte=00000000, *ppte=00000000
Jul 29 17:36:55 qnap kernel: Internal error: Oops: 17 [#1] PREEMPT ARM
Jul 29 17:36:55 qnap kernel: Modules linked in:
Jul 29 17:36:55 qnap kernel: CPU: 0    Not tainted  (3.4.0-rc2-00059-ga1ada08 #380)
Jul 29 17:36:55 qnap kernel: PC is at get_dump_page+0x64/0xa0
Jul 29 17:36:55 qnap kernel: LR is at __get_user_pages+0x348/0x400
Jul 29 17:36:55 qnap kernel: pc : [<c0080038>]    lr : [<c007ff1c>]    psr: 20000013
Jul 29 17:36:55 qnap kernel: sp : cd20dd00  ip : 0001fffc  fp : c04cdf38
Jul 29 17:36:55 qnap kernel: r10: c0579f5c  r9 : cd20de38  r8 : c0961240
Jul 29 17:36:55 qnap kernel: r7 : ffff0000  r6 : dec18220  r5 : 00000000  r4 : ffff0000
Jul 29 17:36:55 qnap kernel: r3 : 00000000  r2 : c04f6b30  r1 : 00000002  r0 : 00000001
Jul 29 17:36:55 qnap kernel: Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Jul 29 17:36:55 qnap kernel: Control: 0005397f  Table: 0d014000  DAC: 00000017
Jul 29 17:36:55 qnap kernel: Process abort01 (pid: 2388, stack limit = 0xcd20c270)
Jul 29 17:36:55 qnap kernel: Stack: (0xcd20dd00 to 0xcd20e000)
Jul 29 17:36:55 qnap kernel: dd00: 0000001c cd20dd10 cd20dd14 00000000 c098dfe0 c04f6b30 c04f6b30 c04f6b30
Jul 29 17:36:55 qnap kernel: dd20: 00000000 c00dfbe8 cd20ddc4 00080000 deb0c768 00000000 ffff1000 00000000
Jul 29 17:36:55 qnap kernel: dd40: 00000000 00000000 00000000 dfbcf040 bf000000 cd20de38 c04f6b30 cd20dd70
Jul 29 17:36:55 qnap kernel: dd60: cd20dd80 00000010 c04da33c dfa3cd80 c042db80 00000003 0000007c dfb7e680
Jul 29 17:36:55 qnap kernel: dd80: c042db80 00000006 00000090 dec09ca0 00000264 00000002 00000001 00056000
Jul 29 17:36:55 qnap kernel: dda0: ffff0000 00000000 00001000 00001000 00000005 00001000 00000498 00000000
Jul 29 17:36:55 qnap kernel: ddc0: 50155896 00011234 50155896 cd20c000 00000000 c04da718 cd20de4c c057ad5c
Jul 29 17:36:55 qnap kernel: dde0: c04da33c dec09c00 00000021 c009e1d4 00000000 dfb7ef00 cd0649a0 0000002a
Jul 29 17:36:55 qnap kernel: de00: c04da718 dfa3e7e0 00000006 00000000 dfa3e7e0 00000000 00000000 dfa3e900
Jul 29 17:36:55 qnap kernel: de20: 00000000 df8c5600 00000000 00000000 cd20de30 cd20de30 00000006 cd20dfb0
Jul 29 17:36:55 qnap kernel: de40: dfb7ef00 00080000 000000cd dfb7eb80 00000004 00000080 00000006 c00230b0
Jul 29 17:36:55 qnap kernel: de60: cd20c000 00000006 daf52630 00000006 cd20c000 cd20dee0 dfa8f3a8 dfa10600
Jul 29 17:36:55 qnap kernel: de80: dfa8f340 00000014 08430000 c0025674 df8c5600 cd20dfb0 cd20df60 00040100
Jul 29 17:36:55 qnap kernel: dea0: b6f386d0 cd20dfb0 c0008f24 b6f17000 cd20df60 00000000 b6e14d04 cd20dee0
Jul 29 17:36:55 qnap kernel: dec0: b6e14d08 c000acb0 00000006 c0023f4c 00000000 00000000 ccd70000 20000013
Jul 29 17:36:55 qnap kernel: dee0: 00000006 00000000 fffffffa 00000954 00000000 00000000 000000f8 df980dc0
Jul 29 17:36:55 qnap kernel: df00: cd20c000 00000000 000000f8 df83c000 df980eac c017d37c 60000013 ffffffff
Jul 29 17:36:55 qnap kernel: df20: df8c5600 c00227ec b6f38278 00000000 00000954 cd20c000 00000001 c0022874
Jul 29 17:36:55 qnap kernel: df40: 00000000 c0022b34 00000000 00000000 00000000 c0022c48 00000020 00000000
Jul 29 17:36:55 qnap kernel: df60: 00000954 cd20c000 00000001 c0022874 00000000 c0022b34 00000000 00000000
Jul 29 17:36:55 qnap kernel: df80: 00000000 00000001 b6f17bdc b6f17000 0000010c 00000000 cd20c000 00000000
Jul 29 17:36:55 qnap kernel: dfa0: b6f386d0 c000b1ac 00000006 c0008df4 00000000 00000954 00000006 00000954
Jul 29 17:36:55 qnap kernel: dfc0: 00000006 b6f17bdc b6f17000 0000010c 00000bdc beca0b30 b6f38210 b6f386d0
Jul 29 17:36:55 qnap kernel: dfe0: 00000000 beca0a90 b6e14cd4 b6e14d08 20000010 00000954 00000000 00000000
Jul 29 17:36:55 qnap kernel: [<c0080038>] (get_dump_page+0x64/0xa0) from [<c00dfbe8>] (elf_core_dump+0xd6c/0xf24)
Jul 29 17:36:55 qnap kernel: [<c00dfbe8>] (elf_core_dump+0xd6c/0xf24) from [<c009e1d4>] (do_coredump+0x3e4/0xb14)
Jul 29 17:36:55 qnap kernel: [<c009e1d4>] (do_coredump+0x3e4/0xb14) from [<c0025674>] (get_signal_to_deliver+0x1dc/0x594)
Jul 29 17:36:55 qnap kernel: [<c0025674>] (get_signal_to_deliver+0x1dc/0x594) from [<c000acb0>] (do_signal+0x78/0x528)
Jul 29 17:36:55 qnap kernel: [<c000acb0>] (do_signal+0x78/0x528) from [<c000b1ac>] (do_notify_resume+0x4c/0x50)
Jul 29 17:36:55 qnap kernel: [<c000b1ac>] (do_notify_resume+0x4c/0x50) from [<c0008df4>] (work_pending+0x24/0x28)
Jul 29 17:36:55 qnap kernel: Code: d1a00005 da000005 e59d2014 e5923000 (e5933150) 
Jul 29 17:36:55 qnap kernel: ---[ end trace a7de8a765076e24d ]---

With a git bisect, this patch is the one causing the problem:

commit f9d4861fc32b995b1616775614459b8f266c803c
Author: Will Deacon <will.deacon@arm.com>
Date:   Fri Jan 20 12:01:13 2012 +0100

    ARM: 7294/1: vectors: use gate_vma for vectors user mapping
    
    The current user mapping for the vectors page is inserted as a `horrible
    hack vma' into each task via arch_setup_additional_pages. This causes
    problems with the MM subsystem and vm_normal_page, as described here:
    
    https://lkml.org/lkml/2012/1/14/55
    
    Following the suggestion from Hugh in the above thread, this patch uses
    the gate_vma for the vectors user mapping, therefore consolidating
    the horrible hack VMAs into one.
    
    Acked-and-Tested-by: Nicolas Pitre <nico@linaro.org>
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I have LTP version 20120614. The test can be run alone with:

cd /opt/ltp ; ./runltp -s abort01

   Andrew
