From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jul 2017 09:15:18 +0100
Subject: [BUG] v4.12 breaks pxa25x
In-Reply-To: <87inirsgzk.fsf@belgarion.home>
References: <87inirsgzk.fsf@belgarion.home>
Message-ID: <20170717081518.GI31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 08:41:03AM +0200, Robert Jarzmik wrote:

> [    0.000000] Unhandled fault: alignment exception (0x003) at 0xc06f82cd
> [    0.000000] pgd = c0004000
> [    0.000000] [c06f82cd] *pgd=a060040e(bad)
> [    0.000000] Internal error: : 3 [#1] ARM
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.12.0-11927-g6bf3d68 #4582
> [    0.000000] Hardware name: Intel DBPXA250 Development Platform (aka Lubbock)
> [    0.000000] task: c06f6fd8 task.stack: c06f2000
> [    0.000000] PC is at __flush_whole_cache+0x4/0x60
> [    0.000000] LR is at paging_init+0x4b4/0x590
> [    0.000000] pc : [<c0019e24>]    lr : [<c049d274>]    psr: 600000d3
> [    0.000000] sp : c06f3f38  ip : 00000000  fp : c0700000
> [    0.000000] r10: a4000000  r9 : c06f82c0  r8 : c0723540
> [    0.000000] r7 : fe100000  r6 : fe200000  r5 : c06f82a0  r4 : c0705ef4
> [    0.000000] r3 : 00000000  r2 : 00000004  r1 : c06f82cd  r0 : c06f82c0

Looks like the .data section has become misaligned somehow.  r1 is the
address of "clean_addr" which is clearly not 32-bit aligned.

Please can you check in System.map to see what's immediately before it?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
