From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Mar 2012 09:48:50 +0000
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CACVXFVNExXcU473=m5QLZXAhpNsC3WZHrFa-=HzGdjMEy3seDg@mail.gmail.com>
References: <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
 <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
 <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
 <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
 <20120127155454.GH2347@mudshark.cambridge.arm.com>
 <CACVXFVNExXcU473=m5QLZXAhpNsC3WZHrFa-=HzGdjMEy3seDg@mail.gmail.com>
Message-ID: <20120307094850.GB20673@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 02:49:46AM +0000, Ming Lei wrote:
> Hi Will,

Hello,

> On Fri, Jan 27, 2012 at 11:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Ok. Note that on ARM the PMU generates a standard IRQ (i.e. not an NMI) so
> > you may miss samples if they occur during critical kernel sections (and if
> > you look at a profile, spin_unlock_irqrestore will be quite high).
> 
> Also looks no any irq handler functions can be observed at a profile even
> though they may be run at a very high frequency.
> 
> So could we configure ARM PMU interrupt as FIQ to address the above issues?

I thought about that in the past but the problem is finding hardware which
allows this. It probably means that you need a second GIC which can route
interrupts onto the FIQ line into the CPU. Given that FIQ is usually claimed
for secure interrupts, there could also still be latency issues here.

A better (read: highly invasive) way to fix this is using interrupt
priorities at the distributor. You then have to hack the interrupt disabling
code so that it disables interrupts below a certain priority if they occur
during an IRQ-off section. The re-enabling code would then have to undo
those decisions and allow the interrupts to be serviced. Pretty nasty stuff.

Will
