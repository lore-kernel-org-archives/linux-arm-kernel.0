From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 24 Aug 2018 14:48:10 +0200
Subject: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <96e538a5-1232-11f2-8b9e-5ddb09dcc2de@amlogic.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
 <20180719094612.5833-3-yixun.lan@amlogic.com>
 <20180801235045.5b4d8211@bbrezillon>
 <42877a0d-9830-0626-3f64-e49a326eaa3c@amlogic.com>
 <20180817155608.5929b37a@bbrezillon>
 <96e538a5-1232-11f2-8b9e-5ddb09dcc2de@amlogic.com>
Message-ID: <20180824144810.31c929a5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Aug 2018 22:08:42 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> > You have to wait tWB, that's for sure.
> >   
> we have a maximum 32 commands fifo. when command is written into 
> NFC_REG_CMD, it doesn't mean that command is executing right now, maybe 
> it is buffering on the queue.Assume one ERASE operation, when 2nd 
> command(0xd0) is written into NFC_REG_CMD and then come into 
> NAND_OP_WAITRDY_INSTR, if I read the RB status by register, it may be 
> wrong because 0xd0 may not being executed. it is unusual unless 
> buffering two many command.

You should flush the queue and wait for it to empty at the end of
->exec_op().

> so it seems that i still need to use nand_soft_waitrdy or wait cmd is 
> executed somewhere.

Don't you have a WAIT_FOR_RB instruction? What is NFC_CMD_RB for? Also,
NFC_CMD_IDLE seems to allow you to add an arbitrary delay, and that's
probably what you should use for tWB.
