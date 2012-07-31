From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 12:08:30 +0100
Subject: AB8500 Regulators
In-Reply-To: <50179B64.60209@linaro.org>
References: <501690F7.2010904@linaro.org>
 <20120730152618.GI4468@opensource.wolfsonmicro.com>
 <5016B70A.1030601@linaro.org>
 <20120730174831.GP4468@opensource.wolfsonmicro.com>
 <50179B64.60209@linaro.org>
Message-ID: <20120731110830.GY4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 09:46:28AM +0100, Lee Jones wrote:

> Please listen to what I'm saying as a whole. Breaking that paragraph
> up takes it entirely out of context. I'm mostly agreeing with what
> you're saying, and asking you some advice.

That's unfortunately not how it comes over (especially in the context of
some of the other serieses), it really feels like a lot of work to find
out what these magic register writes are supposed to do.

> - I now know how the changing voltage API works
>   - What I don't know is where we'd call it from to initialise them
>   - Can we do that from the ab8500 regulator driver's init() or probe()?

I'm surprised you've managed to miss the existing interfaces:

   include/linux/regulator/machine.h
   Documentation/devicetree/bindings/regulator/regulator.txt

> - WRT the 'valid' registers, I'm not sure what they do. The doc says:
>   "Supply control thru Hardware signal and SysClkReq balls validation."
>   - More comments on what the writes do individually can be seen in [1]
>   - Perhaps we can extend the API thus:

These things don't tie very well.  The comments in the sequences look
reasonably meaningful but you're saying the datasheet doesn't document
anything at all.

> >+       u8 valid_bank;
> >+       u8 valid_reg;
> >+       u8 valid_mask;
> >+       u8 valid_val_enable;

> Then I think most (if not all) of our bases are covered.

No, there's a whole series of problems here.  The most serious one is
that "valid" means nothing, we need *some* effort at semantics here.
We're also going to run into trouble as soon as we've got to update two
different registers.

It looks like you're trying to put something vaugely like regmap patches
into the regulator API, but it seems fairly clear that this stuff is
board specific configuration rather than things that should be blasted
in unconditionally on any board.
