From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 8 Feb 2017 17:42:04 -0800
Subject: [PATCH 2/2] ARM: dts: Qualcomm APQ8060 DragonBoard ALS sensor
In-Reply-To: <CACRpkdbH9WgC8EwERRNDUjnAAz7YAq-=S1Wja5Hq2w0uDeO7rg@mail.gmail.com>
References: <20170131102114.25085-1-linus.walleij@linaro.org>
 <20170131102114.25085-2-linus.walleij@linaro.org>
 <20170201183631.GJ10531@minitux>
 <CACRpkdbH9WgC8EwERRNDUjnAAz7YAq-=S1Wja5Hq2w0uDeO7rg@mail.gmail.com>
Message-ID: <20170209014204.GK27837@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 03 Feb 05:05 PST 2017, Linus Walleij wrote:

> On Wed, Feb 1, 2017 at 7:36 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > On Tue 31 Jan 02:21 PST 2017, Linus Walleij wrote:
> 
> >> +                                                     /* Let's use channel 5 */
> >> +                                                     qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH5>;
> >
> > Unrelated to this patch, I did look at how this works on later devices.
> > It seems like we want to be able to switch the amux-route depending on
> > which ADC "channel" we're querying - e.g. on DB820c we have thermistors
> > on 3 different AMUX inputs but we don't have 3 mpps available.
> >
> > Any thoughts on how to deal with this?
> 
> The AMUX is just one big mystery to me, it's one of those areas where I
> think a real datasheet would be extremely helpful.
> 

After additional research and a long chat with Stephen this is what I
have come up with.

On PM8058 you have 16 AMUX channels that can be either read as raw,
scaled or dived by 3, this is selected by the 2 "premux" bits in the
AMUX selector register.

AMUX channel 5-9 are called MPP5-9,
connected to a switching matrix so each MPP is configured to output its
signal on one of the 5 mpp-amux-channels. I.e. it's probably better to
rename these just "AMUX5" through "AMXU9".



On PM8921 this changes somewhat and an additional mux is introduced.
The first premux looks similar to pm8058, but with no direct MPP AMUXes
to be selected. Premux 1 or 2 is used to select the second level mux.

This mux has channels:
 1: usb_sns
 2: dcin_sns
 3: amux3 (reserved and called pa_therm)
 4: amux4 (reserved and called amux_in)
 5-8: amuxX (as configured output of MPPs)

Premux 2 has the same set of channels, but with a divisor of 3.

The MPP1/MPP2 AMUX channels in premux 0 found downstream are now
reserved - likely they the hardware used to select unity and div/3 input
from the second level mux.

Regards,
Bjorn
