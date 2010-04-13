From: al@alarsen.net (Anders Larsen)
Date: Tue, 13 Apr 2010 10:46:50 +0200
Subject: [PATCH 2/2] AT91 slow-clock resume: don't restore the PLL
	settings when the PLL was off
In-Reply-To: <w2ocd73a99e1004130114g1e46ed2blbcfeef1c9cec0001@mail.gmail.com>
References: <w2ocd73a99e1004130114g1e46ed2blbcfeef1c9cec0001@mail.gmail.com>
Message-ID: <1271148410l.25331l.4l@i-dmzi_al.realan.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 2010-04-13 10:14:53, Andrew Victor wrote:
> > + ? ? ? tst ? ? r3, #(AT91_PMC_MUL & ?0xff0000)
> > + ? ? ? bne ? ? 1f
> > + ? ? ? tst ? ? r3, #(AT91_PMC_MUL & ~0xff0000)
> > + ? ? ? beq ? ? 2f
> > +1:
> > ? ? ? ?wait_pllblock
> > +2:
> 
> AT91_PMC_MUL is 11 bits (so 0x7ff0000)

it's not possible to use that constant directly; there are too many bits
set (the ARM instruction set has room for an 8-bit constant and a shift
value)...

> Is the mask (0xff0000) correct in the above code?
> It looks like wait_pllblock will be skipped if the MUL field is set to
> 0x100, 0x200, 0x300, etc.

...so I made the test a two-step process; the first 'tst' checks if
the bits masked by (AT91_PMC_MUL & 0xff0000) = 0x00ff0000 are all zero,
the second 'tst' checks if the bits masked by
(AT91_PMC_MUL & ~0xff0000) = 0x07000000 are zero, so all 11 bits are
indeed tested.

There might well be an easier way to do this, but I didn't manage to
find it - the code isn't on a hot path anyway (it's executed _once_ upon
resume after suspend).

Cheers
Anders
