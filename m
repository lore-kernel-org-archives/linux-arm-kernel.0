From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 May 2011 15:37:59 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <20110527120725.GV969@shareable.org>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
	<20110527120725.GV969@shareable.org>
Message-ID: <20110527143757.GA14035@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 01:07:26PM +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > With all of them, even writel(), you don't know when the actual
> > hardware write happens. You can issue a DSB after to ensure write
> > completion (I think defined as the device begins to change its state
> > as a result of the write) but you can't tell whether the device
> > finished changing its state. For that you would need other means like
> > reading back from the device.
> 
> With PCI on x86, writel() may not reach the hardware immediately (PCI
> queues the writes), so I believe you need readl() to some register on
> the same device to ensure the write has been acknowledged by the
> device.
> 
> Does DSB on ARM replace the need for that readl()?

The short answer - no.

The long answer, it depends on the bus configuration. For AMBA (and
probably other configurations without complex bridges), DSB guarantees
that the write arrived at the device but does not guarantee that the
device state has been changed. This is enough if you only care about the
ordering in which the writes arrive at two different devices. However,
it is not enough if you rely on some device state being changed before
you do something else which assumes a certain state of that device. A
read back may work but this is device-dependent (though I think commonly
accepted).

I don't think the PCI configurations are different on ARM than x86 as
same chips are used. On PCI you may get a bridge acknowledging the
receiving of a write (which the DSB waits for) even though the device
hasn't got it yet. But as above, if you care about the device state
actually being changed, you need a read back.

-- 
Catalin
