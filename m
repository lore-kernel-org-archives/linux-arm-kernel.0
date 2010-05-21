From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 21 May 2010 15:22:54 +0200
Subject: [PATCH 2/5] mxc_nand: fix PM
In-Reply-To: <20100521131058.GC27829@pengutronix.de>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>
	<1274440363-435-2-git-send-email-eric@eukrea.com>
	<20100521131058.GC27829@pengutronix.de>
Message-ID: <4BF6892E.9050908@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/05/2010 15:10, Wolfram Sang a ?crit :
> On Fri, May 21, 2010 at 01:12:40PM +0200, Eric B?nard wrote:
>
> A short description what was fixed and how it was fixed would be great.
>
sure :
*** 1st part of the log before the fix :
WARNING: at arch/arm/plat-mxc/clock.c:59 __clk_disable+0x68/0x74()
Modules linked in:
[<c002d200>] (unwind_backtrace+0x0/0xf8) from [<c0046008>] 
(warn_slowpath_common+0x48/0x78)
[<c0046008>] (warn_slowpath_common+0x48/0x78) from [<c0031e28>] 
(__clk_disable+0x68/0x74)
[<c0031e28>] (__clk_disable+0x68/0x74) from [<c0031ddc>] 
(__clk_disable+0x1c/0x74)
[<c0031ddc>] (__clk_disable+0x1c/0x74) from [<c0031e58>] 
(clk_disable+0x24/0x34)
[<c0031e58>] (clk_disable+0x24/0x34) from [<c01e57b4>] 
(mxcnd_suspend+0x34/0x3c)
[<c01e57b4>] (mxcnd_suspend+0x34/0x3c) from [<c01bee10>] 
(platform_pm_suspend+0x50/0x54)

* why :
because the clock is already turned off by mxc_nand_select_chip

* fix :
check if the clock is actually really on before turning it off

*** 2nd part of the log before the fix :
nand_resume called for a chip which is not in suspended state

* why :
because mtd->suspend and mtd->resume are already called from the mtd 
layer, thus they were called a second time in mxc_nand so mtd complains 
when trying to resume for the second time

* fix :
don't call mtd->suspend / mtd->resume in mxc_nand.

Eric
