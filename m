From: agraf@suse.de (Alexander Graf)
Date: Mon, 7 Oct 2013 18:04:33 +0200
Subject: [PATCH 1/2] ARM: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <1381160430-11790-2-git-send-email-marc.zyngier@arm.com>
References: <1381160430-11790-1-git-send-email-marc.zyngier@arm.com>
 <1381160430-11790-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <52F72A87-9CC3-4B38-ACDA-F5EA66FA7375@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07.10.2013, at 17:40, Marc Zyngier <marc.zyngier@arm.com> wrote:

> On an (even slightly) oversubscribed system, spinlocks are quickly
> becoming a bottleneck, as some vcpus are spinning, waiting for a
> lock to be released, while the vcpu holding the lock may not be
> running at all.
> 
> This creates contention, and the observed slowdown is 40x for
> hackbench. No, this isn't a typo.
> 
> The solution is to trap blocking WFEs and tell KVM that we're
> now spinning. This ensures that other vpus will get a scheduling
> boost, allowing the lock to be released more quickly.
> 
>> From a performance point of view: hackbench 1 process 1000
> 
> 2xA15 host (baseline):	1.843s
> 
> 2xA15 guest w/o patch:	2.083s
> 4xA15 guest w/o patch:	80.212s
> 
> 2xA15 guest w/ patch:	2.072s
> 4xA15 guest w/ patch:	3.202s

I'm confused. You got from 2.083s when not exiting on spin locks to 2.072 when exiting on _every_ spin lock that didn't immediately succeed. I would've expected to second number to be worse rather than better. I assume it's within jitter, I'm still puzzled why you don't see any significant drop in performance.


Alex
