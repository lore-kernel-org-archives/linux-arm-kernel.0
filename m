From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Mar 2015 13:51:44 +0000
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <CAMuHMdV8_uKQQgYkRPFOBgrqgw_y9A7T84ukfgWZpJmTL0eFCQ@mail.gmail.com>
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
 <20150304120003.GL32624@x1> <20150306190812.11109.82130@quantum>
 <20150309092804.GB3427@x1>
 <CAMuHMdV8_uKQQgYkRPFOBgrqgw_y9A7T84ukfgWZpJmTL0eFCQ@mail.gmail.com>
Message-ID: <20150326135144.GI5951@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Mar 2015, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Mon, Mar 9, 2015 at 10:28 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Fri, 06 Mar 2015, Mike Turquette wrote:
> >> Quoting Lee Jones (2015-03-04 04:00:03)
> >> > Mike,
> >> >
> >> > Do you want me to resend this set with Robert's Reviewed-by applied,
> >> > or are you happy to apply it yourself?
> >>
> >> No need for the resend. I am hoping for a final review from a DT human.
> >>
> >> This approach looks fine to me. In practice I think it is restricted to
> >> hardware blocks that don't exist in DT yet (e.g. no driver, in the case
> >> of your interconnect) and that restriction is probably for the best.
> >
> > Agreed.
> 
> I think this restriction should be documented in the DT binding more clearly,
> as adding a "clk-always-on" node prohibits you from handling the clock
> correctly in
> the future.

Would you mind taking the time to explain what you think those
limitations are?

> Still, for simple devices where you don't have a driver, but have "predictable"
> bindings (e.g. a bus like "simple-pm-bus"), I think it's better to add
> a device node
> for that simple device now, incl. a reference to the clock, and have a simple
> driver that binds to the device, or platform code that looks for a
> compatible node,
> and enables the clock. That way you don't have to make any chances to the DTS
> later, when you'll have a real driver.
> 
> >> > > v2 => v3:
> >> > >   - Ensure DT actually reflects h/w
> >> > >     - i.e. Nodes should not contain a mishmash of different IP
> >> > >       blocks, but should identify related h/w.  In the current
> >> > >       example we use interconnects
> >> > >   - Change naming from clkdomain to clk-always-on
> >> > >   - Place "do not abuse" warning in documentation
> >> > >
> >> > > v1 => v2:
> >> > >   - Turned the ST specific driver into a generic one
> >> > >
> >> > > Hardware can have a bunch of clocks which must not be turned off.
> >> > > If drivers a) fail to obtain a reference to any of these or b) give
> >> > > up a previously obtained reference during suspend, the common clk
> >> > > framework will attempt to turn them off and the hardware will
> >> > > subsequently die.  The only way to recover from this failure is to
> >> > > restart.
> >> > >
> >> > > To avoid either of these two scenarios from catastrophically
> >> > > disabling the running system we have implemented a clock domain
> >> > > where clocks are consumed and references are taken, thus preventing
> >> > > them from being shut down by the framework.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
