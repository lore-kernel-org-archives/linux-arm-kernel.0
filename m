From: peda@lysator.liu.se (Peter Rosin)
Date: Mon, 12 Oct 2015 17:13:55 +0200
Subject: Regression: at24 eeprom writing
In-Reply-To: <561292AC.8060408@lysator.liu.se>
References: <560F0DB1.2020101@lysator.liu.se>
 <561238A9.1060406@lysator.liu.se> <20151005150032.GA12137@odux.rfo.atmel.com>
 <561292AC.8060408@lysator.liu.se>
Message-ID: <561BCE33.2050904@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-10-05 17:09, Peter Rosin wrote:
> But what trouble does the i2c bus driver see? Admittedly I only
> have a simple logic level bus viewer, and not a full-blown
> oscilloscope, so there might be something analogue going on?
> I don't think so though, those signals looked fine last time we
> looked (but we obviously didn't have these issues then, and
> didn't really look that closely). I'll see if I can recheck
> with a real scope too.

We redid the tests with a real scope, and the signal looks nice
and square, so it is not that.

Speculating further on the cause of the long ACKs, I think that
the i2c driver gets confused by an interrupt that marks the
transfer complete, and thinks it's a NACK interrupt instead. Is that
plausible?

If the peripheral unit is such that it generates a stop automatically
on NACKs, then this makes perfect sense. I.e. the TWI sees that the
transfer is complete, generates an interrupt, and waits for further
data or a stop command. Meanwhile the driver thinks it's a NACK and
that a stop condition has already been sent to the bus, and just
notifies the i2c consumer (the eeprom driver in this case) of the
failure and frees up the bus for any future user.

This also matches what I see when I turn on some more traffic on the
bus, that is interleaved with the eeprom traffic. AFAICT, it can be
any command that gets chewed up by the eeprom if it is sent to the
i2c driver during the long ACK.

Are you Atmel people making any progress on this data corrupting
regression? Is there anything else I can do to help?

Cheers,
Peter
