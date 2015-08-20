From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Aug 2015 09:59:27 +0800
Subject: [PATCH v3 0/8] ARM: sunxi: Add Reduced Serial Bus support
In-Reply-To: <20150819163232.GS10748@sirena.org.uk>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
 <20150819163232.GS10748@sirena.org.uk>
Message-ID: <CAGb2v66X-CMQiS1dNqhwamTsVbnf+7siSTV3xGwn-C91Zhw3uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 12:32 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 19, 2015 at 12:20:01PM +0800, Chen-Yu Tsai wrote:
>> Hi everyone,
>>
>> This is my third attempt at adding support for Allwinner's Reduced
>> Serial Bus (RSB), which is used to communicate with PMICs and other
>> peripherals on their newer SoCs, such as the A23/A33/A80.
>
> This is flagged as something that is specific to the Allwinner SoCs.
> Why add generic regmap support rather than just implement the regmap
> reg_read() and reg_write() in a regmap in the controller driver?  Are
> there expected to be other controller drivers from other vendors?

I don't expect there to be any other controller drivers. And it seems
at least some of the devices are dual interface (I2C/RSB). Though I
don't see how its connected to the generic regmap support. Regmap
is for device drivers connected to the RSB bus, not the bus controller
itself.

That said, there are a few RSB mfd slave devices that need support,
those being the later AXP series PMICs, and AC100/AC200 audio-codec/RTC
chips. The current axp20x driver already uses i2c regmaps.

I could throw all the RSB-related stuff together, presumably under
drivers/soc/sunxi/rsb, though that doesn't help the fact that common
regmap code would be  better than scattering regmap_* in various mfd
drivers.


Regards
ChenYu
