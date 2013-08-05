From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Aug 2013 17:18:39 +0800
Subject: [PATCH 02/25] ARM: mxs: Fix BUG() when invoking mxs_restart()
 from interrupt context
In-Reply-To: <20991.26498.114005.439057@ipc1.ka-ro>
References: <1375279690-16893-1-git-send-email-LW@KARO-electronics.de>
 <20130804111108.GD18119@S2101-09.ap.freescale.net>
 <20991.26498.114005.439057@ipc1.ka-ro>
Message-ID: <20130805091837.GI24629@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 10:51:14AM +0200, Lothar Wa?mann wrote:
> You're right, of course, new version of this patch below.
> 
> The mxs_restart() function uses of_iomap() which triggers the
> following BUG_ON(in_interrupt()) when called in interrupt context
> (e.g. thru SYSRQ-B):
> 
>       SysRq : Resetting
>       ------------[ cut here ]------------
>       kernel BUG at mm/vmalloc.c:1310!
>       Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
>       Modules linked in: i2c_dev
>       CPU: 0 PID: 0 Comm: swapper Not tainted 3.11.0-rc2-next-20130729-karo+ #196
>       task: c04e1c38 ti: c04d8000 task.ti: c04d8000
>       PC is at __get_vm_area_node.clone.25+0x34/0x140
>       LR is at get_vm_area_caller+0x38/0x44
>       pc : [<c008a988>]    lr : [<c008b434>]    psr: 20000013
>       sp : c04d9db0  ip : 00000001  fp : 00000001
>       r10: c8800000  r9 : 00000000  r8 : 000000d0
>       r7 : 00002000  r6 : 00000001  r5 : 00000001  r4 : 00002000
>       r3 : 00010000  r2 : 00000001  r1 : c04d9db0  r0 : 00002000
>       Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>       Control: 0005317f  Table: 46920000  DAC: 00000017
>       Process swapper (pid: 0, stack limit = 0xc04d81b8)
> 
> Create the mapping upon startup from mxs_machine_init().
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Applied, thanks.
