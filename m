From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 11 Jan 2018 09:16:11 +0100
Subject: [PATCH v2 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20180110203243.GC11260@lunn.ch> (Andrew Lunn's message of "Wed,
 10 Jan 2018 21:32:43 +0100")
References: <20180110170743.27082-1-gregory.clement@free-electrons.com>
 <20180110170743.27082-3-gregory.clement@free-electrons.com>
 <20180110203243.GC11260@lunn.ch>
Message-ID: <87lgh47qus.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On mer., janv. 10 2018, Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Jan 10, 2018 at 06:07:43PM +0100, Gregory CLEMENT wrote:
>> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
>> is optional because not all the SoCs need them but at least for Armada
>> 7K/8K it is actually mandatory.
>> 
>> The binding documentation is updating accordingly.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++++++++
>>  drivers/i2c/busses/i2c-mv64xxx.c                     | 12 +++++++++++-
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> index 5c30026921ae..a835b724c738 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> @@ -25,6 +25,15 @@ default frequency is 100kHz
>>                       whenever you're using the "allwinner,sun6i-a31-i2c"
>>                       compatible.
>>  
>> + - clocks:	   : pointers to the reference clocks for this device, the first
>> +		     one is the one used for the clock on the i2c bus, the second
>> +		     one is the clock used for the functional part of the
>> +		     controller
>> +
>> + - clock-names	   : names of used clocks, mandatory if the second clock is
>> +		   : used, the name must be "core", and "axi_clk" (the latter is
>> +		     only for Armada 7K/8K).
>
> Hi Gregory
>
> Are these two clocks related?
>
> Ethernet on Dove needs two clocks enabled. 
>
> static const struct clk_gating_soc_desc dove_gating_desc[] __initconst = {
>        { "usb0", NULL, 0, 0 },
>        { "usb1", NULL, 1, 0 },
>        { "ge",	 "gephy", 2, 0 },
>        { "sata", NULL, 3, 0 },
>
> ge has a parent clock gephy. When you enable ge, the common clock code
> walks up the tree of clocks, so will also turn on gephy.
>
> Does this child/parent relationship exist with these i2c clocks?

The child/parent relationship was the wrong assumption we made when we
wrote the clock driver for Armada 7K/8K. But now with more
documentation, it turned out that these 2 clocks are independant but
both are needed for i2c on Armada 7K/8K.

Gregory


>
>      Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
