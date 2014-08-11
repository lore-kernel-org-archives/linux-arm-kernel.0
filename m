From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 11 Aug 2014 19:24:12 +0900
Subject: [PATCH v5 05/10] ARM: dts: Move dp_hpd from exynos5250 into
 smdk5250 and snow
In-Reply-To: <53E73827.7000703@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-6-git-send-email-afaerber@suse.de>
 <CAD=FV=WhocoyQ=rU7dU1EPM-PAQq06gg9HhamSOm+BgMDeM8NA@mail.gmail.com>
 <53DBFE8A.7020505@suse.de> <53DBFF22.3010905@gmail.com>
 <000e01cfb0a7$25d0ed70$7172c850$%han@samsung.com> <53E73827.7000703@suse.de>
Message-ID: <003601cfb54e$655130d0$2ff39270$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, August 10, 2014 6:15 PM, Andreas Farber wrote:
> Am 05.08.2014 13:16, schrieb Jingoo Han:
> > On Saturday, August 02, 2014 5:57 AM, Tomasz Figa wrote:
> >> On 01.08.2014 22:54, Andreas F?rber wrote:
> >>> Am 01.08.2014 22:33, schrieb Doug Anderson:
> >>>> On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber <afaerber@suse.de> wrote:
> >>>>> Spring uses a different GPIO, so this is not a generic SoC piece.
> >>>>>
> >>>>> Suggested-by: Tomasz Figa <t.figa@samsung.com>
> >>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> >>>>> ---
> >>>>>  v5: New (Tomasz Figa)
> >>>>>  Frees dp_hpd for Spring.
> >>>>>
> >>>>>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi | 7 -------
> >>>>>  arch/arm/boot/dts/exynos5250-smdk5250.dts | 9 +++++++++
> >>>>>  arch/arm/boot/dts/exynos5250-snow.dts     | 7 +++++++
> >>>>>  3 files changed, 16 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-
> pinctrl.dtsi
> >>>>> index 886cfca044ac..ed0e5230514b 100644
> >>>>> --- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> >>>>> +++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> >>>>> @@ -581,13 +581,6 @@
> >>>>>                         samsung,pin-pud = <0>;
> >>>>>                         samsung,pin-drv = <0>;
> >>>>>                 };
> >>>>> -
> >>>>> -               dp_hpd: dp_hpd {
> >>>>> -                       samsung,pins = "gpx0-7";
> >>>>> -                       samsung,pin-function = <3>;
> >>>>> -                       samsung,pin-pud = <0>;
> >>>>> -                       samsung,pin-drv = <0>;
> >>>>> -               };
> >>>>>         };
> >>>>>
> >>>>>         pinctrl at 13400000 {
> >>>>> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-
> smdk5250.dts
> >>>>> index aaa055ac0fe3..5d30fe1dcda4 100644
> >>>>> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> >>>>> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> >>>>> @@ -414,3 +414,12 @@
> >>>>>                 };
> >>>>>         };
> >>>>>  };
> >>>>> +
> >>>>> +&pinctrl_0 {
> >>>>> +       dp_hpd: dp_hpd {
> >>>>> +               samsung,pins = "gpx0-7";
> >>>>> +               samsung,pin-function = <3>;
> >>>>> +               samsung,pin-pud = <0>;
> >>>>> +               samsung,pin-drv = <0>;
> >>>>> +       };
> >>>>> +};
> >>>>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> >>>>> index c4b0c73c736d..a9a2f2743794 100644
> >>>>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> >>>>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> >>>>> @@ -547,6 +547,13 @@
> >>>>>  };
> >>>>>
> >>>>>  &pinctrl_0 {
> >>>>> +       dp_hpd: dp_hpd {
> >>>>> +               samsung,pins = "gpx0-7";
> >>>>> +               samsung,pin-function = <3>;
> >>>>> +               samsung,pin-pud = <0>;
> >>>>> +               samsung,pin-drv = <0>;
> >>>>> +       };
> >>>>> +
> >>>>
> >>>> NAK.  dp_hpd is a generic SoC piece.  Pin function 0 and 1 are GPIOs.
> >>>> Pin function 3 is special function.  This pin _is_ the hot plug detect
> >>>> pin for display port.  When it's set as special function 3 it goes
> >>>> straight into the hot plug logic of the display port controller.
> >>>>
> >>>> Spring may have had its reasons to detect hot plug events on a GPIO
> >>>> instead of using this pin, but that doesn't make this pin any less the
> >>>> "hot plug pin".
> >>>
> >>> Please advise how to handle it then: Should there be two different
> >>> pinctrl entries (if so, how should it be named?),
> >>
> >> IMHO this is the right way. Just name the GPIO variant dp_hpd_gpio.
> >
> > Hi Andreas F?rber,
> >
> > I agree with Tomasz Figa and Doug Anderson.
> > Please refer to the following.
> >
> > 1. case: Standard HPD pin is used. (smdk5420)
> > arch/arm/boot/dts/exynos5420-pinctrl.dts
> > 	pinctrl at 13400000 {
> > 		dp_hpd: dp_hpd {
> > 			samsung,pins = "gpx0-7";
> > 			samsung,pin-function = <3>;
> > 			samsung,pin-pud = <0>;
> > 			samsung,pin-drv = <0>;
> > 		};
> > arch/arm/boot/dts/exynos5420-smdk5420.dts
> > 	dp-controller at 145B0000 {
> > 		pinctrl-names = "default";
> > 		pinctrl-0 = <&dp_hpd>;
> > 		...
> >
> > 2. case: non-standard HPD pin such as GPIO is used. (peach pit)
> > arch/arm/boot/dts/exynos5420-peach-pit.dts
> > 	pinctrl at 13400000 {
> > 		dp_hpd_gpio: dp_hpd_gpio {
> > 			samsung,pins = "gpx2-6";
> > 			samsung,pin-function = <0>;
> > 			samsung,pin-pud = <3>;
> > 			samsung,pin-drv = <0>;
> > 		};
> > 	dp-controller at 145B0000 {
> > 		pinctrl-names = "default";
> > 		pinctrl-0 = <&dp_hpd_gpio>;
> > 		...
> > 		samsung,hpd-gpio = <&gpx2 6 0>;
> >
> > So, you need to follow the second case.
> > "dp_hpd_gpio" can be used for Spring board.
> 
> I believe I already did so in v6 [0]? Please take a look there and let
> me know if you still need anything changed. The label name seems
> identical, whereas for the node name I adopted the dashes convention.

OK, I checked v6 patches.
I have no objection. It looks good.
Thank you.

Best regards,
Jingoo Han

> 
> Thanks,
> Andreas
> 
> [0] https://patchwork.kernel.org/patch/4664691/
> 
> --
> SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
