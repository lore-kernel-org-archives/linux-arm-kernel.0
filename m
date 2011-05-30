From: olof@lixom.net (Olof Johansson)
Date: Mon, 30 May 2011 16:49:09 -0700
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <1306798032.7481.641.camel@pasglop>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
	<4DE336A1.5040509@firmworks.com>
	<20110530070138.GA5036@opensource.wolfsonmicro.com>
	<1306798032.7481.641.camel@pasglop>
Message-ID: <20110530234909.GA3411@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 09:27:12AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2011-05-30 at 15:01 +0800, Mark Brown wrote:
> > On Sun, May 29, 2011 at 08:18:09PM -1000, Mitch Bradley wrote:
> > 
> > > I'm currently dealing with an SoC that has over a hundred GPIOs.
> > > Whatever we choose, I think it should be able to handle an insane
> > > number of GPIOs without getting any more cumbersome that is
> > > necessary.
> > 
> > This is *consumer* side GPIOs, not bindings for the device providing the
> > GPIOs.  If a single device needs to use hundreds of GPIOs I'd expect
> > many of them will be block functions so you'd have a binding with an
> > array for things like "databus" and "addrbus".
> 
> Yes. Agreed. The producer remains identified by phandle/gpio#, so it's
> just a naming thing on the consumer side.
> 
> So what are the options ?
> 
>  - gpio-xxxx = < ... > properties
> 
>  - existing binding, along with an optional gpio-names string list
> 
>  - anything else ?

The producer side works fine as-is, agreed.

What I was not sure about was the use of having an array of unnamed
gpios as part of the consumer-side binding, where there's no logical
ordering between these entries.

In the sdhci case, there are three gpios; one to supply power to the slot;
one for card detect and one for write protect sense.

In that case, it would make a whole lot more sense to have three separate
properties, say "power-gpio", "cd-gpio" and "wp-gpio", than an opaque array of
entries without description besides what comments are used in the dts file.

That these in turn point just to gpio number <x> at controller <y> is OK with
me. Also, I can see cases where it makes sense to have more than one gpio
references in a property (i.e. busses), but only where there's either internal
ordering to them, or where ordering doesn't matter at all.


-Olof
