From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Feb 2013 13:12:51 +0800
Subject: [PATCH 2/2] ARM: imx: set CKO1 parent clock source in imx6q
 sabresd
In-Reply-To: <8D894AC610DA3944965280D4097EAC4603CD2F55@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1359701217-23931-1-git-send-email-b13634@freescale.com>
 <20130203104636.GB26233@S2101-09.ap.freescale.net>
 <8D894AC610DA3944965280D4097EAC4603CD2F55@039-SN2MPN1-021.039d.mgd.msft.net>
Message-ID: <20130204051250.GE26233@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 03:13:40AM +0000, Zhang Quan-B13634 wrote:
> >  > -static void __init imx6q_sabrelite_cko1_setup(void)
> >  > +static void __init cko1_setup(unsigned long freq)
> >  >  {
> >  >  	struct clk *cko1_sel, *ahb, *cko1;
> >  >  	unsigned long rate;
> >  > @@ -132,8 +132,10 @@ static void __init imx6q_sabrelite_cko1_setup(void)
> >  >  		goto put_clk;
> >  >  	}
> >  >  	clk_set_parent(cko1_sel, ahb);
> >  > -	rate = clk_round_rate(cko1, 16000000);
> >  > +	rate = clk_round_rate(cko1, freq);
> >  >  	clk_set_rate(cko1, rate);
> >  > +
> >  > +	return;
> >  
> >  Why does this "return" needs to be added here?
> [Gary-b13634] because the codes below may be ignored when execute 'return' ,
> Saving cpu consumption.

But we haven't finished our job.  We need to "put" those clocks before
returning to balance the "get" call.

Shawn
