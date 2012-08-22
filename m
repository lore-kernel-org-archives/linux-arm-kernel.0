From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Aug 2012 13:52:45 -0600
Subject: Can one  set GPIO direction in pinmux definition?
In-Reply-To: <5034FCB2.5040709@grid-net.com>
References: <5034FCB2.5040709@grid-net.com>
Message-ID: <5035388D.2060909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2012 09:37 AM, Subodh Nijsure wrote:
> 
> For a MX28 based hardware I am working with I need to use AUART4
> 
> I need to configure this AUART4 as uart only when necessary and at all
> other times pins associated with AUART4 need to be configured as inputs.

Out of curiosity, why?

BTW, you didn't CC any of the IMX maintainers, so it's likely they won't
see your question. I've CC'd LinusW, Shawn, and Dong.

> I am using following DT definitions to setup AUART4 mux  but can't
> figure out how to setup pin direction via DT, can it be done or I need
> to do it in C code?
> 
>         apb at 80000000 {
>                 apbh at 80000000 {
>                                 auart4_pins_a: auart4 at 0 {
>                                         reg = <0>;
>                                         fsl,pinmux-ids = <
>                                                 0x3142 /*
> MX28_PAD_SAIF0_MCLK__AUART4_CTS */
>                                                 0x3152 /*
> MX28_PAD_SAIF0_LRCLK__AUART4_RTS */
>                                                 0x3162 /*
> MX28_PAD_SAIF0_BITCLK__AUART4_RX */
>                                                 0x3172 /*
> MX28_PAD_SAIF0_SDATA0__AUART4_TX */
>                                         >;
>                                         fsl,drive-strength = <0>;
>                                         fsl,voltage = <1>;
>                                         fsl,pull-up = <0>;
>                                 };
>                                 auart4_highz_pins: auart4-gpio at 0 {
>                                         reg = <0>;
>                                         fsl,pinmux-ids = <
>                                                 0x3143 /*
> MX28_PAD_SAIF0_MCLK__GPIO_3_20 */
>                                                 0x3153 /*
> MX28_PAD_SAIF0_LRCLK__GPIO_3_21 */
>                                                 0x3163 /*
> MX28_PAD_SAIF0_BITCLK__GPIO_3_22 */
>                                                 0x3173 /*
> MX28_PAD_SAIF0_SDATA0__GPIO_3_23 */
>                                         >;
>                                         fsl,drive-strength = <0>;
>                                         fsl,voltage = <1>;
>                                         fsl,pull-up = <0>;
>                                 };
>                  };
>           };

I don't know IMX HW, but where is highz controlled? On other SoCs I'm
familiar with, when a pad is configured as a GPIO, the highz state is
controlled by the GPIO module, so there's nothing pinmux can do about
it. Even if the pinmux HW does control highz, gpio_direction_*() are
still meant to communicate with the pinctrl driver to implement this, so
overriding it through the pinctrl configuration seems like a bad thing.

So I think your UART driver would have to request the GPIOs, and set
them as inputs. So, I guess your UART node below would need a property
listing the GPIOs to do this to.

>                 apbx at 80040000 {
>                         auart4: serial at 80072000 {
>                                 pinctrl-names = "default", "auart";
>                                 pinctrl-0 = <&auart4_highz_pins>;
>                                 pinctrl-1 = <&auart4_pins_a>;
>                                 status = "okay";
>                         };
>                };
