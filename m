From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Apr 2010 10:39:21 +0100
Subject: [PATCH v2] i2c-s3c2410: Remove unconditional 1ms delay on each
	transfer
In-Reply-To: <4BD7BBF6.9090103@samsung.com>
References: <1270214109-28226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4BD7BBF6.9090103@samsung.com>
Message-ID: <20100428093921.GD31400@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 01:39:18PM +0900, Joonyoung Shim wrote:
> On 4/2/2010 10:15 PM, Mark Brown wrote:

> > Replace the sleep with a spin on the IIC status register for up to 1ms.
> > This will busy wait but testing on my SMDK6410 system indicates that
> > the overwhelming majority of transactions complete on the first spin,
> > with maximum latencies of less than 10 spins so the absolute overhead
> > of busy waiting should be at worst comprable to msleep(), and the
> > overall system performance is dramatically improved.

> I tested this patch on the s5pc110. This occurs msleep(1) still by time 
> out at the my touchscreen i2c device on the s5pc110. It takes 80usec to 
> clear S3C2410_IICSTAT_START bit in the worst case of my touchscreen and
> need about 400 spins. The 1msec delay is overhead to me still now.

Yeah, I did expect we might run on a bit and get into the sleep which is
why I left the fallback for it in there.  I was trying to make as small
a change as possible so that the change would be robust, the performance
win is so dramatic.  I guess tuning up the number of spins would work
well in your case.

One idea that did occur to me while I was looking at this is to change
the code so that if the delay is long instead of waiting for the bus to
go idle at the end of the transaction we do so at the start of the next
transaction.  It's the next one that really cares that the bus has gone
idle, and in a lot of cases there's enough gap between the transactions
due to other work the CPU is doing to mean that there's no need to
explicitly wait at all.
