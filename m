From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Tue, 14 Aug 2012 15:20:42 +0800
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
Message-ID: <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2012 23:12, Matt Sealey <matt@genesi-usa.com> wrote:
> I have a minor nit; while renumbering the pinctrl definitions is
> laudable and device trees can match, there are 16 other pin controls
> below EIM_D16 - this makes the start of the IOMUXC pin definitions
> actually be the value calculated by (iomuxc_base + 0x300 + (4*16) +
> (pin_id*4)).
>
What do you mean of this value calculated?
Pin id or pin register(mux or config) offset?
This is for mx51, right? then why 0x300?

> While this works, it's fine, but it would be more reasonable/correct
> to number pin indices from the first configurable pad and not by a
Yes, the data is originally get from:
arch/arm/plat-mxc/include/mach/iomux-mx51.h
So i just followed that sequence to index pin id and currently it
seems i didn't see
any big problem using this way.

> hardcoded magic offset into the base. The EIM_DA* pins below the
> current EIM_D16 are only configurable as CoreSight trace signals but
> it would save trouble later if anyone wanted to use these for example
> on a prototype board configured as those trace pads if they didn't
> have to renumber all the pins again. Nobody currently uses them in the
> tree but it makes more sense to me to count from the first
> configurable pad, than the first currently-used-in-the-tree
> configurable pad.
What trouble do you mean?
Those pins, EIM_DA*, are already defined but just on a different pin id.
Can't user use it in this way?

>
> Therefore I propose;
>
> * add MX51_PAD_EIM_DA0 through DA15 as index 0-15 (same for any
> differences in other i.MX etc.)
Hmm, as i said above, those pins are already defined.
See:
        MX51_PAD_SD1_DATA0 = 209,
        MX51_PAD_EIM_DA0 = 210,
        MX51_PAD_EIM_DA1 = 211,
        MX51_PAD_EIM_DA2 = 212,
        MX51_PAD_EIM_DA3 = 213,

> * move all the pin indices currently defined up by 16 for MX51 (same for above)
> * _then_ renumber the current device trees..
>
I did not quite understand, remove other pin ids up by 16? why?

> That way churn is minimized in the future and we don't end up changing
> trees and definitions again in the future in the event that someone
> DOES want to use those pads in a shippable product with mainline Linux
> support (and sees fit to enable TPIU_TRACE_EN for some reason and has
> the hardware to use it).
>
Why we may want to change the definitions again?
Since we already have those pins EIM_DA* defined, it looks to me user could use
it, the only difference is the id is different, i still can't see any
trouble to use it
Can you help detail a bit more if any trouble?

Regards
Dong Aisheng
