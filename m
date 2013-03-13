From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 Mar 2013 14:42:37 +0000
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <51408A71.9090501@gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-4-git-send-email-haojian.zhuang@linaro.org>
 <1363172730.3100.17.camel@hornet> <51408A71.9090501@gmail.com>
Message-ID: <1363185757.3100.66.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 14:17 +0000, Rob Herring wrote:
> How about:
> 
> 1 irq - TIMINT1
> 2 irqs w/ same source # - TIMINTC
> 2 irqs w/ different source # - TIMINT1 and TIMINT2
> 
> I'm not completely sure if Linux and the irq domain code handles the
> same interrupt source repeated. It should because that is basically a
> shared irq line.
> 
> If we ever see only TIMINT2 connected we can add a property for that,
> but I think that case is unlikely.

I was rather thinking about using the "interrupt-names" property and
naming them explicitly, eg:

	interrupt-names = "timint1", "timint2";
	interrupts = <1>, <2>;

	interrupt-names = "timint1";
	interrupts = <1>;

	interrupt-names = "timint2";
	interrupts = <2>;

	interrupt-names = "timintc";
	interrupts = <3>;

But now I see that of_amba_device_create() doesn't do anything about it
(platform device would use them as resource name so we could use
platform_get_resource_byname), so I'm not sure any more...

> > 
> >> +- reg: Should contain location and length for dual timer register.
> >> +- clocks: clock driving the dual timer hardware
> >> +	clocks = <&timclk0 &timclk1>;
> > 
> > Again, there are three "clock" inputs (even ignoring the APBCLK):
> 
> We should not ignore that clock as we may want this to be a proper
> amba_device someday.

Sorry, wrong wording. I meant to say "even not mentioning the
APBCLK" (because it's required anyway by the primecell binding). VE
SP804 node obviously has it defined:

v2m_timer01: timer at 110000 {                           
	compatible = "arm,sp804", "arm,primecell";    
	reg = <0x110000 0x1000>;
	interrupts = <2>;                
	clocks = <&v2m_sysctl 0>, <&v2m_sysctl 1>, <&smbclk>;
	clock-names = "timclken1", "timclken2", "apb_pclk";
};                                   

> > TIMCLK, TIMCLKEN1, TIMCLKEN2. The real clocking rate for the timer
> > depends on the TIMCLK and respective TIMCLKENx - see
> > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0271d/CJABHCIG.html 
> > 
> > The driver than could make educated choice based on this information.
> > 
> > You may choose to ignore this fact (and require only a clock
> > representing the effective rate). I did it for the VE DTS, but it still
> > doesn't seem completely right
> > 
> >> +Optional properties:
> >> +- arm,sp804-clocksource: Should contain the register offset of TIMER1 or
> >> +  TIMER2 in Dual Timer Controller.
> >> +	arm,sp804-clocksource = <0x20>;
> > 
> > You seem to be missing the "arm,sp804-clockevent" one here.
> 
> These should stay as aliases or go away as I suggested.

I merely pointed out that it's missing from the binding description.

I couldn't agree more that both should not be there in the first place.

Pawe?
