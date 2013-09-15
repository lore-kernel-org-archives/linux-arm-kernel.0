From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 15 Sep 2013 20:57:01 +0200
Subject: mvneta: oops in __rcu_read_lock on mirabox
In-Reply-To: <CACzLR4tTvt+ROEhkXUCQhV6=bPPTX4LFSkWfrEhF+OdM1Jm1Rw@mail.gmail.com>
References: <CACzLR4tTvt+ROEhkXUCQhV6=bPPTX4LFSkWfrEhF+OdM1Jm1Rw@mail.gmail.com>
Message-ID: <20130915205701.5c61a444@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ethan,

On Sat, 14 Sep 2013 18:05:32 -0700, Ethan Tuttle wrote:
> When I upgraded my mirabox from 3.11-rc4 to 3.11, I started seeing
> oopses while receiving network traffic (see below).  Sending a flood
> ping will trigger the oops within a few minutes.
> 
> The stack looks similar, but not identical to, the one reported
> earlier by Jochen De Smet[1].  In my case the PC is always
> __rcu_read_lock.
> 
> A git bisect found a878764 "Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net" to be the
> first bad commit... interesting, because neither of the merge parents
> produce the oops.  I rebased the net changes onto the other merge
> parent and bisected that series, which identified 702821f "net: revert
> 8728c544a9c ("net: dev_pick_tx() fix")" as the first bad commit.
> Indeed, reverting 702821f from 3.11 produces a kernel which stands up
> to a ping flood for hours.
> 
> Each of the times I reproduced this, it was identified as "Unhandled
> prefetch abort: unknown 25 (0x409) at 0xc0036ea0", except once when I
> got "unknown 16 (0x400)".
> 
> I'm assuming this is an mvneta bug that was exposed by 702821f.
> That's just a guess, and I don't have the skills to debug this any
> further.  In any case, I figured the maintainers would want to know
> about it.

Thanks a lot for the report and the detailed investigation.
Unfortunately, I don't have Armada 370 hardware with me this week, so
I'm unable to test and reproduce the issue.

However, I've added a bunch of Armada 370 people/maintainers in Cc,
hopefully they can at least try to reproduce and confirm that reverting
this patch makes the problem go away, which would confirm that we
should look for a bug in the mvneta driver around this problem.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
