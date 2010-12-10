From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 10 Dec 2010 11:08:24 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
References: <20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291851079-27061-1-git-send-email-venki@google.com>
	<1291899120.29292.7.camel@twins>
	<AANLkTikd3X4pLs5De-LO6=XD+JqUz3-Ku7YM8+0-oK8t@mail.gmail.com>
	<1291917330.6803.7.camel@twins>
	<AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
	<1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
	<AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
Message-ID: <1291975704.6803.59.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-12-09 at 15:35 -0800, Venkatesh Pallipadi wrote:
> 
> Just to make sure, update_rq_clock() always gets called on current
> CPU. Right? 

No, specifically not. If that were the case we wouldn't need the
cross-cpu synced timestamp. Things like load-balancing and
remote-wakeups need to update a remote CPUs clock.

> The pending patches I have optimizes
> account_system_vtime() to use this_cpu_write and friends. Want to make
> sure this change will still keep that optimization relevant.

Ah, good point, remote CPUs updating that will mess with the consistency
of the per-cpu timestamps due to non atomic updates :/

Bugger.. making them atomics will make it even more expensive. /me goes
ponder.
