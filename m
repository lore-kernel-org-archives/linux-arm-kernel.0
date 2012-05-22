From: mturquette@ti.com (Mike Turquette)
Date: Tue, 22 May 2012 12:11:20 -0700
Subject: common clock framework
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D1A74B2C270@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <CAJOA=zOs8FLTRUh=LOd2f=YxFz7Sdxgp2JJurpQkdDFALcCiVw@mail.gmail.com>
 <CAG9bXv=T7v_MBUOmCsp4n0SNmYY_DOEkhQXAp0rTGpdi6KkXNA@mail.gmail.com>
 <20120506234958.GA14559@gmail.com>
 <AAD1C6EB06EE3649B35B7E026785068D1A74B2C256@SC-VEXCH2.marvell.com>
 <A63A0DC671D719488CD1A6CD8BDC16CF1A0F044EB4@SC-VEXCH4.marvell.com>
 <53612FE6B944314AAADB181E45A45B6413D3FF9F37@sc-vexch3.marvell.com>
 <AAD1C6EB06EE3649B35B7E026785068D1A74B2C270@SC-VEXCH2.marvell.com>
Message-ID: <20120522191120.GB4386@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120518-01:41, Chao Xie wrote:
> Hi
> Since the issues are not described very clearly, so I want to clarify it.

Is is possible for you to wrap your lines to a reasonable length?  I've
done it for you in the email below.

> Issue 1. clock with mux, divisor and trigger
> The clock A will have a single register that some bits control the
> mux, some bits control the divisor, and a bit is a trigger. It means
> that setting mux and divisor bits will only take effect when trigger
> bit is set.  There are 2 models that we can abstract this kind of
> clock.
> a. make three clocks.
> clock A <= clock div <= clock mux
> clock mux control the mux bits while clock div control the divisor
> bits, while clock a control trigger bit.  For example mux has two
> inputs 312MHZ and 1066MHZ, while divisor can be 1 or 2. At beginning
> clock mux is from 312M and clock div is 1. Clock A can only have clock
> as 312MHZ and 533MHZ.  so when invoke clk_set_rate(A, 512MHZ), it will
> try to upstream and find the "top" clock that can satisfy the 512MHZ.
> the "top" clock is clock mux. After find the "top" clock, the current
> code will have the following flows.
> 
> clk_notify(PRE_RATE_CHANGE)
>     ==> clk_change_rate(mux)
>         ==> mux->setrate: it will set mux bits
>         ==> polling all children, and for each one, invoke clk_change_rate
>            ==> clk_change_rate(div)
>               ==> div->setrate: it will set div bits
>               ==> polling all children, and for each one, invoke clk_change_rate
>                   ==>A->setrate: it will set trigger bit
> From above that the function looks well, but there will be some
> problem.  Clock mux change the mux bits will not finally switch the
> input from 312MHZ to 533MHZ. The switch is controlled by "trigger"
> bit. So clock mux should have .setrate implementation as you suggest
> as
>       1. enable new parent
>       2. set mux bits
>       3. __clk_reparent
>       4. disable old parent
> The clock mux implementation looks like omap dpll implementation. 
> But there are two bugs.
>    a) "Disable old parent" is only SW setting, we depends on trigger
>    to do it. So if for clock mux and clock div we all have trigger set
>    when set mux bits and div bits. It will import a temporary clock
>    1066MHZ(input = 1066, div = 1), it will harm the device. In fact,
>    there is why there is a trigger bit here. It will forbid there is
>    no temporary clock.

Let me make sure I understand you here.  You are concerned that the
.set_rate implementations for each clock (div and mux) will set the
trigger bit, causing intermediate clock rates.  Do I have that correct?

If that is the case then one solution is to not have your div and mux
.set_rate implementations set the trigger bit.  Instead always propagate
up to "clk A", the trigger clock so that the whole operation is atomic.

The only problem with this scenario is if you ever change only the div
(and not the mux) and there is no parent propagation up to "clk A".  Is
this a possibility on your platform?

>    b) if clk_change_rate(A) will invoke cpu_notify(POST_RATE_CHANGE),
>    while __clk_reparent will invoke __clk_recalc_rates, and in
>    __clk_recalc_rates, it will polling every children, and for each
>    one will invoke __clk_recalc_rates too. For __clk_recalc_rates, it
>    will invoke cpu_notify(POST_RATE_CHANGE), and it means that the
>    notification of POST_RATE_CHANGE will be invoke twice. I think the
>    omap dpll implementation will have this bug too.
> 

This has come up on the list recently.  I think one solution is to
remove the call to __clk_recalc_rates from __clk_reparent.  To be honest
__clk_reparent has grown beyond it's original intent.

> b. make a special clock a that includes all bits setting.
> Then we come back that we need patch " [PATCH V2] clk: give clock
> chance to change parent at setrate stage" in maillist
> 

This is a last resort option.  I'd prefer to make the multiple clocks
thing work.

Regards,
Mike
