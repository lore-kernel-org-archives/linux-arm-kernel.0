From: michal.vokac@ysoft.com (=?UTF-8?B?TWljaGFsIFZva8OhxI0=?=)
Date: Wed, 18 Jul 2018 15:01:02 +0200
Subject: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
In-Reply-To: <1f80b97c-a0ca-8fea-4454-b7bf78dffae9@ysoft.com>
References: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
 <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
 <AM0PR04MB42111E25172F6068F937ECCB804B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM4PR0401MB2260FB90A3B243A60D027F46FF4A0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
 <1f80b97c-a0ca-8fea-4454-b7bf78dffae9@ysoft.com>
Message-ID: <e91b9d5c-b08c-3927-0f70-b6db9bada5ab@ysoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.6.2018 15:58, Michal Vok?? wrote:
> On 25.6.2018 04:50, Andy Duan wrote:
>>>> On 11.6.2018 14:36, Michal Vok?? wrote:
>>>>> Ahoj,
>>>>>
>>>>> To configure individual pad's characteristics on i.MX6 SoC a
>>>>> fsl,pins = <PIN_FUNC_ID CONFIG> property can be used. Is there any
>>>>> convenient way to configure the pad group control registers?
>>>>>
>>>>> The issue is that some bits (DDR_SEL and ODT) in the individual
>>>>> RGMII pad control registers are read-only. To tweak those parameters
>>>>> (signal voltage and termination resistors) one need to write to the
>>>>> pad group control registers for the whole RGMII pad group. Namely
>>>>> IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII and
>>>>> IOMUXC_SW_PAD_CTL_GRP_RGMII_TERM. The group registers in general
>>>>> are not accessible from the list in arch/arm/boot/dts/imx6dl-pinfunc.h.
>>>>>
>>>>> I could not find any other way to change the group registers than
>>>>> hacking-in some lines into the imx6q_init_machine(void) function in
>>>>> arch/arm/mach-imx/mach-imx6q.c source. As I work towards upstreaming
>>>>> my board this should be done from my device tree or solved in some
>>>>> universal way.
>>>>>
>>>>> Any hints will be much appreciated.
>>>>> Michal
>>>>
>>>> I figured out this is more "pinctrl-imx.c" than "device-tree" related
>>>> so I am kindly adding maintainers of that file in hope somebody will
>>>> shed some light to it.
>>>>
>>>> I am diving deeper into the code and it seems there really is no
>>>> generic option to set the i.MX6 pad group control registers from device
>>>> tree. Or am I looking at the problem from a wrong angle?
>>>
>>> Yes, there's a few special pad group ctrl registers (e.g. DRAM and RGMII
>>> for mx6q) which are not added In the pinctrl driver support.
> 
> Hi Andy and Dong! Thank you very much for your comments.
> 
> I still have quite limited knowledge about the pinctrl driver and related
> things but AFAIK it is not like that few pad group ctrl registers are not
> supported. I do not see any support for group control registers at all.
> And not only for the imx6q but for all the SoC variants and other SoCs as
> well. Am I right?
> 
>>>> How should we deal with boards that need to configure some pad
>>>> characteristics available only through the pad group control registers?
>>>
>>> Andy,
>>> How do we handle it internally?
>> No, we don't handle the pin.
>> I remembered IC owner said It seems only RGMII 2.5v need to handle the pin.
> 
> That is our case. I need to use 2.5V signaling at the RGMII for
> the connected QCA8334 switch. And also to set the terminators accordingly.
> 
>>> There're probably two ways to do it:
>>> 1) handle it in fec driver by parsing a specific property
>>> 2) Add a new pad group into pinctrl driver support e.g.
>>> MX6Q_PAD_CTL_GRP_RGMII_TERM
>>> MX6Q_PAD_CTL_GRP_DDR_TYPE_RGMII
>>>
>>> I may prefer to 2).
> 
> No.1 is similar to what I am doing now. I have a DT node with custom
> compatible string and a reg property. Then I look for that compatible from
> imx6q_enet_init() using syscon_regmap_lookup_by_compatible("fsl,imx6-rgmii-ddrtype-gpr");
> I do not see a chance that something like this could be accepted upstream.
> 
> No.2 is much more complex. IMHO it is not about adding support for a new
> pad group. It is about adding support for pad group control registers from
> scratch.
> 
> I do not mind working on a proper solution. Though as I mentioned I am
> still not very experienced in kernel internals/APIs so I will appreciate
> some guidance along the way. It should not be as complex as
> handling pin muxing and all the related things though.
> 
> What I see as a potential problem is conflict of the usage of the "pin group"
> term. Now "pin group" is used in pinctrl core and refers to a DT node.
> That node associates any pins that are needed for a given functionality.
> Those pins can actually be wired to totally different IP blocks of the SoC.
> 
> Whereas the pad group control register typically associates and controls
> pins that are common to one IP block.
> 
> So the question is how complex such implementation should be?
> How should the binding look like?
> What is the proper place to parse the DT and write the registers?
> What SoCs should be supported?
> 
> Se bellow my very preliminary proposal how this may look like.
> It is meant more like a background for further discussion.
> I am really not sure if this should be strictly solved at the imx-pinctrl
> level or if this overlaps into the pinctrl core.
> 
> Thanks a lot for any additional comments,
> Michal
>

Ping. Any feedback would be very much welcomed!
Michal
  
> diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx6dl-pinfunc.h
> index 37e430a..eeac9e3 100644
> --- a/arch/arm/boot/dts/imx6dl-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
> @@ -1089,4 +1089,24 @@
>   #define MX6QDL_PAD_SD4_DAT7__UART2_RX_DATA          0x35c 0x744 0x904 0x2 0x7
>   #define MX6QDL_PAD_SD4_DAT7__GPIO2_IO15             0x35c 0x744 0x000 0x5 0x0
> 
> +/* Pad group control registers */
> +#define MX6QDL_PAD_CTL_GRP_B7DS           0x748
> +#define MX6QDL_PAD_CTL_GRP_ADDDS          0x74c
> +#define MX6QDL_PAD_CTL_GRP_DDRMODE_CTL    0x750
> +#define MX6QDL_PAD_CTL_GRP_DDRPKE         0x754
> +#define MX6QDL_PAD_CTL_GRP_DDRPK          0x758
> +#define MX6QDL_PAD_CTL_GRP_DDRHYS         0x75c
> +#define MX6QDL_PAD_CTL_GRP_DDRMODE        0x760
> +#define MX6QDL_PAD_CTL_GRP_B0DS           0x764
> +#define MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII 0x768
> +#define MX6QDL_PAD_CTL_GRP_CTLDS          0x76c
> +#define MX6QDL_PAD_CTL_GRP_B1DS           0x770
> +#define MX6QDL_PAD_CTL_GRP_DDR_TYPE       0x774
> +#define MX6QDL_PAD_CTL_GRP_B2DS           0x778
> +#define MX6QDL_PAD_CTL_GRP_B3DS           0x77c
> +#define MX6QDL_PAD_CTL_GRP_B4DS           0x780
> +#define MX6QDL_PAD_CTL_GRP_B5DS           0x784
> +#define MX6QDL_PAD_CTL_GRP_RGMII_TERM     0x788
> +#define MX6QDL_PAD_CTL_GRP_B6DS           0x78c
> +
>   #endif /* __DTS_IMX6DL_PINFUNC_H */
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 15744ad..3e9d1ba 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -467,6 +467,11 @@
>                   MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL    0x1b030
>                   MX6QDL_PAD_GPIO_16__ENET_REF_CLK    0x4001b0a8
>               >;
> +
> +            fsl,pin-groups = <
> +                MX6QDL_PAD_CTL_GRP_RGMII_TERM           0xC0000
> +                MX6QDL_PAD_CTL_GRP_DDR_TYPE_RGMII       0x100
> +            >;
>           };
> 
>           pinctrl_gpio_keys: gpio_keysgrp {
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 1c6bb15..3c42917 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -235,6 +235,8 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
>           }
>       }
> 
> +    /* TODO write the pad group control registers here? */
> +
>       return 0;
>   }
> 
> @@ -421,6 +423,7 @@ static const struct pinconf_ops imx_pinconf_ops = {
>    *     <mux_conf_reg input_reg mux_mode input_val>
>    */
>   #define FSL_PIN_SIZE 24
> +#define FSL_PIN_GRP_SIZE 8
>   #define FSL_PIN_SHARE_SIZE 20
> 
>   static int imx_pinctrl_parse_groups(struct device_node *np,
> @@ -430,6 +433,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>   {
>       const struct imx_pinctrl_soc_info *info = ipctl->info;
>       int size, pin_size;
> +    int pin_grp_size = FSL_PIN_GRP_SIZE;
>       const __be32 *list;
>       int i;
>       u32 config;
> @@ -531,6 +539,22 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>                   pin->mux_mode, pin->config);
>       }
> 
> +    /* parse the pad control group register configuration */
> +    list = of_get_property(np, "fsl,pin-groups", &size);
> +
> +    /* this binding is optional so stop here if it is not used */
> +    if (!list)
> +        goto out;
> +
> +    /* we do not check return since it's safe node passed down */
> +    if (!size || size % pin_grp_size) {
> +        dev_err(ipctl->dev, "Invalid fsl,pin-groups property in node %pOF\n", np);
> +        return -EINVAL;
> +    }
> +
> +    /* TODO Parse the pad group register IDs and its configuration values */
> +
> +out:
>       return 0;
>   }
> -- 
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
