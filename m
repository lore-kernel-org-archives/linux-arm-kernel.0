From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Tue, 24 Feb 2015 12:23:36 -0500
Subject: [PATCH v2 2/2] ARM: perf: Add support for Scorpion PMUs
In-Reply-To: <20150220201627.GD24928@codeaurora.org>
References: <1423851849-6069-1-git-send-email-sboyd@codeaurora.org>
 <1423851849-6069-3-git-send-email-sboyd@codeaurora.org>
 <20150220193552.GE1767@arm.com>
 <20150220201627.GD24928@codeaurora.org>
Message-ID: <CAJ5Y-eYLeeNDcBtdvMf-k0XGxq-P21FDq-VMHPJsp4=ccuemig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2015 at 15:16, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/20, Will Deacon wrote:
>> On Fri, Feb 13, 2015 at 06:24:09PM +0000, Stephen Boyd wrote:
>>
>> > +static void scorpion_evt_setup(int idx, u32 config_base)
>> > +{
>> > +       u32 val;
>> > +       u32 mask;
>> > +       u32 vval, fval;
>> > +       unsigned int region;
>> > +       unsigned int group;
>> > +       unsigned int code;
>> > +       unsigned int group_shift;
>> > +       bool venum_event;
>> > +
>> > +       krait_decode_event(config_base, &region, &group, &code, &venum_event,
>> > +                          NULL);
>> > +
>> > +       group_shift = group * 8;
>> > +       mask = 0xff << group_shift;
>> > +
>> > +       /* Configure evtsel for the region and group */
>> > +       if (venum_event)
>> > +               val = SCORPION_VLPM_GROUP0;
>> > +       else
>> > +               val = scorpion_get_pmresrn_event(region);
>> > +       val += group;
>> > +       /* Mix in mode-exclusion bits */
>> > +       val |= config_base & (ARMV7_EXCLUDE_USER | ARMV7_EXCLUDE_PL1);
>> > +       armv7_pmnc_write_evtsel(idx, val);
>> > +
>> > +       asm volatile("mcr p15, 0, %0, c9, c15, 0" : : "r" (0));
>>
>> What's this guy doing?
>
> This is the same as Krait. It's clearing some implementation
> defined register. From what I can tell it's a per-event register
> (i.e. PMSELR decides which event this register write actually
> affects) and we do this here to reset this register to some
> defined value, zero. Otherwise the reset value of this register
> is UNPREDICTABLE and that would be bad. I think we might be able
> to move it to the pmu reset path, but I don't know. Ashwin?

Will have to check once I get to office tomorrow.
