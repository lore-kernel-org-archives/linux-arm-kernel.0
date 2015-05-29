From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 29 May 2015 07:01:00 -0700
Subject: [PATCH 2/2] ARM: dts: ventana: Add ext-reset support
In-Reply-To: <20150529061757.GA10793@pengutronix.de>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
 <1432853677-5150-3-git-send-email-tharvey@gateworks.com>
 <20150529061757.GA10793@pengutronix.de>
Message-ID: <CAJ+vNU04rOR6z7nvnSGTWFbARC_Kk3SAaZNoXHsw7tF052TdEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 11:17 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> Hi,
>
> On Thu, May 28, 2015 at 03:54:37PM -0700, Tim Harvey wrote:
>> The Gateworks Ventana boards have a PMIC that can be used to regulate the
>> CPU voltage rails for DVFS support. In order to ensure this PMIC is properly
>> reset the watchdog needs to be configured to assert its external reset
>> signal.
>>
>> Additionally the pad used for WDOG_B needs to be configured which we add to
>> a hog group for lack of a better location.
>
> Why don't you add this as pinctrl of the watchdog device node? It won't
> have any influence anyway until the watchdog driver was setup.
>
> Regards,
>
> Markus
>

Markus,

That makes great sense:

&wdog1 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_wdog>;
        ext-reset;
};

&iomuxc {
        imx6qdl-gw51xx {
                pinctrl_wdog: wdoggrp {
                        fsl,pins = <
                                MX6QDL_PAD_DISP0_DAT8__WDOG1_B          0x1b0b0
                        >;
                };
....

instead of


&wdog1 {
        ext-reset;
};

&iomuxc {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_hog>;

        imx6qdl-gw51xx {
                pinctrl_hog: hoggrp {
                        fsl,pins = <
                                MX6QDL_PAD_DISP0_DAT8__WDOG1_B          0x1b0b0
                        >;
                };
....


I'll do that in a future revision after feedback.

Thanks,

Tim
