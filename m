From: david@lechnology.com (David Lechner)
Date: Mon, 23 Apr 2018 09:59:27 -0500
Subject: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
In-Reply-To: <152303318048.143116.2883441215887455211@swboyd.mtv.corp.google.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-13-git-send-email-david@lechnology.com>
 <CAMRc=MfQuqTK+mDT0Gawa6J-3d1z6djLutaHREKfVm+3hATEqQ@mail.gmail.com>
 <CAEG3pND6Cu0P_t3y_VM9Sm-GCb3yW0Pa8q4cRUOXYxa5=2nWUQ@mail.gmail.com>
 <a4d84be0-e3d3-4e39-40f9-cae9006cb6ee@ti.com>
 <CAMRc=Mc228JAxxBXcObmokh2h-toojG8OHrmbunm_ORqbGWUnA@mail.gmail.com>
 <69bc0848-0698-b936-96a3-2257a5e27809@ti.com>
 <CAMRc=MenWp=2dtOs1yafnHVkCxfT7SDS0fS2UxUd+U0s_UDwVw@mail.gmail.com>
 <57f2182e-09b4-2cab-5602-9d0e029495be@ti.com>
 <152303318048.143116.2883441215887455211@swboyd.mtv.corp.google.com>
Message-ID: <48c8531f-8cd9-a9f8-9c38-cbc4c921c4c9@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2018 11:46 AM, Stephen Boyd wrote:
> Quoting Sekhar Nori (2018-04-06 02:37:03)
>>
>> Can you please check that and confirm there is no issue with genpd and
>> using CLK_OF_DECLARE() to initialize clocks?
>>
>> Unless you report an issue back, or Mike and Stephen have ideas about
>> how to handle the dependency between PSC/PLL derived timer clock
>> initialization and and timer_probe(), I think we need to move back to
>> using CLK_OF_DECLARE().
> 
> In such a case, please use the hybrid approach where the clks required
> for the clockevent and/or clocksource are registered in the early
> CLK_OF_DECLARE path but the rest of the clks get registered with a
> proper platform device and driver. There are examples of this approach
> on other platforms already.
> 

I looked at this a bit last week, but I didn't come up with any approach
that I was happy with. It seems like it would be nice to just register
the absolute minimum clocks needed. On DA8XX, that would just be the PLL0
AUXCLK. On most of the other SoCs, it would be the PLL AUXCLK plus one
LPSC clock. The AUXCLKs are easy because they are just a simple gate
from the oscillator. The LPSC clocks are a bit more tricky because they
have a complex sequence for turning on. Furthermore, on DM646X, we need
the whole PLL up to SYSCLK3 plus one LPSC clock, so things get a bit
messy there.

The other approach I considered was to make the PLL and PSC drivers
work as platform devices or pure clock devices so that when needed,
the whole IP block could be registered in very early init. However,
this approach will pretty much require massive changes to the drivers
to remove all of the uses of devm_, dev_err, etc. so that it works
when dev == NULL.

Any other bright ideas or a preference for one of these two approaches?
