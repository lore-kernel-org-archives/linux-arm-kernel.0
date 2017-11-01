From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 1 Nov 2017 20:39:51 +0100 (CET)
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
Message-ID: <alpine.DEB.2.20.1711012032080.1942@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Nov 2017, Marc Gonzalez wrote:

> On 01/11/2017 18:53, Alan Cox wrote:
> 
> > On Tue, 31 Oct 2017 17:15:34 +0100
> >
> >> Therefore, users are accustomed to having delays be longer (within a reasonable margin).
> >> However, very few users would expect delays to be *shorter* than requested.
> > 
> > If your udelay can be under by 10% then just bump the number by 10%.
> 
> Except it's not *quite* that simple.
> Error has both an absolute and a relative component.
> So the actual value matters, and it's not always a constant.
> 
> For example:
> http://elixir.free-electrons.com/linux/latest/source/drivers/mtd/nand/nand_base.c#L814

That example is really pointless, because the only effect it does is to
delay the read of the ready/busy pin long enough to bridge the silly gap
between
	     |-----------------------	
CS	_____|

and
	-------|
R/B	       |_____________________

IIRC, the gap is in the low single digit nsec range, so it really does not
matter how long you delay here. In fact on most older CPUs excuting the 3
instructions even if it returned immediately were sufficient.

Any real NAND controller, not the stupid PIO based ones we had 15 years
ago, should not even make it necessary to handle that on the software
side. Simply because the controller should already take care of that and
not blindly reflect the status of the R/B pin in the status register. If
your hardware does that, then poke that HW dude on the desk next to yours
with a big cluestick.

Thanks,

	tglx
