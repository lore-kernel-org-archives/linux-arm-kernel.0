From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Mon, 2 Jul 2012 19:29:29 +0300
Subject: [PATCH] OMAP4: Clock: Correct OTG clock to use otg_60m_gfclk.
In-Reply-To: <4FF1977B.1080002@ti.com>
References: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com>
 <alpine.DEB.2.00.1206291434190.2338@utopia.booyaka.com>
 <4FF1977B.1080002@ti.com>
Message-ID: <CAEa47NpaBfHB_HUvH9CLFUUHR1tNRnPsQMipdFagXWvYpcPuEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Benoit for the explanation. It seems you are right.
+ Wenbiao who is the original patch author that may have another point
of view and some additional explanations.

--
Best regards,
Ruslan Bilovol


On Mon, Jul 2, 2012 at 3:43 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>
> On 06/29/2012 10:35 PM, Paul Walmsley wrote:
>>
>> + Beno?t who is the maintainer of this file
>>
>> + the linux-arm-kernel mailing list, which should be cc'ed on all OMAP
>> patches
>>
>> On Fri, 29 Jun 2012, Ruslan Bilovol wrote:
>>
>>> From: Wenbiao Wang <wwang@ti.com>
>>>
>>> OTG clock usb_otg_hs_ick used a incorrect parent l3_div_ck.
>>> Correct it to use the right colck otg_60m_gfclk as its
>>> parent.
>
>
> Mmm, that does not seems to be correct.
>
> otg_60m_gfclk is an optional clock. The interface clock is the main clock
> of that module. That's why this is the parent of the fake MODULEMODE clock
> node.
>
> Moreover you are changing as well the utmi_phy_clkout_ck. That's not
> mentioned at all in the changelog.
>
> I know that there are some non standard stuff in this clock scheme.
> The main reason being the utmi_phy_clkout_ck source is generated from the
> usb_phy module. Unfortunately the clock fmwk cannot handle module as a clock
> node.
>
> So, as of today, this only way to get the OTG_60M_FCLK clock available is
> to ensure that the usb_phy module is enabled before the usb_otg_hs module.
>
> Regards,
> Benoit
>
>>>
>>> Signed-off-by: Wenbiao Wang <wwang@ti.com>
>>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/clock44xx_data.c |   15 ++++++++-------
>>>   1 files changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
>>> b/arch/arm/mach-omap2/clock44xx_data.c
>>> index b825049..fd43214 100644
>>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>>> @@ -199,12 +199,6 @@ static struct clk tie_low_clock_ck = {
>>>         .ops            = &clkops_null,
>>>   };
>>>
>>> -static struct clk utmi_phy_clkout_ck = {
>>> -       .name           = "utmi_phy_clkout_ck",
>>> -       .rate           = 60000000,
>>> -       .ops            = &clkops_null,
>>> -};
>>> -
>>>   static struct clk xclk60mhsp1_ck = {
>>>         .name           = "xclk60mhsp1_ck",
>>>         .rate           = 60000000,
>>> @@ -992,6 +986,13 @@ static struct clk dpll_usb_clkdcoldo_ck = {
>>>         .recalc         = &followparent_recalc,
>>>   };
>>>
>>> +static struct clk utmi_phy_clkout_ck = {
>>> +       .name           = "utmi_phy_clkout_ck",
>>> +       .ops            = &clkops_null,
>>> +       .parent         = &dpll_usb_clkdcoldo_ck,
>>> +       .recalc         = &followparent_recalc,
>>> +};
>>> +
>>>   static const struct clksel dpll_usb_m2_div[] = {
>>>         { .parent = &dpll_usb_ck, .rates = div31_1to31_rates },
>>>         { .parent = NULL },
>>> @@ -2685,7 +2686,7 @@ static struct clk usb_otg_hs_ick = {
>>>         .enable_reg     = OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
>>>         .enable_bit     = OMAP4430_MODULEMODE_HWCTRL,
>>>         .clkdm_name     = "l3_init_clkdm",
>>> -       .parent         = &l3_div_ck,
>>> +       .parent         = &otg_60m_gfclk,
>>>         .recalc         = &followparent_recalc,
>>>   };
>>
>>
>> Beno?t should have a look at this one, I think.
>>
>>
>> - Paul
>>
>
>
