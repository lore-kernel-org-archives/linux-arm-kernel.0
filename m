From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 3 Oct 2015 11:12:31 +0100
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <560FA4B5.1040709@free.fr>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <560ED1FB.9010000@free.fr>
 <yw1xbncgluad.fsf@unicorn.mansr.com>
 <20151003103219.1e10bdeb@arm.com> <560FA4B5.1040709@free.fr>
Message-ID: <20151003111231.544ae8e2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 3 Oct 2015 11:49:41 +0200
Mason <slash.tmp@free.fr> wrote:

> On 03/10/2015 11:32, Marc Zyngier wrote:
> > On Sat, 3 Oct 2015 00:34:02 +0100
> > M?ns Rullg?rd wrote:
> >> Mason writes:
> >>
> >>> My port requires the TWD to function. So I'm using
> >>> select HAVE_ARM_TWD (no "if SMP") to have it work
> >>> even on MULTIPLATFORM UP configs.
> >>
> >> You could just let it use another timer in the non-smp case if you
> >> didn't have that weird aversion towards using my code.
> > 
> > I have no idea what your code does, but using the timer that is
> > integrated into the core (just like on any other A9 implementation)
> > feels like the right thing to do, unless the HW is too broken to use
> > TWD.
> > 
> > Another timer is a nice thing to have (it probably comes in handy for
> > suspend/resume, and it may have a much better resolution), but this
> > seems like icing on the cake at this point. Let's see the cake first.
> 
> Marc,
> 
> I have a quick question for you :-)
> 
> As I stated several months ago, my goal is to produce the simplest
> port possible, which is why I chose the TWD instead of platform
> timers. At one point, I was also considering the global timer.
> (I have a Cortex A9 MPCore.) But as far as I could tell, the
> code for the global timer does not handle CPU frequency changes
> (while smp_twd.c does), is that correct?

Indeed, I cannot see any code that does that in the GT driver. But if
you have an A9 MP, you probably want to stick to TWD, which gives you a
per-cpu timer instead of a global timer that will require IPIs to other
CPUs.

> AFAIU, TWD timers and global timer "tick" at the frequency of
> PERIPHCLK (which is CPUCLK/2 in my implementation). Therefore,
> code needs to be specifically written to handle cpufreq events.
> Is that a correct understanding?

I don't have the A9 TRM handy (nor the desire to read it on a
sunny Saturday morning), so I can't really tell. But yes, this is
likely to require some clock change handling.

	M.
-- 
Jazz is not dead. It just smells funny.
