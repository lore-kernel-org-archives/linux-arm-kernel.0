From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Jun 2016 15:53:49 +0200
Subject: [PATCH] cpufreq: mvebu: fix integer to pointer cast
In-Reply-To: <63e7df1a-4ddf-8de0-a600-a09983ecbce6@codethink.co.uk>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
 <32804824.nq0AOIbNnC@wuerfel>
 <63e7df1a-4ddf-8de0-a600-a09983ecbce6@codethink.co.uk>
Message-ID: <7756626.Wd1TIA9Tg9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 9, 2016 9:11:38 AM CEST Ben Dooks wrote:
> On 09/06/16 08:07, Arnd Bergmann wrote:
> > On Wednesday, June 8, 2016 9:59:26 AM CEST Ben Dooks wrote:
> >> On 08/06/16 08:56, Mason wrote:
> >>> On 07/06/2016 13:30, Ben Dooks wrote:
> >>>
> >>>> Fix the use of 0 instead of NULL to clk_get() call. This stops the
> >>>> following warning:
> >>>>
> >>>> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
> >>>
> >>> May I ask which compiler/version produced that diagnostic?
> >>
> >> I was running with "make C=2 bzImage" for ARM multi_v7_config
> >>
> >> $ sparse --version
> >> v0.5.0
> >>
> > 
> > I believe gcc-6 will also produce a similar warning when building with
> > 'make W=1'. I've started looking into moving some of the warnings from
> > W=1 level to default, which can probably be done with relatively little
> > effort for many warnings.
> 
> Would be interesting to see, I tried W=2 and W=3 and ended up with
> hundreds of MiB of logs.
> 
> Out of interest, which other warnings do you think would make good
> next targets?

I fixed all the bugs for -Wmissing-include-dirs, -Woverride-init,
-Wold-style-declaration, -Wempty-body (not sure about submitting this
one), -Wunused-but-set-parameter and -Wignored-qualifiers.

With the above fixed, we can enable -Wextra after disabling -Wtype-limits
(though I fixed the files that had many occurrences of that),
-Wno-unused-parameter, -Wsign-compare and and -Wmissing-field-initializers,
all of which should stay in W=1 level.

	Arnd
