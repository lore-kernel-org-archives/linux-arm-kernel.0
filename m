From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 27 Jun 2013 15:45:54 +0400
Subject: [PATCH v5 2/3] ARM: shmobile: BOCK-W: add VIN and ML86V7667
 support
In-Reply-To: <8761x02khf.wl%kuninori.morimoto.gx@renesas.com>
References: <201306220326.46176.sergei.shtylyov@cogentembedded.com>
 <201306220330.13845.sergei.shtylyov@cogentembedded.com>
 <8761x02khf.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <51CC25F2.9020605@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-06-2013 9:25, Kuninori Morimoto wrote:

>> @@ -166,6 +187,16 @@ static const struct pinctrl_map bockw_pi
>>   				  "usb0", "usb0"),
>>   	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform", "pfc-r8a7778",
>>   				  "usb1", "usb1"),
>> +	/* VIN0 */
>> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7778-vin.0", "pfc-r8a7778",
>> +				  "vin0_clk", "vin0"),
>> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7778-vin.0", "pfc-r8a7778",
>> +				  "vin0_data8", "vin0"),
>> +	/* VIN1 */
>> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7778-vin.1", "pfc-r8a7778",
>> +				  "vin1_clk", "vin1"),
>> +	PIN_MAP_MUX_GROUP_DEFAULT("r8a7778-vin.1", "pfc-r8a7778",
>> +				  "vin1_data8", "vin1"),
>>   };

> Here, it includes VIN1 pin, but

>>   #define FPGA	0x18200000
>> @@ -184,6 +215,16 @@ static void __init bockw_init(void)
>>   	r8a7778_add_hspi_device(0);
>>   	r8a7778_add_mmc_device(&sh_mmcif_plat);
>>   	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
>> +	r8a7778_add_vin_device(0, &vin_platform_data);
>> +	/* VIN1 has a pin conflict with Ether */
>> +	if (!IS_ENABLED(CONFIG_SH_ETH))
>> +		r8a7778_add_vin_device(1, &vin_platform_data);

> what happen if SH_ETH was enabled here ?
> r8a7778_add_vin_device(1, xxx) is not called,
> but bockw_pinctrl_map was called with VIN1 setting ?

    Don't worry, it's all tested. If the VIN1 platform device is not 
registered, VIN1 pinmux settings won't be selected by the driver core.

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei
