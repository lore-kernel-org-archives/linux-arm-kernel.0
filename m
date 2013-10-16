From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 18:14:17 -0700
Subject: [PATCH v2 1/2] ARM: KVM: Yield CPU when vcpu executes a WFE
In-Reply-To: <1381253894-18114-2-git-send-email-marc.zyngier@arm.com>
References: <1381253894-18114-1-git-send-email-marc.zyngier@arm.com>
 <1381253894-18114-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131016011417.GA24837@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 06:38:13PM +0100, Marc Zyngier wrote:
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
> boost, allowing the lock to be released more quickly. Also, using
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT slightly improves the performance
> when the VM is severely overcommited.
> 
> Quick test to estimate the performance: hackbench 1 process 1000
> 
> 2xA15 host (baseline):	1.843s
> 
> 2xA15 guest w/o patch:	2.083s
> 4xA15 guest w/o patch:	80.212s
> 8xA15 guest w/o patch:	Could not be bothered to find out
> 
> 2xA15 guest w/ patch:	2.102s
> 4xA15 guest w/ patch:	3.205s
> 8xA15 guest w/ patch:	6.887s
> 
> So we go from a 40x degradation to 1.5x in the 2x overcommit case,
> which is vaguely more acceptable.
> 
Patch looks good, I can just apply it and add the other one I just send
as a reply if there are no objections.

Sorry for the long turn-around on this one.

-Christoffer
