From: stefan@agner.ch (Stefan Agner)
Date: Sat, 06 Jan 2018 13:16:00 +0100
Subject: [PATCH] pinctrl: imx6ul: add IOMUXC SNVS pinctrl driver for i.MX
 6ULL
In-Reply-To: <b6d157d12f87caa1ad2ab7c500aa17b2@agner.ch>
References: <20180102164059.14641-1-stefan@agner.ch>
 <CACRpkdYKiLeRZdBCWie+UGK=96FicXXmWvGUvwNFD2ZWOUx7Rw@mail.gmail.com>
 <b6d157d12f87caa1ad2ab7c500aa17b2@agner.ch>
Message-ID: <cae649c64dbc45944979eff1594b6c8c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-06 12:14, Stefan Agner wrote:
> On 2018-01-03 09:09, Linus Walleij wrote:
>> On Tue, Jan 2, 2018 at 5:40 PM, Stefan Agner <stefan@agner.ch> wrote:
>>
>>> From: Bai Ping <ping.bai@nxp.com>
>>>
>>> On i.MX 6ULL, the BOOT_MODEx and TAMPERx pin MUX and CTRL registers
>>> are available in a separate IOMUXC_SNVS module. Add support for the
>>> IOMUXC_SNVS module to the i.MX 6UL pinctrl driver.
>>>
>>> Signed-off-by: Bai Ping <ping.bai@nxp.com>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>
>> So 6 unsigned long 32 bit is succeeded by 6 unsigned long long, 64 bit?
>>
>> Someone is having fun naming these platforms I see.
> 
> Hehe, yeah definitely. At least they use proper type suffixes ;-)
> 
>>
>>>  Required properties:
>>> -- compatible: "fsl,imx6ul-iomuxc"
>>> +- compatible: "fsl,imx6ul-iomuxc" for main IOMUX controller or
>>> +  "fsl,imx6ull-iomuxc-snvs" for i.MX 6ULL's SNVS IOMUX controller.
>>
>> Pretty uncontroversial change but still nice to give the DT people a chance
>> to ACK it.
>>
>>>  static int imx6ul_pinctrl_probe(struct platform_device *pdev)
>>>  {
>>> -       return imx_pinctrl_probe(pdev, &imx6ul_pinctrl_info);
>>> +       const struct of_device_id *match;
>>> +       struct imx_pinctrl_soc_info *pinctrl_info;
>>> +
>>> +       match = of_match_device(imx6ul_pinctrl_of_match, &pdev->dev);
>>> +
>>> +       if (!match)
>>> +               return -ENODEV;
>>> +
>>> +       pinctrl_info = (struct imx_pinctrl_soc_info *) match->data;
>>
>> 1. Do not use a cast on void * pointers.
>>
>> 2. Use this function:
>> extern const void *of_device_get_match_data(const struct device *dev);

Just realized that imx_pinctrl_probe needs a non-const struct
imx_pinctrl_soc_info *...

Afaik, while casting to non-const struct pointers in imxXX_pinctrl_probe
is not nice but should be technically ok since it is a non-const
declaration. However, in pinmux-imx7d.c the struct imx_pinctrl_soc_info
declarations have even been constified with b3060044e495 ("pinctrl:
freescale: imx7d: make of_device_ids const"). That seems not ok!

I wonder how that even works under the light of
CONFIG_STRICT_KERNEL_RWX. In a quick test it seems to boot fine though,
as far as I can tell rodata are set to ro once boot completed...  It
seems at that point the pinmux driver has been initialized completely
and does not write to the struct anymore.

How can we fix this properly? IMHO we should at least unconstify the
struct imx7d_pinctrl_info/imx7d_lpsr_pinctrl_info declarations in
pinctrl-imx7d.c...

--
Stefan

>>
>> From <linux/of_device.h>
> 
> Ok. We use the same code in pinmux-imx7d.c, will send a patch to
> simplify that too.
> 
> --
> Stefan
