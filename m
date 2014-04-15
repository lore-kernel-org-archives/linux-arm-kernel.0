From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 15 Apr 2014 14:40:46 +0200
Subject: [RFC PATCH v2] regmap: smbus: add support for regmap over SMBus
In-Reply-To: <534D252B.8060009@metafoo.de>
References: <1397292335-5516-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397480885-11962-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140414210429.GJ25182@sirena.org.uk> <534CE16D.8010508@free-electrons.com>
 <20140415100922.GN12304@sirena.org.uk> <534D1DDA.40207@free-electrons.com>
 <534D252B.8060009@metafoo.de>
Message-ID: <534D28CE.8020006@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15/04/2014 14:25, Lars-Peter Clausen wrote:
> On 04/15/2014 01:54 PM, Boris BREZILLON wrote:
>>
>>
>> On 15/04/2014 12:09, Mark Brown wrote:
>>> On Tue, Apr 15, 2014 at 09:36:13AM +0200, Boris BREZILLON wrote:
>>>> On 14/04/2014 23:04, Mark Brown wrote:
>>
>>>>> The transfer type gets set once per device at init time so why not
>>>>> just parameterise based on val_bytes?
>>
>>>> Actually, you may want to transfer 1 byte registers using the block
>>>> method (if your device only support block transfers). This depends on
>>>> the device being accessed and what it supports, but I'm not sure we
>>>> can
>>>> assume 1 byte registers will always be transferred using SMBUS byte
>>>> transfers.
>>
>>> OK, so if this a realistic issue then it seems like it's better to
>>> implement three different buses - there is not really any common code
>>> between the various paths.
>>
>> Okay, I'll create 4 different busses (one for each access type).
>> BTW, should I keep these implementations in the same source file
>> (regmap-smbus.c) ?
>> And, should I keep one method to register an smbus regmap or should I
>> provide one method per access type and get rid of the
>> regmap_smbus_transfer_type enum ?
>
> I don't think we should leave the decision which bus to use to the
> driver. Neither should the driver have to choose whether to use smbus
> or native I2C. We want to use native I2C when available, because it is
> more efficient than going through the smbus emulation layer. On the
> other hand we want to automatically switch to smbus when native I2C is
> not available and the device can work fine with smbus. Also I'm afraid
> that we'll otherwise soon see code popping up like:
>
> if (of_property_read_bool(np, "use-smbus-regmap"))
>     regmap = regmap_init_smbus(...)
> else
>     regmap = regmap_init_i2c(...)
>
> My suggestion is that in regmap_init_i2c() you check the capabilities
> of the I2C adapter. If it supports native I2C you setup the regmap
> with the regmap_i2c struct just as it does right now. If the adapter
> does not support native I2C, check if the device can be supported by
> smbus (reg_bytes == 8 && val_bytes % 8 == 0). For each type of smbus
> operations have one regmap_bus struct, and if you can fallback to
> smbus choose the bus depending on the config's val_bytes.
>

What if the device only support SMBus block transfers, but the adapter
support both regular I2C and SMBus block transfers (don't know if such a
device exist :-)) ?

My point is that I'm not sure the core remap-i2c code can decide whether
to use SMBus or I2C transfer only from val_bytes value, but I might be
wrong.

Best Regards,

Boris

> - Lars

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
