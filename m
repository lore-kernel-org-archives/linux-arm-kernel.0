From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 May 2013 15:15:25 -0700
Subject: [PATCH v2 0/3] clk: implement remuxing during set_rate
In-Reply-To: <5192A61E.5020605@imgtec.com>
References: <1366388904-13903-1-git-send-email-james.hogan@imgtec.com>
 <20130513195746.10068.92303@quantum>
 <CAAG0J991BCziPFddzBrx9vcwRxyRgcCd38A01uKXTDDK9xTnbQ@mail.gmail.com>
 <20130514165937.10068.18501@quantum> <5192A61E.5020605@imgtec.com>
Message-ID: <20130514221525.10068.86581@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting James Hogan (2013-05-14 14:01:18)
> Hi Mike,
> 
> On 14/05/13 17:59, Mike Turquette wrote:
> > Quoting James Hogan (2013-05-13 14:30:46)
> >> On 13 May 2013 20:57, Mike Turquette <mturquette@linaro.org> wrote:
> >>> One reason for this is the difficulty some have had with setting flags
> >>> from DT bindings.
> >>
> >> Could you elaborate on this? I've been adding flags to DT bindings for
> >> this sort of thing, but it feels a bit like it's in that grey area of
> >> not really describing the hardware itself. This information needs to
> >> be specified somehow though.
> >>
> > 
> > It depends on the flag.  A good example is the CLK_DIVIDER_ONE_BASED
> > flag which does describe the hardware.  It informs the binding that
> > indexing starts at 1, not 0, which is a valid part of the hardware
> > description.
> > 
> > However flags that deal with software policy do not belong on DT.
> > CLK_SET_RATE_PARENT certainly does not belong in the DT binding since
> > this is a pure Linux-ism.  Every binding just needs to be reviewed on a
> > case-by-case basis to make sure the flags are related only to the
> > hardware.
> 
> So given the desire to eliminate platform code, is there a particular
> way that these other flags can be specified instead of DT bindings?
> 

I haven't put too much thought into this.  There have been many
discussions lately about where to put configuration data, which would
include the "policy" flags.  Some folks have discussed using DT, but
keeping the config data separate from the hardware description data (one
thread I read called the idea "config tree").  Examples of this are
setting parents for mux clocks, or setting clock rates at boot-time.
This data is important, but it is a configuration of the hardware.  Not
a description of it.

Anyways it is a general problem, so I'm hoping someone will find a
general solution.  For now I've seen a couple instance of clock drivers
including clk-private.h to modify the flags at registration time, which
is beyond horrible.  But again those users may not have a better option,
short of a new clk_set_flags() function, which is also horrible.

Regards,
Mike

> Cheers
> James
