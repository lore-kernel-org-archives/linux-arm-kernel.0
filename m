From: mark.roszko@gmail.com (Mark Roszko)
Date: Thu, 6 Mar 2014 08:48:33 -0500
Subject: [PATCH v2] i2c:at91: Add device tree property to set
 clock-frequency
In-Reply-To: <20140228110506.GF11192@ldesroches-Latitude-E6320>
References: <1393293045-31849-1-git-send-email-mark.roszko@gmail.com>
 <20140228110506.GF11192@ldesroches-Latitude-E6320>
Message-ID: <CAJjB1qLXnO-Zkte3vg_X5ktXmj1=tG+p5BcLX9vbCgzyfg_rWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CCing the subsystem maintainer because I left him out on the initial send.

On Fri, Feb 28, 2014 at 6:05 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> On Mon, Feb 24, 2014 at 08:50:45PM -0500, Marek Roszko wrote:
>> This adds the ability to set "clock-frequency" in the device tree for the i2c bus following
>> the naming of other i2c bus implementations. If the property is not set, the clock
>> frequency will default to the previously used define of 100KHz.
>>
>> Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Thanks
>
>> ---
>> v2:
>>       -fixed return code usage and check to not compare agaisnt less than zero
>>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-at91.txt |    2 ++
>>  drivers/i2c/busses/i2c-at91.c                      |   10 ++++++++--
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
>> index 4fade84..388f0a2 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
>> @@ -12,6 +12,7 @@ Required properties :
>>  - clocks: phandles to input clocks.
>>
>>  Optional properties:
>> +- clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults to 100000
>>  - Child nodes conforming to i2c bus binding
>>
>>  Examples :
>> @@ -23,6 +24,7 @@ i2c0: i2c at fff84000 {
>>       #address-cells = <1>;
>>       #size-cells = <0>;
>>       clocks = <&twi0_clk>;
>> +     clock-frequency = <400000>;
>>
>>       24c512 at 50 {
>>               compatible = "24c512";
>> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
>> index 843d012..a407050 100644
>> --- a/drivers/i2c/busses/i2c-at91.c
>> +++ b/drivers/i2c/busses/i2c-at91.c
>> @@ -32,7 +32,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/platform_data/dma-atmel.h>
>>
>> -#define TWI_CLK_HZ           100000                  /* max 400 Kbits/s */
>> +#define DEFAULT_TWI_CLK_HZ           100000          /* max 400 Kbits/s */
>>  #define AT91_I2C_TIMEOUT     msecs_to_jiffies(100)   /* transfer timeout */
>>  #define AT91_I2C_DMA_THRESHOLD       8                       /* enable DMA if transfer size is bigger than this threshold */
>>
>> @@ -711,6 +711,7 @@ static int at91_twi_probe(struct platform_device *pdev)
>>       struct resource *mem;
>>       int rc;
>>       u32 phy_addr;
>> +     int bus_clk_rate;
>>
>>       dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>>       if (!dev)
>> @@ -756,7 +757,12 @@ static int at91_twi_probe(struct platform_device *pdev)
>>                       dev->use_dma = true;
>>       }
>>
>> -     at91_calc_twi_clock(dev, TWI_CLK_HZ);
>> +     rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
>> +                     &bus_clk_rate);
>> +     if (rc)
>> +             bus_clk_rate = DEFAULT_TWI_CLK_HZ;
>> +
>> +     at91_calc_twi_clock(dev, bus_clk_rate);
>>       at91_init_twi_bus(dev);
>>
>>       snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Mark
