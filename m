From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 16:38:45 +0200
Subject: [PATCH v1 3/3] drm/stm: Add STM32 DSI host driver
In-Reply-To: <250fc42c-8961-c57e-6f59-9b1a6523a0a4@st.com>
References: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
 <1494600989-13507-4-git-send-email-philippe.cornu@st.com>
 <a254c176-8064-1984-10b8-dce4308cc3d6@baylibre.com>
 <250fc42c-8961-c57e-6f59-9b1a6523a0a4@st.com>
Message-ID: <32505dd9-78f5-6ed3-4934-014a9c19d220@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

(please avoid top posting)

On 05/15/2017 12:33 PM, Philippe CORNU wrote:
> Hi Neil,
> Many thanks for your comments.
> 
> The PHY part of the MIPI DSI is the main difference between all chipsets 
> based on the Synopsys DesignWare MIPI DSI.
> There is no "generic DSI PHY interface" and that is probably why all soc 
> vendors have implemented their own drivers (RockChip, NXP/Freescale, 
> HiSilicon and now STM32).

Sure, this is the same with the DW-HDMI, there is a Synopsys PHY, but also
vendor PHYs.

> 
> Regarding creating a "generic dw MIPI DSI bridge" as the recent dw hdmi 
> bridge, several attempts have been done in the past but without success:
> * Liu Ying from Freescale in February 2015 
> (https://lkml.org/lkml/2015/2/12/38).
> * Chris Zhong from Rockchip in November 2015 
> (http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1024586.html).

"Impossible n'est pas fran?ais !"
(Georges Courteline, Le 51e Chasseurs, Marpon et Flammario, 1887, p. 23)

I think it's worth the try, and will avoid a lot of code duplication among these
drivers. And since it's a Synopsys IP, it will continue to appear in current
and future SoCs.

> 
> The Rockchip driver looks nice and is updated regularly.
> So, instead of creating a new driver for the STM32 family, we decided to 
> use Rockchip?s in our own drm/stm directory and replace the 
> Rockchip-specific PHY by the STM32.

Sure, it looks OK.

Archit, any advices here ?

> Comments are welcome :-)
> Many thanks,
> Philippe

Thanks,
Neil
> 
> On 05/15/2017 10:22 AM, Neil Armstrong wrote:
>> On 05/12/2017 04:56 PM, Philippe CORNU wrote:
>>> This mipi dsi host driver is based on the Rockchip version of the
>>> Synopsys Designware mipi dsi driver (rockchip/dw-mipi-dsi.c)
>>> modified for the stm32 family:
>>> - replace Rockchip digital & phy specific extensions with stm32's ones.
>>> - add a bridge
>>>
>>> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
>>> ---
>>>  drivers/gpu/drm/stm/Kconfig       |    7 +
>>>  drivers/gpu/drm/stm/Makefile      |    2 +
>>>  drivers/gpu/drm/stm/dw-mipi-dsi.c | 1197 +++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 1206 insertions(+)
>>>  create mode 100644 drivers/gpu/drm/stm/dw-mipi-dsi.c
>>>
>>> diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
>>> index 2c4817f..0007789 100644
>>> --- a/drivers/gpu/drm/stm/Kconfig
>>> +++ b/drivers/gpu/drm/stm/Kconfig
>>> @@ -14,3 +14,10 @@ config DRM_STM
>>>  	  STMicroelectronics STM32 MCUs.
>>>  	  To compile this driver as a module, choose M here: the module
>>>  	  will be called stm-drm.
>>> +
>>> +config DRM_STM_DSI
>>> +	tristate "MIPI DSI support for STMicroelectronics SoC"
>>> +	depends on DRM_STM
>>> +	select DRM_MIPI_DSI
>>> +	help
>>> +	  Choose this option for MIPI DSI support on STMicroelectronics SoC.
>>> diff --git a/drivers/gpu/drm/stm/Makefile b/drivers/gpu/drm/stm/Makefile
>>> index e114d45..e448a93 100644
>>> --- a/drivers/gpu/drm/stm/Makefile
>>> +++ b/drivers/gpu/drm/stm/Makefile
>>> @@ -4,4 +4,6 @@ stm-drm-y := \
>>>  	drv.o \
>>>  	ltdc.o
>>>
>>> +obj-$(CONFIG_DRM_STM_DSI) += dw-mipi-dsi.o
>>> +
>>>  obj-$(CONFIG_DRM_STM) += stm-drm.o
>>> diff --git a/drivers/gpu/drm/stm/dw-mipi-dsi.c b/drivers/gpu/drm/stm/dw-mipi-dsi.c
>>> new file mode 100644
>>> index 0000000..4b7f7b9
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/stm/dw-mipi-dsi.c
>>
>>
>> Hi Philippe,
>>
>> First question, why couldn't this be transformed as a bridge driver along the Synopsys DW-HDMI driver ?
>>
>> Neil
>>
> 
