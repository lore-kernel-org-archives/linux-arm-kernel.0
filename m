From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 19:33:47 +0000
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <513F7EBD.80207@gmail.com>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com>
Message-ID: <201303121933.47994.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Rob Herring wrote:
> On 03/12/2013 12:08 PM, Haojian Zhuang wrote:

> You are breaking existing dtb's changing this, but this is wrong for
> other reasons. The integrator does not have an SP804. It is the same
> programming model, but is a single timer and not the dual timer. So
> having a different compatible string is the correct way. I doubt it has
> the primecell ID registers which is what "arm,primecell" indicates.

At least the qemu model has the primecell ID only for actual sp804 but
not for the integrator, see http://git.qemu.org/?p=qemu.git;a=blob;f=hw/arm_timer.c

> >  	};
> >  
> >  	timer1: timer at 13000100 {
> > -		compatible = "arm,integrator-timer";
> > +		compatible = "arm,sp804", "arm,primecell";
> > +		arm,sp804-clockevent = <0>;
> 
> I don't like this nor the old way with aliases. We should describe the
> h/w features of the timer to determine what to use it for. AFAICT, all 3
> timers are identical on integrator and it does not matter which one
> Linux picks for clocksource vs. clockevent.

Interesting point. I remember we had a discussion about this when the
initial binding integrator code was merged, but I don't remember what
the intent was for doing it like this. Probably just minimizing the
changes to the existing code.

	Arnd
