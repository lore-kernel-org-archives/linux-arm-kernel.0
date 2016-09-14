From: John.Youn@synopsys.com (John Youn)
Date: Wed, 14 Sep 2016 11:12:20 -0700
Subject: [PATCH v2 1/6] usb: dwc2: add support for Meson8b and GXBB SoCs
In-Reply-To: <m24m5ixxyu.fsf@baylibre.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-2-martin.blumenstingl@googlemail.com>
 <m24m5ixxyu.fsf@baylibre.com>
Message-ID: <0d587b46-4c6e-c2ec-a62e-5d0c5a5bd902@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/14/2016 9:11 AM, Kevin Hilman wrote:
> Hi John,
> 
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> 
>> From: Jerome Brunet <jbrunet@baylibre.com>
>>
>> Add compatible strings for amlogic Meson8b and GXBB SoCs with the
>> corresponding configuration parameters.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Are you OK with adding this platform for v4.9?  I know you mentioned
> you're working on new bindings to replace the current way, but since
> that hasn't been posted AFAICT, it would be nice to get this merged now
> and we can help test the new bindings when you're ready.
> 
> If you're OK with that, and with your Ack, I can take merge the driver
> changes through the arm-soc tree along with the rest of the DT patches.
> 

Sure. Unfortunately, I wasn't able to complete it for 4.9.

You can add my acked-by on this:

Acked-by: John Youn <johnyoun@synopsys.com>

Regards,
John



> Kevin
> 
>> ---
>>  Documentation/devicetree/bindings/usb/dwc2.txt |  2 ++
>>  drivers/usb/dwc2/platform.c                    | 34 ++++++++++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
>> index 20a68bf..2c30a54 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
>> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
>> @@ -10,6 +10,8 @@ Required properties:
>>    - "rockchip,rk3288-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3288 Soc;
>>    - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
>>    - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;
>> +  - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
>> +  - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
>>    - snps,dwc2: A generic DWC2 USB controller with default parameters.
>>  - reg : Should contain 1 register range (address and length)
>>  - interrupts : Should contain 1 interrupt
>> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
>> index fc6f525..8f7b34c 100644
>> --- a/drivers/usb/dwc2/platform.c
>> +++ b/drivers/usb/dwc2/platform.c
>> @@ -181,6 +181,38 @@ static const struct dwc2_core_params params_ltq = {
>>  	.hibernation			= -1,
>>  };
>>  
>> +static const struct dwc2_core_params params_amlogic = {
>> +	.otg_cap			= DWC2_CAP_PARAM_NO_HNP_SRP_CAPABLE,
>> +	.otg_ver			= -1,
>> +	.dma_enable			= 1,
>> +	.dma_desc_enable		= 0,
>> +	.dma_desc_fs_enable		= 0,
>> +	.speed				= DWC2_SPEED_PARAM_HIGH,
>> +	.enable_dynamic_fifo		= 1,
>> +	.en_multiple_tx_fifo		= -1,
>> +	.host_rx_fifo_size		= 512,
>> +	.host_nperio_tx_fifo_size	= 500,
>> +	.host_perio_tx_fifo_size	= 500,
>> +	.max_transfer_size		= -1,
>> +	.max_packet_count		= -1,
>> +	.host_channels			= 16,
>> +	.phy_type			= DWC2_PHY_TYPE_PARAM_UTMI,
>> +	.phy_utmi_width			= -1,
>> +	.phy_ulpi_ddr			= -1,
>> +	.phy_ulpi_ext_vbus		= -1,
>> +	.i2c_enable			= -1,
>> +	.ulpi_fs_ls			= -1,
>> +	.host_support_fs_ls_low_power	= -1,
>> +	.host_ls_low_power_phy_clk	= -1,
>> +	.ts_dline			= -1,
>> +	.reload_ctl			= 1,
>> +	.ahbcfg				= GAHBCFG_HBSTLEN_INCR8 <<
>> +					  GAHBCFG_HBSTLEN_SHIFT,
>> +	.uframe_sched			= 0,
>> +	.external_id_pin_ctl		= -1,
>> +	.hibernation			= -1,
>> +};
>> +
>>  /*
>>   * Check the dr_mode against the module configuration and hardware
>>   * capabilities.
>> @@ -464,6 +496,8 @@ static const struct of_device_id dwc2_of_match_table[] = {
>>  	{ .compatible = "lantiq,xrx200-usb", .data = &params_ltq },
>>  	{ .compatible = "snps,dwc2", .data = NULL },
>>  	{ .compatible = "samsung,s3c6400-hsotg", .data = NULL},
>> +	{ .compatible = "amlogic,meson8b-usb", .data = &params_amlogic },
>> +	{ .compatible = "amlogic,meson-gxbb-usb", .data = &params_amlogic },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
> 
