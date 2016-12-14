From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Dec 2016 21:52:31 +0800
Subject: [PATCH v2 2/2] mfd: axp20x: Fix AXP806 access errors on cold boot
In-Reply-To: <20161213164742.4ztisstxifatlm5a@sirena.org.uk>
References: <20161123031616.10114-1-wens@csie.org>
 <20161123031616.10114-3-wens@csie.org>
 <20161209112018.GL3625@dell.home>
 <20161213164742.4ztisstxifatlm5a@sirena.org.uk>
Message-ID: <CAGb2v66vggNNfFrAiNKKGXY0ayiG1qh5tcRok2NLTRkVHWKFeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 12:47 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Dec 09, 2016 at 11:20:18AM +0000, Lee Jones wrote:
>
>> Is the following valid/necessary?
>
>> On Wed, 23 Nov 2016, Chen-Yu Tsai wrote:
>> > The AXP806 supports either master/standalone or slave mode.
>> > Slave mode allows sharing the serial bus, even with multiple
>> > AXP806 which all have the same hardware address.
>
>> > This is done with extra "serial interface address extension",
>> > or AXP806_BUS_ADDR_EXT, and "register address extension", or
>> > AXP806_REG_ADDR_EXT, registers. The former is read-only, with
>> > 1 bit customizable at the factory, and 1 bit depending on the
>
> I don't really know anything about the details of this chip, sorry.

If these 2 registers don't match, any access to the other registers
is ignored, so the kernel either read bogus data, or the read fails.

What this patch does is make sure the registers match, to guarantee
access, and then reinitialize the regmap cache to get rid of any
stale data.

>> > This patch sets AXP806_REG_ADDR_EXT to 0x10, which is what we
>> > know to be the proper value for a standard AXP806 in slave mode.
>> > Afterwards it will reinitialize the regmap cache, to purge any
>> > invalid stale values.
>
> If the chip has been reset then you'd want to reset the cache too.  I've
> no idea if that's needed here or not though, it depends what happens to
> the global state of the chip when this reconfiguration happens.

It is not a reset in the general sense. I suppose a better way would
be to do an explicit write to the register first, then initialize
the regmap. I'd have to export the write function from the RSB bus
driver first though.

Regards
ChenYu
