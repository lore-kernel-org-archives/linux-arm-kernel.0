From: nfortino@nvidia.com (Nickolas Fortino)
Date: Wed, 17 Jul 2013 14:03:34 -0700
Subject: preempted dup_mm misses TLB invalidate
In-Reply-To: <20130717203409.GU24642@n2100.arm.linux.org.uk>
References: <51E43D2B.9090709@nvidia.com>
 <20130717192746.GE16496@MacBook-Pro.local> <51E6F60D.6060804@wwwdotorg.org>
 <51E6FA10.5070504@nvidia.com> <20130717203409.GU24642@n2100.arm.linux.org.uk>
Message-ID: <51E706A6.4040309@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/17/2013 1:34 PM, Russell King - ARM Linux wrote:
> Even if you stopped all threads on entry to a fork, the same problem
> exists - at the point that you stopped the other threads, how do you know
> what data they've written to memory?
>
> What I'm pointing out here is that in this situation, the data visible to
> the child process is unpredictable.

I agree the data visible to the child process is inherently 
unpredictable. If you stop all process threads on a fork, however, you 
do preserve the invariant that memory accesses are not seen out of 
order. In your memcopy case, it is indeterminate how much of the memcopy 
has completed, but it is known that later pages in the memcopy will only 
have been written if prior pages have been updated.

With the current kernel configuration, you can have holes. Any page 
which hits in the TLB has the memcopy data appear in the forked process. 
Any page which misses in the TLB will not appear in the forked process. 
The choice of which pages get memcopy data in the forked process will 
appear random based on TLB contents, a behavior you cannot have if you 
freeze threads on a fork.
