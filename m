From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jan 2017 19:11:59 +0000
Subject: [STLinux Kernel] [PATCH 3/8] serial: st-asc: Read in all Pinctrl
 states
In-Reply-To: <20170130161041.GA21001@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-4-lee.jones@linaro.org>
 <20170125112142.GE5680@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170127115458.k4edg42nnna3bv4v@dell>
 <20170130142356.GA18710@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170130153211.j75qemvwsq3cwqve@dell>
 <20170130161041.GA21001@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20170130191159.zv5jegvu4fetcmzo@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Jan 2017, Peter Griffin wrote:
> On Mon, 30 Jan 2017, Lee Jones wrote:
> > On Mon, 30 Jan 2017, Peter Griffin wrote:
> > > On Fri, 27 Jan 2017, Lee Jones wrote:
> > > > On Wed, 25 Jan 2017, Peter Griffin wrote:
> > > > > On Tue, 24 Jan 2017, Lee Jones wrote:
> > > > > 
> > > > > > There are now 2 possible separate/different Pinctrl states which can
> > > > > > be provided from platform data.  One which encompasses the lines
> > > > > > required for HW flow-control (CTS/RTS) and another which does not
> > > > > > specify these lines, such that they can be used via GPIO mechanisms
> > > > > > for manually toggling (i.e. from a request by `stty`).
> > > > > > 
> > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > ---
> > > > > >  drivers/tty/serial/st-asc.c | 28 ++++++++++++++++++++++++++++
> > > > > >  1 file changed, 28 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> > > > > > index 397df50..03801ed 100644
> > > > > > --- a/drivers/tty/serial/st-asc.c
> > > > > > +++ b/drivers/tty/serial/st-asc.c

[...]

> > > > > > +		pinctrl_lookup_state(ascport->pinctrl, "manual-rts");
> > > > > > +	if (IS_ERR(ascport->states[MANUAL_RTS]))
> > > > > > +		ascport->states[MANUAL_RTS] = NULL;
> > > > > > +
> > > > > 
> > > > > The different pinctrl states looks like a neat solution to the problem.
> > > > > 
> > > > > My only concern here is that 'default' state is implying a hw-flow-control
> > > > > pinmux config, and manual-rts is implying what is the current upstream
> > > > > 'default' pinmux config.
> > > > > 
> > > > > Which maybe ok if you update all uarts, but currently only serial0
> > > > > is updated. So the other uarts current 'default' is actually the same as serial0
> > > > > 'manual-rts' grouping, which conceptually is odd.
> > > > > 
> > > > > Would it not be better to make 'manual-rts' the default state? As that aligns
> > > > > to what is currently already the default for the other UARTS? And then make
> > > > > hw-flow-control the optional state for serial0?
> > > > > 
> > > > > That also has the advantage that 'default' has the same meaning with older DT's.
> > > > 
> > > > The reason it was done is this was because none of the other UARTs
> > > > require 2 separate Pinctrl configurations, only this one.  Moreover,
> > > > if they support RTS/CTS then I believe that the lines should be
> > > > defined in Pinctrl.
> > > 
> > > Yes I agree with that.
> > > 
> > > > Thus, it was my plan to update all UART's default
> > > > Pinctrl configs to include the RTS/CTS lines.
> > > > 
> > > 
> > > I still don't see the point in changing the meaning of 'default' group and breaking
> > > ABI if you don't need to?
> > > 
> > > As far as I can tell if you swap the meaning of 'default' and 'maunal-rts'
> > > groups you get all the benefits of this series whilst also maintaining backwards
> > > compatbility with older DT's.
> > 
> > What makes you think this will break ABI?
> 
> I've not tried it, but an older DT defines one group, 'default' which contains
> the same pin config as your new optional 'manual-rts' group.
> 
> The driver now reads like the manual-rts pin config is optional and should be stored in
> ascport->states[MANUAL_RTS]. An older DT will pass that same pin config as the default
> group and it will be stored in ascport->states[DEFAULT].
> 
> That seems wrong to me, and if it executes OK it wouldn't be what you
> expect by reading the code.

This makes no sense at a functional level.

Old kernel, old DTB:

ASC driver doesn't understand Pinctrl, but since only the "default"
state is defined, that's what will be used as a matter of course.
RTS/CTS aren't configured, but that doesn't matter because the DTS
does not advertise that HW flow-control is available.  In this
use-case neither HW flow-control, nor manual toggling of the RTS line
is possible.

New kernel, old DTB:

ASC driver demands "default" and requests "manual-rts" Pinctrl states,
but "manual-rts" isn't available so "default" will be the only
utilised state.  Unlike the first example above, "default" now
contains the RTS and CTS lines, but since the DTS does not advertise
HW flow-control as available they will be harmlessly unused.  This
configuration culminates in the same result as the first example
i.e. no HW flow-control and no manual toggling.  However, there are no
detremental effects to the driver's functions. 

Old kernel, new DTB:

ASC doesn't understand Pinctrl, so the "default" state will be used,
meaning that all of the lines will be configured.  The DTB does
advertise HW flow-control as being available this time, but not in a
way that the old ASC driver understands.  Thus, just as in the two
preceding examples, HW flow-control and manual toggling of the RTS
line is not possible, but again the driver is otherwise fully
functional and doesn't suffer any ill effects from the RTS and CTS
lines being configured.

New kernel, new DTB:

ASC driver demands "default" and requests "manual-rts" Pinctrl
states.  If DTS advertises that HW flow-control is possible and the
client requests it, ASC will use the "default" state and HW
flow-control will commence.  If HW flow-control is not requested by
the client and "manual-rts" is available, then ASC will request the
RTS line is handled by GPIO until such times as the client requests
HW flow-control, at which point ASC will disable GPIO and request the
"default" state again.

It is not possible to read C-code and make assumptions that the DTB
will be in a particular state as you suggest.  No disparity ever
exists and the code is always clear IMHO.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
