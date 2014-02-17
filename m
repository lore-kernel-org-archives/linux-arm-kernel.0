From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Feb 2014 11:19:10 +0000
Subject: [PATCH v2] sched_clock: Prevent callers from seeing half-updated
 data
In-Reply-To: <20140210111435.GB17766@mudshark.cambridge.arm.com>
References: <1391806139-20116-1-git-send-email-sboyd@codeaurora.org>
 <1391812138-15492-1-git-send-email-sboyd@codeaurora.org>
 <20140210111435.GB17766@mudshark.cambridge.arm.com>
Message-ID: <20140217111910.GE26312@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:14:35AM +0000, Will Deacon wrote:
> On Fri, Feb 07, 2014 at 10:28:58PM +0000, Stephen Boyd wrote:
> > If two sched_clock sources are registered we may end up in a
> > situation where a call to sched_clock() may be accessing the
> > epoch cycle count for the old counter and the cycle count for the
> > new counter. This can lead to confusing results where
> > sched_clock() values jump and then are reset to 0 (due to the way
> > the registration function forces the epoch_ns to be 0). Fix this
> > by reorganizing the registration function to hold the seqlock for
> > as short a time as possible while we update the clock_data
> > structure for a new counter. We also put any accumulated time
> > into epoch_ns instead of resetting the time to 0 so that the clock
> > doesn't reset after each successful registration.
> > 
> > Reported-by: Will Deacon <will.deacon@arm.com>
> > Cc: Josh Cartwright <joshc@codeaurora.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > Changes since v1:
> >  * Put elapsed time into epoch_ns 
> 
> Well, this certainly fixes the dmesg prints and the system seems ok once
> it's booted:
> 
>   Tested-by: Will Deacon <will.deacon@arm.com>

Any chance of getting this merged please? I still see the weird timing
numbers when booting -rc3.

Cheers,

Will
