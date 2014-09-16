From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Sep 2014 22:13:27 +0800
Subject: [PATCH 2/3] dmaengine: sun6i: Add support for Allwinner A23
 (sun8i) variant
In-Reply-To: <20140916103540.GF9948@lukather>
References: <1410616381-30226-1-git-send-email-wens@csie.org>
 <1410616381-30226-3-git-send-email-wens@csie.org>
 <20140916103540.GF9948@lukather>
Message-ID: <CAGb2v67jokpXHxR26YoCEB2Y_v07oQZXZfPuGJC_wO=r-SRZhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 6:35 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Sep 13, 2014 at 09:53:00PM +0800, Chen-Yu Tsai wrote:
>> The A23 SoC has the same dma engine as the A31 (sun6i), with a
>> reduced amount of endpoints and physical channels. Add the proper
>> config data and compatible string to support it.
>>
>> A slight difference in sun8i is an undocumented register needs
>> to be toggled for dma to function.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  Documentation/devicetree/bindings/dma/sun6i-dma.txt |  2 +-
>>  drivers/dma/Kconfig                                 |  4 ++--
>>  drivers/dma/sun6i-dma.c                             | 20 ++++++++++++++++++++
>>  3 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
>> index 3e145c1..9cdcba24d 100644
>> --- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
>> +++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
>> @@ -4,7 +4,7 @@ This driver follows the generic DMA bindings defined in dma.txt.
>>
>>  Required properties:
>>
>> -- compatible:        Must be "allwinner,sun6i-a31-dma"
>> +- compatible:        Must be "allwinner,sun6i-a31-dma" or "allwinner,sun8i-a23-dma"
>>  - reg:               Should contain the registers base address and length
>>  - interrupts:        Should contain a reference to the interrupt used by this device
>>  - clocks:    Should contain a reference to the parent AHB clock
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 9b1ea0e..5361aa7 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -395,12 +395,12 @@ config XILINX_VDMA
>>
>>  config DMA_SUN6I
>>       tristate "Allwinner A31 SoCs DMA support"
>> -     depends on MACH_SUN6I || COMPILE_TEST
>> +     depends on MACH_SUN6I || MACH_SUN8I || COMPILE_TEST
>>       depends on RESET_CONTROLLER
>>       select DMA_ENGINE
>>       select DMA_VIRTUAL_CHANNELS
>>       help
>> -       Support for the DMA engine for Allwinner A31 SoCs.
>> +       Support for the DMA engine first found in Allwinner A31 SoCs.
>>
>>  config NBPFAXI_DMA
>>       tristate "Renesas Type-AXI NBPF DMA support"
>> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
>> index 89ca0c4..29667dd 100644
>> --- a/drivers/dma/sun6i-dma.c
>> +++ b/drivers/dma/sun6i-dma.c
>> @@ -878,8 +878,20 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
>>       .nr_max_vchans   = 53,
>>  };
>>
>> +/*
>> + * The A23 only has 8 physical channels, a maximum DRQ port id of 24,
>> + * and a total of 37 usable source and destination endpoints.
>> + */
>> +
>> +static struct sun6i_dma_config sun8i_a23_dma_cfg = {
>> +     .nr_max_channels = 8,
>> +     .nr_max_requests = 24,
>> +     .nr_max_vchans   = 37,
>> +};
>> +
>>  static struct of_device_id sun6i_dma_match[] = {
>>       { .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
>> +     { .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
>>       { /* sentinel */ }
>>  };
>>
>> @@ -1008,6 +1020,14 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>>               goto err_dma_unregister;
>>       }
>>
>> +     /*
>> +      * sun8i variant requires us to toggle an undocumented register,
>> +      * as seen in Allwinner's SDK.
>
> The BSP I have has this:
>
> static void sunxi_dma_hw_init(struct sunxi_dmadev *dev)
> {
>         struct sunxi_dmadev *sunxi_dev = dev;
>
>         clk_prepare_enable(sunxi_dev->ahb_clk);
> #ifdef CONFIG_ARCH_SUN8IW3
>         writel(0x04, sunxi_dev->base + DMA_GATE);
> #endif
> }
>
> /* All is ok, and open the clock */
> sunxi_dma_hw_init(sunxi_dev);
>
> So I guess we can say that it's not that undocumented :)

That's right. I meant undocumented in the user manual.
I did reference the SDK in the comment, didn't I? :)

ChenYu
