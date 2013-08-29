From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 19:01:01 +0100
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
Message-ID: <20130829180101.GO10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 08:42:11AM -0700, Russ Dill wrote:

> The path I'm taking in this patchset is to just put the board specific
> I2C sequences necessary for the CM3 coprocessor to write out into the
> devicetree. I've made it as generic as I can so that other platforms
> with similar issues can reuse the bindings. Because of the limitations
> of the firmware size and the desire not to have some sort of byte
> code, this is a write only sequence.

Making it write only seems to be a mistake - like I said in my other
mail I'd expect you'd want bitfield updates here.  The read and modify
could be done earlier by Linux though.

> Kevin Hilman is suggesting some way to query the regulator framework
> for this sequence. There would be some call to the regulator framework
> that would return a series of I2C commands that would be necessary to
> program a regulator to a specific voltage. It would be called twice,
> once for the suspend voltage, once for the resume voltage. The
> regulator framework would then call into the driver that sets that
> voltage, and by some method query the driver for the necessary I2C
> sequence, either by some special new call, or some regmap magic.

If it's just setting a single voltage then extracting the bitfield to
update shouldn't be too hard for regmap based regulators.  Off the top
of my head I'd expect either the driver for the M3 or the cpuidle driver
that talks to it to be a consumer of the regulator and then go from
there.

Just putting the sequence directly into the device tree doesn't feel
like the right abstraction.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/c308dfaa/attachment.sig>
