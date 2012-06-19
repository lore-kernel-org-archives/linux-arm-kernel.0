From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 19 Jun 2012 10:45:56 +0530
Subject: [PATCH 09/11] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
In-Reply-To: <alpine.DEB.2.00.1206070108540.6684@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061313.25532.84569.stgit@dusk> <4FD04C8D.50609@ti.com>
 <alpine.DEB.2.00.1206070108540.6684@utopia.booyaka.com>
Message-ID: <4FE00B0C.4070407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 June 2012 11:11 PM, Paul Walmsley wrote:
> On Thu, 7 Jun 2012, Rajendra Nayak wrote:
>
>> On Thursday 07 June 2012 11:43 AM, Paul Walmsley wrote:
>>> Until the OMAP4 code is converted to disable the use of the clock
>>> framework-based clockdomain enable/disable sequence, any clock used as
>>> a hwmod main_clk must have a clockdomain associated with it.  This
>>> patch populates some clock structure clockdomain names to resolve the
>>> following warnings during kernel init:
>>
>> But these associations are useless if the clock is not a 'gate' clock,
>> except for getting rid of these warnings. Maybe we should make hwmod
>> understand that not all clocks need to have a clockdomain associated
>> with it and stop complaining.
>
> In retrospect, I think I should have made clockdomains mandatory for all
> clocks for OMAP4 back then, rather than only allowing them for some
> clocks.  As I understand it, that would have saved a lot of time and
> debugging frustration on the bug fixed by commit
> 6c4a057bffe9823221eab547e11fac181dc18a2b ("ARM: OMAP4: clock data: Force a
> DPLL clkdm/pwrdm ON before a relock").  Oh well.

We should certainly have a better way for PM code to WARN() users if
some clocks which need clockdomains to be programmed together with
the clocks, have the clockdomain information missing. One way to do
that is make it mandatory for *all* clocks to have an associated
clockdomain, but that would mean we populate dummy and unnecessary
data atleast in some cases wherein it never gets used, just to get
rid of the WARN(). That certainly does not seem right.
The other way is really to make our frameworks understand and WARN()
*intelligently*.

Today we WARN() users only for main_clks used in hwmod. I feel this
WARN() should instead come from the clock framework, because there
are clearly clocks outside of what is handled by hwmod (like the one
in the commit above) which need this information.
We should also look at making the clock framework intelligent to
identify which clocks really need a clockdomain associated instead
of adding a WARN for every other clock. just my 2 cents..

>
>
> - Paul
