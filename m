From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 13 Jan 2014 19:10:17 +0100
Subject: DT include files
In-Reply-To: <52D418EB.1040605@wwwdotorg.org>
References: <CAOesGMheei8YgzfRp9pmQ0rT9zhJ2_hF56j5Y+jLSy5TadPZ-g@mail.gmail.com>
 <20140103030455.GB25079@S2101-09.ap.freescale.net>
 <CAOesGMihX-pLva-aBCHJ6TYfsN57MzRWiYFTnfKCXOKeja0uUg@mail.gmail.com>
 <20140104011056.GA3282@S2101-09.ap.freescale.net>
 <20140110024124.GA6844@S2101-09.ap.freescale.net>
 <CAOesGMh3HBCYut2hfub3svrJT5JJzoWq8mU=VU0grZbg-JqqbA@mail.gmail.com>
 <52CFF57D.8060808@samsung.com>
 <CAL_JsqKHr6v+6kNXrAdnzH0gpoFCPAjPSnX8iBDgRSMh9JgxvA@mail.gmail.com>
 <20140110170319.GC20094@book.gsilab.sittig.org>
 <52D418EB.1040605@wwwdotorg.org>
Message-ID: <20140113181017.GI20094@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 09:48 -0700, Stephen Warren wrote:
> 
> On 01/10/2014 10:03 AM, Gerhard Sittig wrote:
> > On Fri, Jan 10, 2014 at 09:30 -0600, Rob Herring wrote:
> >>
> >> As for *.h vs. *.dtsi naming, if the include is only pre-processor
> >> defines, then I think using .h is the right way. Otherwise, if there
> >> is any dts syntax, then .dtsi is the right name. It looks to me like
> >> this style has been followed in both the imx and s3c64xx cases.
> >>
> >> On a side note, I'm not really a fan of this pattern:
> >>
> >> #define FOO1 1 2 3
> >>
> >> #define BAR FOO1 FOO2 FOO3
> >>
> >> While it definitely simplifies the dts files, it would never be used
> >> in C and obfuscates what the actual property size is. Reading a dts
> >> file, I would naturally assume the define was a single value while in
> >> fact it could expand to a very large property size.
> > 
> > For more complex yet tedious repetitive cases like GPIO banks and
> > pins I've seen #define directives which introduce "functions"
> > (macros with parameters).  They appear to be rather useful, can
> > reflect very well the essence of the information, don't
> > necessarily pretend to be single values, but still may hide how
> > many cells they expand to.  For example:
> > 
> >   arch/arm/boot/dts/tegra30-cardhu.dtsi:
> >     interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
> 
> I'm not sure I entirely understand your point, but for the record, both
> TEGRA_GPIO() and IRQ_TYPE_LEVEL_HIGH expand to a single cell, as I would
> expect (almost?) any DT macro to do.

It turns out I slightly misunderstood Rob's concern.  The issue
is not that the use of the C language preprocessor is discouraged
or frouned upon, but instead that obfuscating invariant data or
spilling random parts of the information across the place in
unneeded ways is unwanted.  While there is agreement that the use
of symbolic identifiers can help readability and maintainability
in certain situations.

Regarding your specific reply:  I haven't noticed before that all
of the macros I cited do expand to a single cell.  Before that I
saw the potential to generate more cells when required for a
single value (like "wide" addresses, or multi cell pins or
channels or whatever).  Can't tell how much of a concern there is
against such an approach, don't have strong feelings about it.

Actually I wasn't picking at those specific macros above, quite
the contrary.  Those were the first I came across searching for
demonstration of useful preprocessor use. :)  I just did not
bother to cite several hundred other useful phrases as well.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
