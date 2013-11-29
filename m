From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Fri, 29 Nov 2013 05:58:09 +0000
Subject: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20131128212510.GC14689@mithrandir>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
 <20131128212510.GC14689@mithrandir>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828DD72F@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Thanks for your detail comments.

> > +	switch (fpc->counter_clk_select) {
> > +	case VF610_CLK_FTM0:
> > +		reg |= FTMSC_CLKSYS;
> > +		break;
> > +	case VF610_CLK_FTM0_FIX_SEL:
> > +		reg |= FTMSC_CLKFIX;
> > +		break;
> > +	case VF610_CLK_FTM0_EXT_SEL:
> > +		reg |= FTMSC_CLKEXT;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	reg |= fpc->clk_ps;
> 
> And another one above this line.
> 
> > +	writel(reg, fpc->base + FTM_SC);
> 
> I think with the proper locking in place what you should do is increment
> counter_clk_enable only here. That makes avoids having to decrement the
> count on error.
> 
> Similarly in fsl_counter_clock_disable() you can postpone decrementing
> the count until the very end.
> 

As the other mails we have talked about this that there are 8 channels
supported, but they share the same counter clock source. So we need to
make sure that when one channel is calling fsl_counter_clock_disable()
it shouldn't disable the counter clock if any other channel is still
enabled. Similary in fsl_counter clock_enable().

This is why I set counter_clk_enable property here.


--
Best Regards,
