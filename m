From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 15 May 2014 16:07:24 +0200
Subject: [PATCH 1/4] clk: samsung: out: Add infrastructure to register
 CLKOUT
In-Reply-To: <CAPdUM4N=k-pPxdhPQgVHh0fb+nqkgs7StwM2Pb6C8gcjx6dw-w@mail.gmail.com>
References: <1399640410-30957-1-git-send-email-tushar.behera@linaro.org>
 <1399640410-30957-2-git-send-email-tushar.behera@linaro.org>
 <536DA243.6000600@samsung.com> <53705243.1030704@linaro.org>
 <CAPdUM4N=k-pPxdhPQgVHh0fb+nqkgs7StwM2Pb6C8gcjx6dw-w@mail.gmail.com>
Message-ID: <5374CA1C.8000207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul, Tushar,

On 15.05.2014 15:44, Rahul Sharma wrote:
> Hi Tushar,
> 
> Basically you are adding a new clock-type for Clkout. IMO clkout
> is not a special hardware. Existing clock types can be reused to
> support clkout. I see 3 major problem here:
> 
> 1) Clkout -> (Mux + Gate). You clubbed mux and gate together, and
> exposing as a single clock which is something like a composite clock.
> IMO this is not a recommended way in CCF.
> 
> 2) New Clock Type: Since clkout is just a combination of a simple
> mux and gate which are already supported, it is a unnecessary
> duplication.
> 
> 3) Clkout registered along with CMU: which is not correct. Clkout is in PMU
> (Separate physical IP) and should be registered as a independent Clock
> provider which provides 1 mux and 1 gate clock (As if now). It should also be
> well connected with main CMU.
> 
> I understand the challenge in using regmap interface for a clock provider. But
> we need to identify a clean solution. IMHO a independent clock provider with
> iomap, is relatively cleaner approach till CCF is not ready with regmap based
> reg access for clock registers.
> 
> Experts!! please comment.

It's quite unfortunate that Tushar has duplicated the effort to create a
clkout driver, considering the fact that we did have such driver
internally at SRPOL and it was quite nice and simple.

I will post a cleaned-up version today, that is about 2 times smaller in
terms of lines of added code and provides the same functionality,
without introducing custom clock types. In addition, it models the
clkout properly as a feature of PMU, not CMU (CMU only provides outputs
of particular sub-blocks that are fed into the PMU).

Best regards,
Tomasz
