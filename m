From: johan@hovold.com (Johan Hovold)
Date: Fri, 9 May 2014 18:36:52 +0200
Subject: [PATCH] ARM: at91: fix rtc irq mask for sam9x5 SoCs
In-Reply-To: <536BBEA4.6080908@free-electrons.com>
References: <957b209589094df48ddedbc57c6ccdfd@BLUPR05MB037.namprd05.prod.outlook.com>
 <1399479649-3247-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140508154912.GA6776@localhost>
 <536BBEA4.6080908@free-electrons.com>
Message-ID: <20140509163652.GE6776@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 07:28:04PM +0200, Boris BREZILLON wrote:

> > You should also keep the flush (read of IMR) regardless (to make sure
> > the write has reached the peripheral), and remember to remove the now
> > unused mask variable.
> 
> Does it has something to do with memory barriers ?
> If so, why not using writel instead of writel_relaxed ?

You only need to use the non-relaxed version when synchronising with DMA
operations.

The read-back of a register on the same device is a common technique to
make sure that preceding write has actually reached the peripheral
(write posting or flushing). In this case, it is used to make
(reasonably) sure that interrupts have actually been masked before
returning. (In the general case, you'd even need to verify the read-back
value to be certain that the device has changed its state.)

Johan
