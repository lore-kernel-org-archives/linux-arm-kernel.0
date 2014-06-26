From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 26 Jun 2014 17:30:24 +0530
Subject: [PATCH] arm64: do not force irq affinity setting
In-Reply-To: <20140626102055.GD376@arm.com>
References: <1403765395-16978-1-git-send-email-pgaikwad@nvidia.com>
 <20140626102055.GD376@arm.com>
Message-ID: <1403784024.20406.4.camel@pgaikwad-dt2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-06-26 at 15:50 +0530, Will Deacon wrote:
> Hello,
> 
> On Thu, Jun 26, 2014 at 07:49:55AM +0100, Prashant Gaikwad wrote:
> > Unconditional copying cpu_online_mask to affinity
> > may result in migrating affinity to wrong CPU.
> 
> We have a bug, but I don't follow your reasoning.
> 
> > For example, IRQ 5 affinity mask contains CPU 4-7,
> 
> Ok, so d->affinity is 0xf0...
> 
> > it was affined to CPU4 and CPU 0-7 are online.
> 
> ...and cpu_online_mask is 0xff.
> 
> > Now if we hot-unplug CPU4 then with current
> > implementation affinity mask will contain
> > CPU 0-3,5-7 and IRQ 5 will be affined to CPU0.
> 
> cpumask_any_and(affinity, cpu_online_mask) will give return < nr_cpu_ids
> since there is an intersection of 0xf0. That means ret is false.
> 
> The bug is that we then do affinity = cpu_online_mask; unconditionally,
> but we *won't* do the cpumask_copy, since ret is false.
> 

We do not copy but the affinity mask passed to irq_set_affinity function
is nothing but cpu_online_mask. So in GIC it will set affinity to CPU0.

> You can fix this by simply bringing the arm64 code into line with the arm
> code, which begs the question as to why this has to exist in the arch/
> backend at all!

Where can we move this code?

> 
> Will
