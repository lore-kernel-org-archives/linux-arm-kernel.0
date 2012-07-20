From: nm@ti.com (Menon, Nishanth)
Date: Fri, 20 Jul 2012 04:04:19 -0500
Subject: [PATCH 2/3] PM / OPP: Initialize OPP table from device tree
In-Reply-To: <20120720084655.GB31866@S2101-09.ap.freescale.net>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-3-git-send-email-shawn.guo@linaro.org>
 <CAOMWX4fq8aWpRgtBj+5FgqhMus=zJL3Ubqe9pwiz-Y3a6V3svg@mail.gmail.com>
 <20120720084655.GB31866@S2101-09.ap.freescale.net>
Message-ID: <CAOMWX4eAUH1LSshfaZnc2Pj5r39e9v5axTVFa37U0xEP66uczg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 3:46 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
>> > +       ret = of_property_read_u32_array(np, propname, opp, nr);
>> > +       if (ret) {
>> > +               dev_err(dev, "%s: Unable to read OPPs\n", __func__);
>> > +               goto out;
>> > +       }
>> > +
>> > +       nr /= 3;
>> > +       for (i = 0; i < nr; i++) {
>> > +               /*
>> > +                * Each OPP is a set of tuples consisting of frequency,
>> > +                * voltage and availability like <freq-kHz vol-uV enable>.
>> > +                */
>> > +               u32 *val = opp + i * 3;
>> > +
>> > +               val[0] *= 1000;
>> > +               ret = opp_add(dev, val[0], val[1]);
>> > +               if (ret) {
>> > +                       dev_warn(dev, "%s: Failed to add OPP %d: %d\n",
>> > +                                __func__, val[0], ret);
>> > +                       continue;
>> > +               }
>> > +
>> > +               if (!val[2]) {
>> > +                       ret = opp_disable(dev, val[0]);
>> Since we are updating the table out of context of the SoC users,
>> consider what might happen if someone where to operate on the OPP
>> after opp_add, but before opp_disable?
>
> I would take this as another comment reminding me to remove the
> enabling/availability tuple from the binding.  Will do it in the
> next version.
I am not completely convinced that dropping the flag would be the best approach
on a long run, but might be a good starting point while we meet current reqs and
as a need arises, could increase the scope. Thanks once again for doing this.

Regards,
Nishanth Menon
