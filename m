From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Jun 2014 15:14:46 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <alpine.LFD.2.11.1406092254220.25775@knanqh.ubzr>
References: <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406081138070.25775@knanqh.ubzr>
 <7hsindq07l.fsf@paris.lan>
 <20140609222604.GA16889@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406092254220.25775@knanqh.ubzr>
Message-ID: <20140610141446.GA3519@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

Sorry, I can't stay away from this thread ;)

On Tue, Jun 10, 2014 at 12:25:47AM -0400, Nicolas Pitre wrote:
> On Mon, 9 Jun 2014, Lorenzo Pieralisi wrote:
> > 4) When I am talking about firmware I am talking about sequences that
> >    are very close to HW (disabling C bit, cleaning caches, exiting
> >    coherency). Erratas notwithstanding, they are being standardized at
> >    ARM the best we can. They might even end up being implemented in HW
> >    in the not so far future. I understand they are tricky, I understand
> >    they take lots of time to implement them and to debug them, what I
> >    want to say is that they are becoming standard and we _must_ reuse the
> >    same code for all ARM platforms. You can implement them in MCPM (see
> >    (1)) or in firmware (and please do not start painting me as firmware
> >    hugger here, I am referring to standard power down sequences that
> >    again, are very close to HW state machines 
> 
> That's where the disconnect lies.  On the one hand you say "I understand 
> they are tricky, I understand they take lots of time to implement them 
> and to debug them" and on the other hand you say "They might end up being 
> implemented in HW in the not so far future."  That simply makes no 
> economical sense at all!

It makes lots of sense, though not from a software maintainability
perspective. It would be nice if everything still looked like ARM7TDMI
but in the race for performance (vs power), hardware becomes more
complex and it's not just the CPU but adjacent parts like interconnects,
caches, asynchronous bridges, voltage shifters, memory controllers,
clocks/PLLs etc. Many of these are simply hidden from the high level OS
like Linux because the OS assumes certain configuration (e.g. access to
memory) and it's only the hardware itself that knows in what order they
can be turned on or off (when triggered explicitly by the OS or an
external event). Having an dedicated power controller (e.g. M-class
processor) to handle some of these is a rather flexible approach, other
bits require RTL (and usually impossible to update).

> When some operation is 1) tricky and takes time to debug, and 2) not 
> performance critical (no one is trying to get in and out of idle or 
> hibernation a billion times per second), then you should never ever put 
> such a thing in firmware, and hardware should be completely out of the 
> question!

I agree that things can go wrong (both in hardware and software, no
matter where it runs) but please don't think that such power
architecture has been specifically engineered to hide the hardware from
Linux. It's a necessity for complex systems and the optimal solution is
not always simplification (it's not just ARM+vendors doing this, just
look at the power model of modern x86 processors, hidden nicely from the
software behind a few registers while making things harder for scheduler
which cannot rely on a constant performance level; but it's a trade-off
they are happy to make).

> >    and more importantly if they
> >    HAVE to run in secure world that's the only solution we have unless you
> >    want to split race conditions between kernel and secure world).
> 
> If they HAVE to run in secure world then your secure world architecture 
> is simply misdesigned, period.  Someone must have ignored the economics 
> of modern software development to have come up with this.

That's the trade-off between software complexity and hardware cost,
gates, power consumption. You can do proper physical separation of the
secure services but this would require a separate CPU that is rarely
used and adds to the overall SoC cost. On large scale hardware
deployment, it's exactly economics that matter and these translate into
hardware cost. The software cost is irrelevant here, whether we like it
or not.

-- 
Catalin
