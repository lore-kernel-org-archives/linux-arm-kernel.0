From: cxie4@marvell.com (Chao Xie)
Date: Fri, 18 May 2012 01:41:15 -0700
Subject: common clock framework
In-Reply-To: <53612FE6B944314AAADB181E45A45B6413D3FF9F37@sc-vexch3.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <CAJOA=zOs8FLTRUh=LOd2f=YxFz7Sdxgp2JJurpQkdDFALcCiVw@mail.gmail.com>
 <CAG9bXv=T7v_MBUOmCsp4n0SNmYY_DOEkhQXAp0rTGpdi6KkXNA@mail.gmail.com>
 <20120506234958.GA14559@gmail.com>
 <AAD1C6EB06EE3649B35B7E026785068D1A74B2C256@SC-VEXCH2.marvell.com>
 <A63A0DC671D719488CD1A6CD8BDC16CF1A0F044EB4@SC-VEXCH4.marvell.com>
 <53612FE6B944314AAADB181E45A45B6413D3FF9F37@sc-vexch3.marvell.com>
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D1A74B2C270@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
Since the issues are not described very clearly, so I want to clarify it.
Issue 1. clock with mux, divisor and trigger
The clock A will have a single register that some bits control the mux, some bits control the divisor, and a bit is a trigger. It means that setting mux and divisor bits will only take effect when trigger bit is set.
There are 2 models that we can abstract this kind of clock.
a. make three clocks.
clock A <= clock div <= clock mux
clock mux control the mux bits while clock div control the divisor bits, while clock a control trigger bit.
For example mux has two inputs 312MHZ and 1066MHZ, while divisor can be 1 or 2. At beginning clock mux is from 312M and clock div is 1. Clock A can only have clock as 312MHZ and 533MHZ.
so when invoke clk_set_rate(A, 512MHZ), it will try to upstream and find the "top" clock that can satisfy the 512MHZ. the "top" clock is clock mux. After find the "top" clock, the current code will have the following flows.

clk_notify(PRE_RATE_CHANGE)
    ==> clk_change_rate(mux)
        ==> mux->setrate: it will set mux bits
        ==> polling all children, and for each one, invoke clk_change_rate
           ==> clk_change_rate(div)
              ==> div->setrate: it will set div bits
              ==> polling all children, and for each one, invoke clk_change_rate
                  ==>A->setrate: it will set trigger bit
>From above that the function looks well, but there will be some problem.
Clock mux change the mux bits will not finally switch the input from 312MHZ to 533MHZ. The switch is controlled by "trigger" bit. So clock mux should have .setrate implementation as you suggest as
      1. enable new parent
      2. set mux bits
      3. __clk_reparent
      4. disable old parent
The clock mux implementation looks like omap dpll implementation. 
But there are two bugs.
   a) "Disable old parent" is only SW setting, we depends on trigger to do it. So if for clock mux and clock div we all have trigger set when set mux bits and div bits. It will import a temporary clock 1066MHZ(input = 1066, div = 1), it will harm the device. In fact, there is why there is a trigger bit here. It will forbid there is no temporary clock.
   b) if clk_change_rate(A) will invoke cpu_notify(POST_RATE_CHANGE), while __clk_reparent will invoke __clk_recalc_rates, and in __clk_recalc_rates, it will polling every children, and for each one will invoke __clk_recalc_rates too. For __clk_recalc_rates, it will invoke cpu_notify(POST_RATE_CHANGE), and it means that the notification of POST_RATE_CHANGE will be invoke twice. I think the omap dpll implementation will have this bug too.

b. make a special clock a that includes all bits setting.
Then we come back that we need patch " [PATCH V2] clk: give clock chance to change parent at setrate stage" in maillist

Issue 2: clock with dependency
As we know that each vendor may have some version of SOCs, and these SOC may share some same components.
For example, device a need function clock A while device B need function clock B, there share some bus, and there a clock for the bus clock gating. It means that if we want device B working, we need enable clock B and clock bus.
In fact, we can not consider that clock bus is the parent of clock A/B, because clock A/B has inputs from PLLs.
So how do we control these clocks? If leaving the dependency in clock tree, we need additional patch for it. If leaving it to device driver, it will make the device driver to know more details about clock framework, and for different SOCs share same device driver, the clock framework may not same. So it will make the device driver to be SOCs depended, and will need more detailed platform data.




-----Original Message-----
From: Mike Turquette [mailto:mturquette at ti.com] 
Sent: Monday, May 07, 2012 7:50 AM
To: Raul Xiong
Cc: Sascha Hauer; linux-arm-kernel at lists.infradead.org; Chao Xie
Subject: Re: common clock framework

On 20120505-13:33, Raul Xiong wrote:
> 2012/5/5 Turquette, Mike <mturquette@ti.com>
> > Bad news: lockdep gets cranky about possible deadlocks due to holding
> > prepare_lock and then trying to hold it again in a rate-change
> > notifier handler (from OMAP's regulator code).  Specifically
> >
> 
> Glad to see common clock framework will support DVFS. Can we use different
> spinlock for different clocks with different lockdep lock classes to avoid
> the dead lock and lockdep warnings?

I understand that different lockdep classes could allow for nested
locking, but I don't have a good idea of how that would actually be
implemented.  Could you elaborate a bit more?

In the mean time I'm looking at some different locking semantics that
don't involve lockdep class mangling, just a more fine-grained approach
to locking exactly what we want.

Regards,
Mike
