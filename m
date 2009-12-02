From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Dec 2009 11:20:57 +0000
Subject: [PATCH 4/7] S3C64XX: Declare IISv4 PCLK for S3C6410
In-Reply-To: <20091201214201.GP4808@trinity.fluff.org>
References: <20091127164312.GA11913@rakim.wolfsonmicro.main>
	<1259340239-12067-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20091201214201.GP4808@trinity.fluff.org>
Message-ID: <20091202112057.GB12661@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2009 at 09:42:01PM +0000, Ben Dooks wrote:
> On Fri, Nov 27, 2009 at 04:43:56PM +0000, Mark Brown wrote:

> > [Updated the device ID to -1 since there's only one IISv4 device but the
> > S3C clock API tries to match based on the ID of the requesting device

> I had a quick look at the other clock changes and there are a couple
> of questions that have come up:

> 1) If changing the .id field of the iisv4 device really a good idea,
>    especially if there might be more than one of them in the future?

Half the problem here is that the current S3C clock implementation is
doing a half clkdevish thing and matching on the id field of the struct
device that gets passed in with no indirection.  This means that the
either the devices or the clocks need their ids fixing to match the
other.  If we're worrying about further chips sharing the same clock
tree definition tables we also need to worry about the possibility that
a chip is going to come along which swaps out the hookup for one IP
block with another unrelated IP block.

With the current scheme I imagine that all of this would be handled with
conditional registration of the affected clocks based on the chip we're
running on.

> 2) The clock name for the current audio bus clock for the iisv4 unit
>    is wrong as we're using it for both the iis and iisv4 blocks. It

I'm not sure what you mean by this.  The IIS and IISv4 blocks both use
the same clock names in their documentation (as does the PCM block).

>    might be worth renaming the clock for the iisv4 audio bus before
>    looking at changing the usage of the clock support (once the current
>    changes have been sorted)

What name would you suggest?

> As such is the #ifdef of the clock code when the S3C6410 support
> really necesary?

I inherited that bit from Jassi's original patch.  The IISv4 block is
not present on the S3C6400 so it didn't seem unreasonable.
