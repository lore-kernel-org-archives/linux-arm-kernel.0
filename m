From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Jan 2018 12:15:26 +0100
Subject: [PATCH v3 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20180112105434.juefp2apuber3zti@flea.lan> (Maxime Ripard's
 message of "Fri, 12 Jan 2018 11:54:34 +0100")
References: <20180112103956.4875-1-gregory.clement@free-electrons.com>
 <20180112103956.4875-3-gregory.clement@free-electrons.com>
 <20180112105434.juefp2apuber3zti@flea.lan>
Message-ID: <87wp0n5nw1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,
 
 On ven., janv. 12 2018, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,
>
> On Fri, Jan 12, 2018 at 11:39:56AM +0100, Gregory CLEMENT wrote:
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
>> index 5c30026921ae..3d76bb19492f 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> @@ -25,6 +25,15 @@ default frequency is 100kHz
>>                       whenever you're using the "allwinner,sun6i-a31-i2c"
>>                       compatible.
>>  
>> + - clocks:	   : pointers to the reference clocks for this device, the
>> +		     first one is the one used for the clock on the i2c bus,
>> +		     the second one is the clock used for the functional part
>> +		     of the controller
>
> This documentation is confusing, as usually the functional clock is
> the clock driving the bus, as opposed to the interface clock clocking
> the bus interface.

I don't find it less confusing, for my point of view the interface of a
bus is the lines interfacing the bus with the devices on this bus. But I
don't mind modifying it, as I clearly state that the first clock is the
one used to generate the clock of the i2c bus, so we can change the
name.

>
>> + - clock-names	   : names of used clocks, mandatory if the second clock is
>> +		     used, the name must be "core", and "axi" (the latter is
>> +		     only for Armada 7K/8K).
>> +
>
> Are you sure the i2c controller is on the AXI bus? It seems more
> likely to be on an APB bus.

No I am not sure :)
Actually I don't have this information, so lets call it "reg" for
register clock.

Gregory

>
> Maxime
>
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
