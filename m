From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Jan 2011 14:07:21 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <20110125102351.GA11507@n2100.arm.linux.org.uk>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
	<AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
	<20110124160127.GA24104@n2100.arm.linux.org.uk>
	<AANLkTi=GmYoDYhKGpvzt2vHWSEb2b72cQbQfVc4PANdH@mail.gmail.com>
	<20110124212228.GN24104@n2100.arm.linux.org.uk>
	<AANLkTimReBj7QGw08imBV2JWJGwh-TO5oA+3kiFQZLq4@mail.gmail.com>
	<20110125102351.GA11507@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikLABG5yWDYcOe12mfy_Hco15k_ByqYX15GH9Cy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/25 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> The DMA controller must be programmed with the right burst size for the
> peripheral, which in this case would be 8 words, otherwise the 'last'
> burst signalling goes wrong.

Now I think I found the real bug behind this...

In the Vendor data we set this:
	.dmareg_enable		= 1 << 12, /* DMAREQCTRL */

This actually means:

DMAREQCTL: DMA requests control.
0: SREQ are generated when data to be transferred is
less than 8 words.
1: no SREQ is generated when data to be transferred
is less than 8 words, LBREQ is generated instead.

Which will work for all MMC card transfers I believe, since
these are even 512 byte multiples. No problem...

Then comes an SDIO request and it is 7 bytes so LBREQ
is emitted 7 times instead of 6 * SREQ + 1 LSREQ.

Which works if you set down the burst size to 1 byte,
firing 7 consecutive bursts each terminated with LBREQ
which the DMA controller is perfectly happy with.

So while setting the burstsize down to 1 byte works
since it matches the twisted logic of DMAREQCTL,
instead flipping the bit in DMAREQCTL to 0
if (size % 8 != 0) makes some more kind of sense.

This needs to be tested to see whether it works or
not, so I'll see what we can do.

Yours,
Linus Walleij
