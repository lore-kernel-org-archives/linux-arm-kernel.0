From: jeffy.chen@rock-chips.com (jeffy)
Date: Mon, 12 Jun 2017 16:26:07 +0800
Subject: [PATCH 1/2] spi: rockchip: add support for "cs-gpios" dts property
In-Reply-To: <dfe87919-b2cc-37e8-1598-6b3c730ff356@rock-chips.com>
References: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com>
 <dfe87919-b2cc-37e8-1598-6b3c730ff356@rock-chips.com>
Message-ID: <593E501F.5060906@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 06/12/2017 03:15 PM, Shawn Lin wrote:
> Hi Jeffy,
>
> On 2017/6/12 14:14, Jeffy Chen wrote:
>> Support using "cs-gpios" property to specify cs gpios.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   .../devicetree/bindings/spi/spi-rockchip.txt       |  2 +
>>   drivers/spi/spi-rockchip.c                         | 52
>> ++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
>> b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
>> index 83da493..02171b2 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
>
> The changes for doc should be another patch, and...

but i saw others didn't separate them:
cf9e478 spi: sh-msiof: Add slave mode support
23e291c spi: rockchip: support "sleep" pin configuration


>
>> @@ -17,6 +17,7 @@ Required Properties:
>>          region.
>>   - interrupts: The interrupt number to the cpu. The interrupt
>> specifier format
>>                 depends on the interrupt controller.
>> +- cs-gpios : Specifies the gpio pins to be used for chipselects.
>
> It's not a required property, otherwise how other boards work as your
> patch 2 only add this for rk3399-gru.
oops, i will fix it.
>
>>   - clocks: Must contain an entry for each entry in clock-names.
>>   - clock-names: Shall be "spiclk" for the transfer-clock, and
>> "apb_pclk" for
>>                  the peripheral clock.
>> @@ -48,6 +49,7 @@ Example:
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>>           interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
>> +        cs-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
>>           clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
>>           clock-names = "spiclk", "apb_pclk";
>>           pinctrl-0 = <&spi1_pins>;
>> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
>> index acf31f3..04694e1 100644
>> --- a/drivers/spi/spi-rockchip.c
>> +++ b/drivers/spi/spi-rockchip.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/dmaengine.h>
>> +#include <linux/gpio.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/pinctrl/consumer.h>
>> @@ -201,6 +202,10 @@ struct rockchip_spi {
>>       struct dma_slave_caps dma_caps;
>>   };
>> +struct rockchip_spi_data {
>> +    bool cs_gpio_requested;
>> +};
>> +
>
> Could you fold cs_gpio_requested into struct rockchip_spi?
>
>>   static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
>>   {
>>       writel_relaxed((enable ? 1 : 0), rs->regs + ROCKCHIP_SPI_SSIENR);
>> @@ -297,6 +302,50 @@ static void rockchip_spi_set_cs(struct spi_device
>> *spi, bool enable)
>>       pm_runtime_put_sync(rs->dev);
>>   }
>> +static int rockchip_spi_setup(struct spi_device *spi)
>> +{
>> +    int ret = 0;
>> +    unsigned long flags = (spi->mode & SPI_CS_HIGH) ?
>> +                  GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
>> +    struct rockchip_spi_data *data = spi_get_ctldata(spi);
>> +
>> +    if (!gpio_is_valid(spi->cs_gpio))
>> +        return 0;
>
> return -EINVAL?
i think we can still support the original way, which means no "cs-gpios" 
and do nothing in setup.
>
>> +
>> +    if (!data) {
>> +        data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +        if (!data)
>> +            return -ENOMEM;
>> +        spi_set_ctldata(spi, data);
>> +    }
>> +
>> +    if (!data->cs_gpio_requested) {
>> +        ret = gpio_request_one(spi->cs_gpio, flags,
>> +                       dev_name(&spi->dev));
>> +        if (!ret)
>> +            data->cs_gpio_requested = 1;
>> +    } else
>> +        ret = gpio_direction_output(spi->cs_gpio, flags);
>
> need brace around 'else' statement. Also I don't see data used
> elsewhere, so you need these code above.
ok.
and the cs_gpio_requested is to mark cs_gpio requested, because the 
setup func might be called multiple times, we only need to request gpio 
at the first time.
>
>> +
>> +    if (ret < 0)
>> +        dev_err(&spi->dev, "Failed to setup cs gpio(%d): %d\n",
>> +            spi->cs_gpio, ret);
>> +
>> +    return ret;
>> +}
>> +
>> +static void rockchip_spi_cleanup(struct spi_device *spi)
>> +{
>> +    struct rockchip_spi_data *data = spi_get_ctldata(spi);
>> +
>> +    if (data) {
>> +        if (data->cs_gpio_requested)
>> +            gpio_free(spi->cs_gpio);
>> +        kfree(data);
>> +        spi_set_ctldata(spi, NULL);
>> +    }
>> +}
>> +
>>   static int rockchip_spi_prepare_message(struct spi_master *master,
>>                       struct spi_message *msg)
>>   {
>> @@ -744,11 +793,14 @@ static int rockchip_spi_probe(struct
>> platform_device *pdev)
>>       master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
>>       master->set_cs = rockchip_spi_set_cs;
>> +    master->setup = rockchip_spi_setup;
>> +    master->cleanup = rockchip_spi_cleanup;
>>       master->prepare_message = rockchip_spi_prepare_message;
>>       master->unprepare_message = rockchip_spi_unprepare_message;
>>       master->transfer_one = rockchip_spi_transfer_one;
>>       master->max_transfer_size = rockchip_spi_max_transfer_size;
>>       master->handle_err = rockchip_spi_handle_err;
>> +    master->flags = SPI_MASTER_GPIO_SS;
>>       rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
>>       if (IS_ERR(rs->dma_tx.ch)) {
>>
>
>
>
