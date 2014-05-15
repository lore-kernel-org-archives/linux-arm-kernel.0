From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 May 2014 13:07:14 -0600
Subject: [PATCH 9/9] cgroup: use cgroup->self.refcnt for cgroup refcnting
In-Reply-To: <1399670015-23463-10-git-send-email-tj@kernel.org>
References: <1399670015-23463-1-git-send-email-tj@kernel.org>
 <1399670015-23463-10-git-send-email-tj@kernel.org>
Message-ID: <53751062.2050401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2014 03:13 PM, Tejun Heo wrote:
> Currently cgroup implements refcnting separately using atomic_t
> cgroup->refcnt.  The destruction paths of cgroup and css are rather
> complex and bear a lot of similiarities including the use of RCU and
> bouncing to a work item.
> 
> This patch makes cgroup use the refcnt of self css for refcnting
> instead of using its own.  This makes cgroup refcnting use css's
> percpu refcnt and share the destruction mechanism.
>...

In next-20150515, this patch causes silent boot failures on NVIDIA Tegra
ARM systems. There isn't even any earlyprintk. Reverting this one patch
solves this.

I was a bit surprised that cgroups would cause such an issue, but
looking at a normal kernel boot, I guess cgroup does get initialized
very early:

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct

Anyway, I'll try to track down what the problem is, but if someone
familiar with this patch could give it a look, that'd be very useful,
since I'm not at all familiar with this code or feature.
