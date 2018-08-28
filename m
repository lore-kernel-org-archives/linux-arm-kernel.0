From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 28 Aug 2018 15:26:45 +0200
Subject: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <fdea2d54-7a68-64ec-8bb4-4a94677a3293@amlogic.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
 <20180719094612.5833-3-yixun.lan@amlogic.com>
 <20180801235045.5b4d8211@bbrezillon>
 <42877a0d-9830-0626-3f64-e49a326eaa3c@amlogic.com>
 <20180817155608.5929b37a@bbrezillon>
 <96e538a5-1232-11f2-8b9e-5ddb09dcc2de@amlogic.com>
 <20180824144810.31c929a5@bbrezillon>
 <fdea2d54-7a68-64ec-8bb4-4a94677a3293@amlogic.com>
Message-ID: <20180828152645.457dab5c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Aug 2018 21:21:48 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> Hi Boris,
> 
> On 8/24/2018 8:48 PM, Boris Brezillon wrote:
> > On Wed, 22 Aug 2018 22:08:42 +0800
> > Liang Yang <liang.yang@amlogic.com> wrote:
> >   
> >>> You have to wait tWB, that's for sure.
> >>>      
> >> we have a maximum 32 commands fifo. when command is written into
> >> NFC_REG_CMD, it doesn't mean that command is executing right now, maybe
> >> it is buffering on the queue.Assume one ERASE operation, when 2nd
> >> command(0xd0) is written into NFC_REG_CMD and then come into
> >> NAND_OP_WAITRDY_INSTR, if I read the RB status by register, it may be
> >> wrong because 0xd0 may not being executed. it is unusual unless
> >> buffering two many command.  
> > 
> > You should flush the queue and wait for it to empty at the end of  
> > ->exec_op().  
> >   
> >> so it seems that i still need to use nand_soft_waitrdy or wait cmd is
> >> executed somewhere.  
> > 
> > Don't you have a WAIT_FOR_RB instruction? What is NFC_CMD_RB for? Also,
> > NFC_CMD_IDLE seems to allow you to add an arbitrary delay, and that's
> > probably what you should use for tWB.
> > 
> > em, I can wait for RB by reading the status from register now. but when   
> calling nand_soft_waitrdy, i really met a problem. One *jiffies* is 
> about 4ms. When programming, it pass 1ms to 
> instr->ctx.waitrdy.timeout_ms and nand_soft_waitrdy will be only one 
> *jiffies* to reach timeout. And then calling nand_soft_waitrdy maybe at 
> the tail of 4ms interval, it may only wait 100us and next jiffies 
> arrive. Is it correct?

Hm, no. If you initialize the time you compare to (using time_before()
or time_after()) correctly it should not happen. Anyway, I keep thinking
this is not how it should be done. Did you try NFC_CMD_RB? Did you ask
HW designers what it was created for?
