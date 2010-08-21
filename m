From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 21 Aug 2010 09:36:21 +0200
Subject: [spi-devel-general] [PATCH] SPI: moved the PL022 test chip out to
	the SPI subsystem v2
In-Reply-To: <AANLkTimD=MTn-=EB1Kt87tz9bSVUq+mbZwoOxDbG5sbr@mail.gmail.com>
References: <1280045963-10564-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTimD=MTn-=EB1Kt87tz9bSVUq+mbZwoOxDbG5sbr@mail.gmail.com>
Message-ID: <AANLkTimF5TtEh117Hjc2c16T-wg2oqig8B1Zvr4bVzYP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/1 Grant Likely <grant.likely@secretlab.ca>:
> On Sun, Jul 25, 2010 at 2:19 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> This moves the SPI test chip from the U300 architecture to the
>> SPI subsystem. This is where the code belongs: we want the
>> loopback test chip to be available to all users of PL022.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>
> Better, but not quite right yet in my opinion. ?With the code now
> embedded into the driver (which I agree with), there is no need to
> create a dummy spi_device any more. ?What is this code intended to
> test? ?The hardware, or the spi subsystem. ?If it is to test the
> hardware (which I suspect), then just driver the hardware directly
> (using the driver's own access functions of course). ?You don't need
> to register a dummy spi_device for that because it is all driver
> internal.

Sorry for a late answer.

I've been trying to address these goals,
but since the pl022 message queueing, interrupt handling and
most everything is based on using struct spi_message and since
all message transfer helpers (such as spi_write_then_read()) take
an struct spi_device * as argument, and at some point using the
internal functions from the outside with struct spi_message involves
setting the .spi field of the message to something, so obviously that
would fall back to the old solution.

This makes it necessary to refactor the entire driver and queueing
mechanism to take some wrapper message derived from the
spi_message that can work on loops without ever using
struct spi_message by having some .is_loop bool or so.

That's a little much overhead for just adding some hardware tests
and breaks the design pattern from the rest of the SPI drivers...

Isn't it easier to just say that any tests *must* be done from
userspace, leading to the logical conclusion:

> If it goal is to exercise the spi subsystem, then do it from userspace
> with the loopback flag set, and add loopback flag support to the
> driver.  You don't need to test all the modes of the hardware in this
> situation.

No problem with that. But as clarified in the earlier discussion
with Ben, this is not possible if there are no devices attached to
the bus. This is often the case when you want to exercise some
bare hardware where there is no actual SPI device attached to
the bus. And since the idea was to use the loopback (i.e. not
communicating with any actual device) this leads to the addition
of a dummychip for loopback tests anyway.

I'll assume this latter approach is what is really desired and cook
up a patch for that (just a Kconfig for adding the dummychip, no
debugfs intrinsic tests) for the moment.

The patch as it stands (and works today on the U300
dummychip) is just the latter solution with an in-kernel
exerciser.

Yours,
Linus Walleij
