From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 23 Nov 2016 16:02:02 +0800
Subject: [PATCH 3/6] reset: hisilicon: add reset-hi3660
In-Reply-To: <1479810156.13701.1.camel@pengutronix.de>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <2220300.Yj4lYzeH2z@wuerfel>
 <d6e602c0-70e9-0309-86b5-bfd006d86028@linaro.org>
 <3166877.sQekoU5ezv@wuerfel> <1479810156.13701.1.camel@pengutronix.de>
Message-ID: <26a54e14-236e-78e2-020b-4a51342e2694@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Philipp


On 2016?11?22? 18:22, Philipp Zabel wrote:
> Am Dienstag, den 22.11.2016, 10:42 +0100 schrieb Arnd Bergmann:
>> On Tuesday, November 22, 2016 5:34:05 PM CET zhangfei wrote:
>>> On 2016?11?22? 16:50, Arnd Bergmann wrote:
>>>> On Tuesday, November 22, 2016 3:49:18 PM CET Zhangfei Gao wrote:
>>>>> +static const struct hisi_reset_channel_data hi3660_iomcu_rst[] = {
>>>>> +       [HI3660_RST_I2C0] = HISI_RST_SEP(0x20, 3),
>>>>> +       [HI3660_RST_I2C1] = HISI_RST_SEP(0x20, 4),
>>>>> +       [HI3660_RST_I2C2] = HISI_RST_SEP(0x20, 5),
>>>>> +       [HI3660_RST_I2C6] = HISI_RST_SEP(0x20, 27),
>>>>> +};
>>>>> +
>>>>> +static struct hisi_reset_controller_data hi3660_iomcu_controller = {
>>>>> +       .nr_channels = ARRAY_SIZE(hi3660_iomcu_rst),
>>>>> +       .channels = hi3660_iomcu_rst,
>>>>> +};
>>>>> +
>>>>> +static const struct hisi_reset_channel_data hi3660_crgctrl_rst[] = {
>>>>> +       [HI3660_RST_I2C3] = HISI_RST_SEP(0x78, 7),
>>>>> +       [HI3660_RST_I2C4] = HISI_RST_SEP(0x78, 27),
>>>>> +       [HI3660_RST_I2C7] = HISI_RST_SEP(0x60, 14),
>>>>> +       [HI3660_RST_SD] = HISI_RST_SEP(0x90, 18),
>>>>> +       [HI3660_RST_SDIO] = HISI_RST_SEP(0x90, 20),
>>>>> +       [HI3660_RST_UFS] = HISI_RST_SEP(0x84, 12),
>>>>> +       [HI3660_RST_UFS_ASSERT] = HISI_RST_SEP(0x84, 7),
>>>>> +       [HI3660_RST_PCIE_SYS] = HISI_RST_SEP(0x84, 26),
>>>>> +       [HI3660_RST_PCIE_PHY] = HISI_RST_SEP(0x84, 27),
>>>>> +       [HI3660_RST_PCIE_BUS] = HISI_RST_SEP(0x84, 31),
>>>>> +       [HI3660_RST_USB3OTG_PHY] = HISI_RST_SEP(0x90, 3),
>>>>> +       [HI3660_RST_USB3OTG] = HISI_RST_SEP(0x90, 5),
>>>>> +       [HI3660_RST_USB3OTG_32K] = HISI_RST_SEP(0x90, 6),
>>>>> +       [HI3660_RST_USB3OTG_AHB] = HISI_RST_SEP(0x90, 7),
>>>>> +       [HI3660_RST_USB3OTG_MUX] = HISI_RST_SEP(0x90, 8),
>>>>> +};
>>>> I think you can avoid the trap of the ABI incompatibility if
>>>> you just define those as in the binding as tuples, using #reset-cells=2.
>>>>
>>>> In particular for the first set, it seems really silly to redefine
>>>> the numbers when there is just a simple integer number.
>>> Could you clarify more, still not understand.
>>> The number is index of the arrays, and the index will be used in dts.
>>> The arrays lists the registers offset and bit shift.
>>> For example:
>>>
>>> [HI3660_RST_I2C0] = HISI_RST_SEP(0x20, 3), means register offset : 0x20, and bit shift = 3.
>>>
>>> And Documentation/devicetree/bindings/reset/reset.txt
>>> Required properties:
>>> #reset-cells:   Number of cells in a reset specifier; Typically 0 for nodes
>>>                   with a single reset output and 1 for nodes with multiple
>>>                   reset outputs.
> This is just a suggestion, for reset controllers where the reset lines
> can reasonably be enumerated by a single integer. If there is a good
> reason to use more complicated bindings, more cells can be used.
> That being said, I dislike having to spread register/bit information
> throughout the device trees at the consumer/phandle sites, if the
> register/bit information absolutely has to be put into the device tree,
> I'd prefer a binding similar to ti-syscon, where it's all in one place.
Thanks for the suggestion.
Will use table in dts instead of 
include/dt-bindings/reset/hisi,hi3660-resets.h
like
+               hisi,reset-bits = <0x20 0x8             /* 0: i2c0 */
+                                  0x20 0x10            /* 1: i2c1 */
+                                  0x20 0x20            /* 2: i2c2 */
+                                  0x20 0x8000000>;     /* 3: i2c6 */

To remove the potential ABI issue as pointed by Arnd.
>
>> You can easily enumerate the registers that contain reset bits here,
>> so just use one cell for the register and another one for the index.
> Changing the reset cells is an incompatible change, and this is not a
> straight forward register/bit mapping in hardware either. There are
> currently three registers involved: enable (+0x0), disable (+0x4), and
> status (+0x8). Also, what if in the future one of these reset bits have
> to be handled inverted (as just happened for hi3519)?
Discussed with Jianchen, we are only considering Kirin series now.
The inverted in hi3519 is only for some line, not the whole controller.
It is more like a bug and kirin does not have such issue.

Will send a new RFC, help take a look.

Thanks
