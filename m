From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 13 Jul 2015 17:32:26 +0200
Subject: [PATCH 13/18] arm64: cmpxchg: avoid memory barrier on comparison
 failure
In-Reply-To: <20150713145225.GG2632@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-14-git-send-email-will.deacon@arm.com>
 <20150713102848.GX19282@twins.programming.kicks-ass.net>
 <20150713112226.GC2632@arm.com>
 <20150713133912.GZ19282@twins.programming.kicks-ass.net>
 <20150713145225.GG2632@arm.com>
Message-ID: <20150713153226.GA19282@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 03:52:25PM +0100, Will Deacon wrote:

> That's an interesting case, and I think it's also broken on Alpha and Power
> (which don't use this code). It's fun actually, because a failed cmpxchg
> on those architectures gives you the barrier *before* the cmpxchg, but not
> the one afterwards so it doesn't actually help here.
> 
> So there's three options afaict:
> 
>   (1) Document failed cmpxchg as having ACQUIRE semantics, and change this
>       patch (and propose changes for Alpha and Power).
> 
> -or-
> 
>   (2) Change pv_unhash to use fake dependency ordering across the hash.
> 
> -or-
> 
>   (3) Put down an smp_rmb() between the cmpxchg and pv_unhash
> 
> The first two sound horrible, so I'd err towards 3, particularly as this
> is x86-only code atm and I don't think it will have an effect there.

Right, I would definitely go for 3, but it does show there is code out
there :/
