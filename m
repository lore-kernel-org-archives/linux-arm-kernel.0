From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 25 Nov 2014 10:19:28 +0100
Subject: [PATCH RFC v2 08/12] soc: samsung: pm_domain: Add support for
 parent power domain
In-Reply-To: <CADGdYn4Vi2wV1y3Y0cTbPL0cFR2EEV7jT=82fHNYu+=xwZ7mBA@mail.gmail.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-8-git-send-email-amit.daniel@samsung.com>
 <CAPDyKFoBnViXQF=wDYp0x4gaOO4ht3a8KBeY6=k6_Zkkav28pQ@mail.gmail.com>
 <CADGdYn4Vi2wV1y3Y0cTbPL0cFR2EEV7jT=82fHNYu+=xwZ7mBA@mail.gmail.com>
Message-ID: <CAMuHMdX+rcmUM+_4c72b16Zs_c5KMhO3bYSH5-AUp087cwGdeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 9:57 AM, amit daniel kachhap
<amit.daniel@samsung.com> wrote:
>>> diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>>> index 00ebda1..0160bdc 100644
>>> --- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>>> +++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
>>> @@ -24,6 +24,7 @@ Optional Properties:
>>>         - pclkN, clkN: Pairs of parent of input clock and input clock to the
>>>                 devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
>>>                 are supported currently.
>>> +- parents: phandle of parent power domains.

Why not using just "power-domains = <&pd_top>"?
This is consistent with how clocks refer to their parent clocks.

>>>  Node of a device using power domains must have a samsung,power-domain property
>>>  defined with a phandle to respective power domain.
>>> @@ -48,6 +49,7 @@ Example:
>>>         mfc_pd: power-domain at 10044060 {
>>>                 compatible = "samsung,exynos4210-pd", "samsung,exynos7-pd-mfc";
>>>                 reg = <0x10044060 0x20>;
>>> +               parents = <&pd_top>;
>>>                 #power-domain-cells = <0>;
>>>         };
>>
>> This seems like a good and generic approach to describe that a PM
>> domain could have a parent. I would suggest to rename it, such it
>> reflects its a PM domain binding though.
> I am not sure if this is generic. I guess PD's represented like below
> are more generic.
> PD1 {
>         PD2 {
>                 PD3 {
>                 };
>         };
> };

Such a representation is not always possible.
If you have one power-controller for a hierarchy of PM domains, you can
use it.
If you have multiple power-controllers, the power controller nodes are at the
same level in DT, so you'll have to use "power-domains" properties to link
them together.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
