From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 21 Jun 2013 09:09:27 +0200
Subject: [PATCH v7 00/11] Add generic set_rate clk_ops for PLL35xx and
 PLL36xx for samsung SoCs
In-Reply-To: <CAGm_ybiVZOPBJJ0bYX33wafn1So6aqSAnk7myXZ+Z+RfLBeBQw@mail.gmail.com>
References: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
 <CAKew6eUOy4=D08v_iq7CTRY5gvt37VAN7Z7WOr2Yt25znDJb2g@mail.gmail.com>
 <CAGm_ybiVZOPBJJ0bYX33wafn1So6aqSAnk7myXZ+Z+RfLBeBQw@mail.gmail.com>
Message-ID: <1524664.UCV47tfIRU@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 of June 2013 10:18:01 Vikas Sajjan wrote:
> Hi Mr. Kim,
> 
> On Thu, Jun 20, 2013 at 3:37 PM, Yadwinder Singh Brar
> 
> <yadi.brar01@gmail.com> wrote:
> > Hi Tomasz,
> > 
> > On Thu, Jun 20, 2013 at 3:30 PM, Tomasz Figa <t.figa@samsung.com> 
wrote:
> >> Hi Yadwinder, Vikas,
> >> 
> >> On Tuesday 11 of June 2013 15:01:05 Yadwinder Singh Brar wrote:
> >>> This patch series does the following:
> >>>  1) Unifies the clk strutures  and registration function used for
> >>>  PLL35xx>>> 
> >>> & PLL36xx, to factor out possible common code.
> >>> 
> >>>  2) Defines a common rate_table which will contain recommended p, m,
> >>>  s
> >>> 
> >>> and k values for supported rates that needs to be changed for
> >>> changing
> >>> corresponding PLL's rate
> >>> 
> >>>  3) Adds set_rate() and round_rate() clk_ops for PLL35xx and PLL36xx
> >>> 
> >>> changes since v6:
> >>>       - Splited the patch adding samsung_clk_register_pll() into
> >>>       definition
> >>>       addition, SoC specific migration and cleanup patches.
> >>>       - Addressed some NIT comments.
> >> 
> >> This version looks good to me. Thanks for your work on improving this
> >> series again!
> >> 
> >> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
> Can you apply this series..

I think we need at least Mike's (clk subsystem maintainer) ACK here.

Mike, do you have any objections?

Best regards,
Tomasz

> > Thanks for helping to improve this series.
> > 
> > Thanks,
> > Yadwinder
> > 
> >> Best regards,
> >> Tomasz
> >> 
> >>> changes since v5:
> >>>       - Corrected to use rate table as specified in UM for
> >>>       exynos5250 epll.
> >>>       - Took care of exynos5420 as well, as new exynos5420 clk
> >>>       driver came in
> >>>       while rebasing on latest Kgene's for-next.
> >>>       
> >>>       Since we spilted 1st patch into 2 different patches,
> >>>       can we expect "reviewed-by" again for the same?
> >>> 
> >>> changes since v4:
> >>>       - Defined common samsung samsung_clk_register_pll() to
> >>>       register a list
> >>>       of PLL and used a struct samsung_pll_clock for passing
> >>>       intialisation
> >>>       data instead of passing as arguments. Now passing LOCK as well
> >>>       as CON0
> >>>       offset as intialisation data.
> >>>       - Calculated length of rate table while registering PLL
> >>>       instead of
> >>>       getting it as intialisation data.
> >>> 
> >>> changes since v3:
> >>>       - Used __clk_lookup() instead of adding alias for mout_vpllsrc
> >>>       - Added check for changing only M value in
> >>>       samsung_pll36xx_set_rate()
> >>>       - Modified samsung_pll35xx_mp_change() &
> >>>       samsung_pll35xx_set_rate()
> >>>       to improve readabilty.
> >>>       - Made the input rate_table as __init_data which is to be
> >>>       provided
> >> 
> >> while
> >> 
> >>> registering PLL and made a copy of that table while registering, so
> >>> that if multiple tables are their, they can be freed after getting
> >>> the P, M, S, K setting values from required one.
> >>> 
> >>> changes since v2:
> >>>       - Added new patch to reorder the MUX registration for
> >>>       mout_vpllsrc MUX
> >>>       before the PLL registrations. And to add the alias for the
> >>>       mout_vpllsrc
> >>> 
> >>> MUX. - Added a check to confirm parent rate while registrating the
> >>> PLL
> >>> rate tables.
> >>> 
> >>> changes since v1:
> >>>       - removed sorting and bsearch
> >>>       - modified the definition of struct "samsung_pll_rate_table"
> >>>       - added generic round_rate()
> >>>       - rectified the ops assignment for "rate table passed as NULL
> >>> 
> >>> Is rebased on branch kgene's "for-next"
> >>> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git
> >>> /log/ ?h=for-next
> >>> 
> >>> Vikas Sajjan (3):
> >>>   clk: samsung: Add set_rate() clk_ops for PLL36xx
> >>>   clk: samsung: Reorder MUX registration for mout_vpllsrc
> >>>   clk: samsung: Add EPLL and VPLL freq table for exynos5250 SoC
> >>> 
> >>> Yadwinder Singh Brar (8):
> >>>   clk: samsung: Introduce a common samsung_clk_pll struct
> >>>   clk: samsung: Define a common samsung_clk_register_pll()
> >>>   clk: samsung: Migrate exynos5250 to use common
> >>>   
> >>>     samsung_clk_register_pll()
> >>>   
> >>>   clk: samsung: Migrate exynos4 to use common
> >>>   
> >>>     samsung_clk_register_pll()
> >>>   
> >>>   clk: samsung: Migrate exynos5420 to use common
> >>>   
> >>>     samsung_clk_register_pll()
> >>>   
> >>>   clk: samsung: Remove unused pll registeration code for pll35xx and
> >>>   
> >>>     pll36xx
> >>>   
> >>>   clk: samsung: Add support to register rate_table for samsung plls
> >>>   clk: samsung: Add set_rate() clk_ops for PLL35xx
> >>>  
> >>>  drivers/clk/samsung/clk-exynos4.c    |   40 +++--
> >>>  drivers/clk/samsung/clk-exynos5250.c |  101 +++++++++--
> >>>  drivers/clk/samsung/clk-exynos5420.c |   86 ++++++---
> >>>  drivers/clk/samsung/clk-pll.c        |  339
> >>> 
> >>> ++++++++++++++++++++++++++-------- drivers/clk/samsung/clk-pll.h
> >>> 
> >>> |   38 ++++-
> >>>  
> >>>  drivers/clk/samsung/clk.h            |   53 ++++++
> >>>  6 files changed, 519 insertions(+), 138 deletions(-)
> >> 
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >> linux-samsung-soc" in the body of a message to
> >> majordomo at vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-samsung-soc" in the body of a message to
> > majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
