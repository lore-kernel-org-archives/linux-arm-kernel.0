From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2009 21:09:15 +0000
Subject: [PATCH 1/4] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <000301ca7a85$e38e18e0$aaaa4aa0$@deacon@arm.com>
References: <20091211154147.GA17176@wear.picochip.com>
	<000301ca7a85$e38e18e0$aaaa4aa0$@deacon@arm.com>
Message-ID: <20091211210915.GB12628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 05:17:59PM -0000, Will Deacon wrote:
> That looks good to me. This allows SMP systems to set the affinity of the
> PMU IRQs too if need be - or should this also be done here? It might also
> be worth making the returned struct const to stop people poking, but I'm
> not sure.
> 
> I've got some oprofile patches which I hope to post soon - I'll put a
> note in the covering letter to say they should be modified to use these
> PMU functions when they make it in.

Well, I don't think that it makes sense to change the affinity of PMU
IRQs that much - if you route the CPUs own PMU interrupts to another
CPU, then how do you do things such as a backtrace?  You can't because
you don't know where the owner CPU actually is.

This is why oprofile ensures that the CPUs own PMU interrupts are routed
to that CPU - routing them elsewhere makes no sense for oprofile.
