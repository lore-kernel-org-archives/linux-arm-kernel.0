From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 13:30:36 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <AANLkTikLABG5yWDYcOe12mfy_Hco15k_ByqYX15GH9Cy@mail.gmail.com>
References: <20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
	<AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
	<20110124160127.GA24104@n2100.arm.linux.org.uk>
	<AANLkTi=GmYoDYhKGpvzt2vHWSEb2b72cQbQfVc4PANdH@mail.gmail.com>
	<20110124212228.GN24104@n2100.arm.linux.org.uk>
	<AANLkTimReBj7QGw08imBV2JWJGwh-TO5oA+3kiFQZLq4@mail.gmail.com>
	<20110125102351.GA11507@n2100.arm.linux.org.uk>
	<AANLkTikLABG5yWDYcOe12mfy_Hco15k_ByqYX15GH9Cy@mail.gmail.com>
Message-ID: <20110201133036.GI31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 02:07:21PM +0100, Linus Walleij wrote:
> 2011/1/25 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > The DMA controller must be programmed with the right burst size for the
> > peripheral, which in this case would be 8 words, otherwise the 'last'
> > burst signalling goes wrong.
> 
> Now I think I found the real bug behind this...
> 
> In the Vendor data we set this:
> 	.dmareg_enable		= 1 << 12, /* DMAREQCTRL */
> 
> This actually means:
> 
> DMAREQCTL: DMA requests control.
> 0: SREQ are generated when data to be transferred is
> less than 8 words.
> 1: no SREQ is generated when data to be transferred
> is less than 8 words, LBREQ is generated instead.
> 
> Which will work for all MMC card transfers I believe, since
> these are even 512 byte multiples. No problem...
> 
> Then comes an SDIO request and it is 7 bytes so LBREQ
> is emitted 7 times instead of 6 * SREQ + 1 LSREQ.
> 
> Which works if you set down the burst size to 1 byte,
> firing 7 consecutive bursts each terminated with LBREQ
> which the DMA controller is perfectly happy with.
> 
> So while setting the burstsize down to 1 byte works
> since it matches the twisted logic of DMAREQCTL,
> instead flipping the bit in DMAREQCTL to 0
> if (size % 8 != 0) makes some more kind of sense.
> 
> This needs to be tested to see whether it works or
> not, so I'll see what we can do.

I really can't see this making any difference.  In the case of a 7 word
transfer, you've setup the DMA controller to transfer 7 * 4 = 28 bytes.

1. If DMAREQCTL = 1, the MMCI issues a LBREQ.

   If the DMA controller has a burst size of 32 bytes, if it fetches 32
   bytes from the device, it is broken.  It doesn't matter what the
   primecell does - it's the DMA controller misbehaving.  In that case,
   the work-around needs to be in the DMA controller code to reduce the
   bursting so that the DMA controller doesn't transfer more than the
   requested size.

   This is not specific to MMCI as other devices will suffer the same
   problem.  So it's wrong to put it into every primecell driver just
   because someone has a broken DMA controller somewhere.

2. If DMAREQCTL = 0, the MMCI issues six SREQ plus one LSREQ.

   This reflects the behaviour of the ARM primecell, and SREQ should
   result in the DMA controller performing one transfer per request.

So, the solutions as I see it are:

1. If DMAREQCTL = 1, move the burst limiting work-around into the DMA
   engine driver, if it really is a problem.

2. Set DMAREQCTL = 0.

(2) seems to be the most sane solution to me.
