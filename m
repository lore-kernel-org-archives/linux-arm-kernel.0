From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 6 Mar 2012 16:10:58 +0200
Subject: [PATCHv4 4/6] ARM: OMAP3+: PRM: Enable IO wake up
In-Reply-To: <4F5598E3.4050506@ti.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
 <1330701475-22576-5-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1203052001240.6649@utopia.booyaka.com>
 <4F55978C.7030407@ti.com>  <4F5598E3.4050506@ti.com>
Message-ID: <1331043058.2116.166.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-03-06 at 10:26 +0530, Rajendra Nayak wrote:
> On Tuesday 06 March 2012 10:20 AM, Rajendra Nayak wrote:
> > On Tuesday 06 March 2012 09:51 AM, Paul Walmsley wrote:
> >> added Rajendra, Nilesh, Vishwa, Mohan
> >>
> >> Hi
> >>
> >> On Fri, 2 Mar 2012, Tero Kristo wrote:
> >>
> >>> Enable IO Wake up for OMAP3/4 as part of PRM Init. Currently this has
> >>> been
> >>> managed in cpuidle path which is not the right place. Subsequent patch
> >>> will remove IO Daisy chain handling in cpuidle path once daisy chain is
> >>> handled as part of hwmod mux. This patch also moves the OMAP4 IO wakeup
> >>> enable code from the trigger function to init time setup.
> >>>
> >>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> >>
> >> Should we keep the I/O wakeups enabled all the time?
> >>
> >> Seems like that could result in at least one spurious wake-up event --
> >> and
> >> thus a PRCM interrupt -- for each I/O pad that has WAKEUPENABLE set.
> >> Seems like these interrupts could recur every time the I/O chain is
> >> reset.
> >> And that the I/O chain is now reset in every hwmod idle and enable
> >> operation for an IP block that contains dynamic mux data?
> >>
> >> Thinking about the problem na?vely... maybe you all can think through
> >> this
> >> with me:
> >>
> >> Consider an IP block 'A' that has a signal (like the UART rx_irrx signal)
> >> that's mux'ed to a pad with WAKEUPENABLE set. (Some examples of 'A' might
> >> include a UART, a GPIO, or a McBSP.)
> >>
> >> Shouldn't we enable I/O wakeups (by setting EN_IO/GLOBAL_WUEN) only
> >> immediately before the powerdomain containing IP block 'A' is going to
> >> transition into RETENTION or OFF?
> >
> > Hi Paul,
> >
> > I completely agree with your observations and we knew we would have
> > additional wakeups with this design. Like I mentioned in the other
> > thread, we went ahead with this approach knowing we need to optimize
> > with some kind of powerdomain level usecounting in the future, because
> > it didn't exist back then when we did it this way.
> > But now that we already have it, maybe we can fix this and do
> > it such that we completely avoid an additional wakeup interrupt.
> >
> >>
> >> If we do that, then we can avoid needlessly resetting the I/O chain
> >> when a
> >> powerdomain is not going to go into a low-power state.
> >>
> >> I haven't measured the time it takes for the I/O chain to be reset.
> >> Maybe one of you have. But that 100 microsecond timeout that was
> >> specified in two of the other patches in this series has me a little
> >> worried.
> >
> > I haven't profiled it myself but I am guessing the delay isn't much.
> 
> Having said that, I do agree with you that, however small the delay,
> we end up doing needless IO trigger when the powerdomain isn't
> really entering a low power state.

After some measurements (used ARM performance counters for this), it
looks like omap4 takes between 2...4us for the IO chain trigger. omap3
takes 7...8us, most of which appears to be delay caused by interconnect,
the poll loops don't actually have time to do anything. Speaking of
which, the trigger function was pretty broken for omap3 on this set, I
noticed that while doing the profiling. The fixed one takes this time,
I'll post a new version of the whole set shortly.

-Tero

> 
> > The 100us comes from the fact that there is no documentation on the
> > exact delay, so went around asking whats the *real worst case* delay,
> > and we got an answer, 100us should be really big enough :)
> >
> > regards,
> > Rajendra
> >
> >>
> >>
> >> - Paul
> >
> 
