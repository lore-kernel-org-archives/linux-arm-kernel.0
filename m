From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 8 Jun 2017 10:57:10 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170608084026.GB2244@mai>
References: <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
 <20170607152750.tksmyf5p3oajbsac@piout.net>
 <20170607210848.GJ2345@mai>
 <20170607231715.ns2vcxza2eexnzjs@piout.net>
 <20170608074236.62924f01@bbrezillon> <20170608074446.GM2345@mai>
 <20170608101334.4e60aa4c@bbrezillon> <20170608084026.GB2244@mai>
Message-ID: <20170608105710.54a551d8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Jun 2017 10:40:26 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> > > 
> > > Alexandre, Boris, have a look at https://www.spinics.net/lists/arm-kernel/msg572652.html
> > > 
> > > That will tell you the story.  
> > 
> > Then we're in a deadlock situation here. I'm tired of hearing this kind
> > of argument "DT is only supposed to describe HW, not configuration, bla
> > bla". The truth is, we already have plenty of bindings that do not
> > strictly describe HW.
> > 
> > A simple example: ECC configuration on NAND devices. This is clearly a
> > configuration thing, the NAND controller is usually able to support
> > several kind of strength+ECC-block-size config, but we are able to
> > overload this with the nand-ecc-xxx properties. Another example, still
> > MTD related: MTD partitions, this is purely a software configuration,
> > still we allow users to pass this information in the DT. You want
> > another one? What about the linux,code and linux,input-type properties
> > described here [1]?
> > 
> > So please, let's not use these "this is not decribing HW" or "this is
> > linux specific" arguments every time someone tries to encode something
> > that can be considered a configuration detail.
> > 
> > Let's be pragmatic. How you want to use your timer counter blocks (I'm
> > talking about atmel TCBs) is clearly board specific. Whether you want
> > to use the PIT for your clocksource or use one or 2 channels of a TCB
> > at a specific resolution is again board specific. We need a solution to
> > assign timer channels to a linux function, and I'm not convinced
> > passing this information through the command line makes much more sense
> > than specifying it in the DT (and it's definitely less intuitive, since
> > you have to reference something defined in the DT from the cmdline).
> > 
> > Now, in his review, Mark says:
> > 
> > "
> > To me it sounds like what we need is Linux infrastructure that allows
> > one to register a device as having both clockevent/clocksource
> > functionality.
> > 
> > That way, we can choose to do something sane at boot time, and if the
> > user really wants specific devices used in specific ways, they can
> > request that.
> > "
> > 
> > Does that mean that, after adding this "HW timer" infrastructure, we
> > would have a standard way to assign a function to a specific timer
> > block from the DT? How is this different from what I suggest below
> > (note the linux, prefix on my linux,timer-function property, which
> > clearly shows that this is Linux specific)?  
> 
> I like the 'chosen' approach with the nodes you are proposing below. Thanks for
> the constructive suggestion. The binding description matches perfectly what we
> are trying to achieve.

Actually, this is Alexandre who initially suggested the chosen
approach (I thought it was important to mention that ;-)).
