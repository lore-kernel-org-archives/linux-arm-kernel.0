From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 14:34:13 +0000
Subject: [PATCH v2 1/7] timekeeping: introduce __current_kernel_time64
In-Reply-To: <20151110122201.GB17308@twins.programming.kicks-ass.net>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <1447156675-7418-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20151110122201.GB17308@twins.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.02.1511101429100.5676@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Nov 2015, Peter Zijlstra wrote:
> On Tue, Nov 10, 2015 at 11:57:49AM +0000, Stefano Stabellini wrote:
> > __current_kernel_time64 returns a struct timespec64, without taking the
> > xtime lock. Mirrors __current_kernel_time/current_kernel_time.
> 
> It always helps if you include a reason why you want a patch.

You are right, sorry.

I need to get the current_kernel_time from a pvclock_gtod callback
function, which cannot take the lock again.

On x86 we are just calling __current_kernel_time() (see
arch/x86/xen/time.c:xen_pvclock_gtod_notify). I was introducing the same
functionality on ARM, when the maintainers pointed out that it might be
better to use struct timespec64 and related functions for
future-proofness. To do that I need a version of __current_kernel_time
which returns a struct timespec64.
