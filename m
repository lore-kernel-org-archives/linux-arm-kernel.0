From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 16 Jul 2015 16:23:36 +0000
Subject: [PATCH 2/2] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <20150716161219.GL7557@n2100.arm.linux.org.uk>
References: <1437057434-1616-1-git-send-email-chris.brandt@renesas.com>
 <1437057434-1616-3-git-send-email-chris.brandt@renesas.com>
 <20150716161219.GL7557@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB056167AA24AF00983F860C898A990@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think you need to either provide more details of the problem you're seeing, or further reasoning why this is a correct change.


When I look at my System.map, it's clear that _edata_loc is the very last thing of ROM, and hence programmed into Flash.
_etext is farther back.


Example:

00000000 t __vectors_start
00000024 A cpu_ca8_suspend_size
00000024 A cpu_v7_suspend_size
0000002c A cpu_ca9mp_suspend_size
00001000 t __stubs_start
00001004 t vector_rst
00001020 t vector_irq
000010a0 t vector_dabt
00001120 t vector_pabt
000011a0 t vector_und
00001220 t vector_addrexcptn
00001240 t vector_fiq
00001240 T vector_fiq_offset
bf000000 T _text
bf000000 T stext
bf000070 t __create_page_tables
bf000180 t __turn_mmu_on_loc
bf00018c t __enable_mmu
bf0001c0 t __vet_atags
bf000240 T __idmap_text_start
bf000240 T __turn_mmu_on
bf000240 T _stext
bf000260 t __turn_mmu_on_end
bf000260 T cpu_resume_mmu
bf000284 T cpu_ca8_reset
bf000284 T cpu_ca9mp_reset
bf000284 T cpu_v7_reset
~ ~ ~
bf370f30 T __start_notes
bf370f30 R __stop___ex_table
bf370f54 T __stop_notes
bf370f54 A __vectors_start
bf370f54 A _etext                  <<<<<<<<<<<<<<<<<<<<<
bf370f74 A __stubs_start
bf370f74 A __vectors_end
bf371234 A __stubs_end
bf371240 t __mmap_switched
~ ~ ~
bf38ca74 T __security_initcall_end
bf38ca74 T __security_initcall_start
bf428a4a t __irf_end
bf428a50 T __initramfs_size
bf428a54 A __data_loc
bf445314 A _edata_loc
c0004000 A swapper_pg_dir
c0008000 D _data                  <<<<<<<<<<<<<<<<<<<<<
c0008000 D _sdata
c0008000 D init_thread_union
c000a000 D __init_begin
c000a000 d kthreadd_done
c000a00c d done.42220
~ ~ ~


The issue is basically early in boot when the MMU is being set up, it is mapping (in 1MB chucks) your ROM kernel to 0xBF000000.
If the size of you kernel happens to be that _etext is on 1 side of a 1MB boundary and the actual end of ROM (marked by _edata_loc) is on the other side of the 1MB boundry, it doesn't get mapped and you lose the end of your ROM as soon as the MMU is turned on.


Chris
