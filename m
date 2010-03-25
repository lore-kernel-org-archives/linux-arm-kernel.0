From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 12:16:14 +0000
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <1269518557.10064.14.camel@e102109-lin.cambridge.arm.com>
References: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
	<1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>
	<s5h39zou023.wl%tiwai@suse.de>
	<20100325113019.GA6590@n2100.arm.linux.org.uk>
	<s5hvdckskev.wl%tiwai@suse.de> <4BAB4DE8.1030707@mvista.com>
	<1269518557.10064.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100325121614.GC6590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 12:02:37PM +0000, Catalin Marinas wrote:
> I can confirm that it solves the reset issue on other RealView boards as
> well. Whether it's the correct fix I can't tell.

Something else is going on then.  Whatever, this patch is totally
incorrect and needs to be reverted.  It's not even doing what the
description in the documentation requires.

I quote from page 3-18, which is mentioned in the commit message which
added this code:

  Data transmitted on slot 2 register, AACISL2TX The AACISL2TX register
  is a read/write register. When a write occurs to this register the data
  it contains is sent on the next available frame in slot 2. If a power
  down is required, then data must be written to AACISL1TX location
  address 0x26, which is recorded by the PrimeCell AACI. If the AACISL2TX
  bit 16 is set, then the PrimeCell AACI goes into power down mode.
  Table 3-11 shows the bit assignment of the AACISL2TX register.

And this is definitely NOT what Philby's code is doing.

The original commit is wrong on soo many levels.
