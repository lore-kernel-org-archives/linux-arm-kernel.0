From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 27 May 2014 18:05:18 -0700
Subject: PXA 2xx devictree port and clock infrastructure
In-Reply-To: <87vbsqdd27.fsf@free.fr>
References: <87zji3cr3d.fsf@free.fr> <201405271717.48783.arnd@arndb.de>
 <20140527154303.GA6835@leverpostej> <4580668.Rz95HmpxUr@wuerfel>
 <87vbsqdd27.fsf@free.fr>
Message-ID: <20140528010518.7816.7374@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2014-05-27 16:20:00)
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > Right, that is the general recommendation at least. I'm always a bit cautious
> > when it comes to PXA because I don't expect that platform to fully get
> > converted to DT in the long run, and very little new work is going on there.
> >
> > OTOH, if people like Robert and Daniel do this for fun, it's definitely
> > great to see the full solution.
> 
> OK, so let's suppose I go for (c), and :
>  - create drivers/clk/clk-pxa2xx.c
>    => OF clock driver
>  - amend the mach-pxa accordingly to move all clock stuff to this driver
> 
> Is there a clean way for the transition phase, where devicetree pxa-dt machine
> will have to exist with non-DT machine code ? ie. is there around a clock driver
> I can look at where both OF *and* non-OF are working ?
> 
> Ah, and given that PXA clocks are very simple :
>  - their rate is almost always constant, and not changeable
>  - only one register exists to enable/disable all the clocks (bitmask of 32
>  possible clock enables)
> 
> Isn't there already a skeleton to handle this type of clocks ? It looks to me
> pretty generic, yet I haven't found it in drivers/clk. Maybe I missed something
> ?

There is a fixed-rate clock type already and a fixed-factor (e.g.
fixed-divider) clock type. DT bindings exist for these types already.
See,

drivers/clk/clk-fixed-rate.c
drivers/clk/clk-fixed-factor.c
Documentation/devicetree/bindings/clock/fixed-clock.txt
Documentation/devicetree/bindings/clock/fixed-factor-clock.txt

For the gate clocks we have a gate-clock type:

drivers/clk/clk-gate.c

No DT binding exists for this type, as it it usually parsed by a
platform- or controller-specific compatible string. For an example of a
32-bit register where each bit toggles a clock gate, please see:

Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt

There might be simpler examples that don't use the clock-indices stuff,
but that was just from a quick grep.

Regards,
Mike

> 
> Cheers.
> 
> --
> Robert
