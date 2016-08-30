From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 30 Aug 2016 11:43:09 -0700
Subject: [PATCH 2/2] clk: mvebu: dynamically allocate resources in Armada
 CP110 system controller
In-Reply-To: <CAPv3WKdVX1p3qmUufXE_cd=A0fuS8Eg9ELT0AYnXV6Z=cgJg-w@mail.gmail.com>
References: <1471933609-8456-1-git-send-email-mw@semihalf.com>
 <1471933609-8456-3-git-send-email-mw@semihalf.com>
 <20160825001613.GQ19826@codeaurora.org>
 <CAPv3WKdVX1p3qmUufXE_cd=A0fuS8Eg9ELT0AYnXV6Z=cgJg-w@mail.gmail.com>
Message-ID: <20160830184309.GB12510@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30, Marcin Wojtas wrote:
> 2016-08-25 2:16 GMT+02:00 Stephen Boyd <sboyd@codeaurora.org>:
> > On 08/23, Marcin Wojtas wrote:
> >> @@ -335,10 +343,12 @@ static int cp110_syscon_clk_probe(struct platform_device *pdev)
> >>               cp110_clks[CP110_MAX_CORE_CLOCKS + i] = clk;
> >>       }
> >>
> >> -     ret = of_clk_add_provider(np, cp110_of_clk_get, &cp110_clk_data);
> >> +     ret = of_clk_add_provider(np, cp110_of_clk_get, cp110_clk_data);
> >
> > It would be nice if this could be converted to
> > of_clk_add_hw_provider().
> 
> Will try it. Shouldn't such change be placed in separate commit?

Yes, of course.

> 
> >
> >>       if (ret)
> >>               goto fail_clk_add;
> >>
> >> +     platform_set_drvdata(pdev, cp110_clks);
> >> +
> >>       return 0;
> >>
> >>  fail_clk_add:
> >> @@ -365,6 +375,7 @@ fail0:
> >>
> >>  static int cp110_syscon_clk_remove(struct platform_device *pdev)
> >>  {
> >> +     struct clk **cp110_clks = platform_get_drvdata(pdev);
> >
> > Is this variable unused now?
> 
> No, why? Just below there is a loop using it. Before it was taken from
> global variable, which I got rid of.
> 

Ok. I was just looking at the patch context.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
