From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 May 2014 12:13:35 +0200
Subject: [PATCH v7 1/2] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <CAFp+6iF=Z_dkd+YJm2-ODmvgZ6PCt+bUx+vSVm_5RtobVN0WfA@mail.gmail.com>
References: <1398665874-31238-1-git-send-email-gautam.vivek@samsung.com>
 <5368F136.6070804@samsung.com>
 <CAFp+6iHN-W-k6ow5YykK_QWgBJ+GgzXwPX6suWtizxwJWOiGtg@mail.gmail.com>
 <CAFp+6iF=Z_dkd+YJm2-ODmvgZ6PCt+bUx+vSVm_5RtobVN0WfA@mail.gmail.com>
Message-ID: <536CAA4F.8050404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 08/05/14 11:03, Vivek Gautam wrote:
>>>> diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
>>>> >>> index b422e38..51efe4c 100644
>>>> >>> --- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
>>>> >>> +++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
>>>> >>> @@ -114,3 +114,43 @@ Example:
>>>> >>>               compatible = "samsung,exynos-sataphy-i2c";
>>>> >>>               reg = <0x38>;
>>>> >>>       };
>>>> >>> +
>>>> >>> +Samsung Exynos5 SoC series USB DRD PHY controller
>>>> >>> +--------------------------------------------------
>>>> >>> +
>>>> >>> +Required properties:
>>>> >>> +- compatible : Should be set to one of the following supported values:
>>>> >>> +     - "samsung,exynos5250-usbdrd-phy" - for exynos5250 SoC,
>>>> >>> +     - "samsung,exynos5420-usbdrd-phy" - for exynos5420 SoC.
>>>> >>> +- reg : Register offset and length of USB DRD PHY register set;
>>>> >>> +- clocks: Clock IDs array as required by the controller
>>>> >>> +- clock-names: names of clocks correseponding to IDs in the clock property;
>>>> >>> +            Required clocks:
>>>> >>> +     - phy: main PHY clock (same as USB DRD controller i.e. DWC3 IP clock),
>>>> >>> +            used for register access.
>>>> >>> +     - ref: PHY's reference clock (usually crystal clock), used for
>>>> >>> +            PHY operations, associated by phy name. It is used to
>>>> >>> +            determine bit values for clock settings register.
>>>> >>> +            For Exynos5420 this is given as 'sclk_usbphy30' in CMU.
>>>> >>> +- samsung,pmu-syscon: phandle for PMU system controller interface, used to
>>>> >>> +                   control pmu registers for power isolation.
>>>> >>> +- samsung,pmu-offset: phy power control register offset to pmu-system-controller
>>>> >>> +                   base.
>>> >>
>>> >> It doesn't seem right to have register offset encoded in the device tree
>>> >> like this. I think it'd be more appropriate to associate such an offset
>>> >> with the compatible string's value in the driver.
>> >
>> > Ok, it makes more sense.
>> > Just out of curiosity, what difference would this make ?
>
> Moreover, in case of Exynos5420 (and may be in future SoCs), where we
> have 2 USB DRD PHY controllers,
> we will need to have a way around to deal with two separate offsets in
> the driver for one compatible string.

It could be handled by creating a list of offsets per compatible string and
then adding some way to identify the PHY device instance. So I believe that's
not a big issue. Now you'd be encoding a list of registers offsets in the
device tree, without encoding bit layout of each register. It's unlikely that
each instance would have different bits layout, but describing individual 
registers in DT I thought is something that we're not supposed to do.
 
> Getting the offsets from DT seems a cleaner way to handle this case of
> multi controllers.

I think it's easier from the driver POV, but isn't it violating the device
tree rules ?
Anyway. I'm just pointing this minor issue in the binding as it appears
to me. The final word of course belongs to a DT binding maintainer.

Regards,
-- 
Sylwester Nawrocki
Samsung R&D Institute Poland
