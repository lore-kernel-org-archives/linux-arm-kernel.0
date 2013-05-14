From: neidhard.kim@lge.com (Jongsung Kim)
Date: Tue, 14 May 2013 16:15:39 +0900
Subject: [PATCH] ARM: PL011: add support for extended FIFO-size of
 PL011-r1p5
In-Reply-To: <5191D200.3040604@wwwdotorg.org>
References: <007301ce375e$bcf6d6b0$36e48410$@lge.com>
 <5191D200.3040604@wwwdotorg.org>
Message-ID: <01fd01ce5072$d6b9fcd0$842df670$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> :
> For reference, the AMBA periphid of the UART device there is 0x00341011.
> The nibble "3" is the revision being tested in:

The UART device has periphid 0x00341011, and is compatible with the
original PL011 prior to r1p5. Not with r1p5. It could be a possible
way to specify the compatible periphid (such as 0x00241011) instead
of just 0x0 when initializing the amba_device for the UART.

> > +static unsigned int get_fifosize_arm(unsigned int periphid)
> > +{
> > +	unsigned int rev = (periphid >> 20) & 0xf;
> > +	return rev < 3 ? 16 : 32;
> > +}
>
> Should that be <= not <, or is there just something more wrong in the
> patch or bcm2835 HW? I wonder how r1p5 maps to 3 in the test above.

>From the PL011-r1p5 TRM, bits[7:4] of the UARTPeriphID2 register are
read as:

r1p0 - 0x0
r1p1 - 0x1
r1p3 - 0x2
r1p4 - 0x2
r1p5 - 0x3.

Doesn't the BCM2835 UART have anything different from the ARM PL011?
What about the UARTPCellID registers? They are set to 0xb105f00d with
the ARM PL011.
