From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Mar 2015 18:02:29 +0000
Subject: [PATCH] arm64: percpu: Make this_cpu accessors pre-empt safe
In-Reply-To: <20150319163955.GG25967@leverpostej>
References: <1426776751-20526-1-git-send-email-steve.capper@linaro.org>
 <20150319154435.GC25967@leverpostej>
 <20150319160008.GA4751@arm.com>
 <20150319161143.GE25967@leverpostej>
 <20150319162753.GC4751@arm.com>
 <20150319163955.GG25967@leverpostej>
Message-ID: <20150320180228.GI1474@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 04:39:55PM +0000, Mark Rutland wrote:
> On Thu, Mar 19, 2015 at 04:27:53PM +0000, Will Deacon wrote:
> >   (3) Preemption isn't actually an issue here -- CPU migration is. I'd
> >       expect that to be a lot rarer.
> 
> That's not true: in a read-modify-cmpxchg loop (even on a UP system) if
> you get preempted at the end of the read and another thread modifies
> your datastructure, then your subsequent cmpxchg will fail. So any
> preemption could cause you to have to retry, so you want to miminise
> potential preemptions.
> 
> Note that this is a performance argument rather than a correctness
> argument.

My argument is more that a migration will always break the cmpxchg, whereas
preemption doesn't necessarily.

Steve -- can you respin this using preempt_enable everywhere please?

Will
