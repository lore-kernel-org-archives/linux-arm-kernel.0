From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Mar 2017 11:52:27 +0000
Subject: [RFC PATCH v2 21/41] arm64/sve: Enable SVE on demand for userspace
In-Reply-To: <98bf1730-7579-d9f9-37c0-75ccfc29087b@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-22-git-send-email-Dave.Martin@arm.com>
 <20170322164809.GC19950@leverpostej>
 <20170323112404.GC3750@e103592.cambridge.arm.com>
 <98bf1730-7579-d9f9-37c0-75ccfc29087b@arm.com>
Message-ID: <20170323115227.GD9287@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 11:30:16AM +0000, Suzuki K Poulose wrote:
> On 23/03/17 11:24, Dave Martin wrote:
> >On Wed, Mar 22, 2017 at 04:48:10PM +0000, Mark Rutland wrote:

> >>>+	asm ("mrs %0, cpacr_el1" : "=r" (tmp));
> >>>+	asm volatile ("msr cpacr_el1, %0" :: "r" (tmp | (1 << 17)));

> >>Please also use {read,write}_sysreg(), e.g.
> >
> >TBH, I was confused about the status of these macros at the time I
> >wrote this code.
> >
> >The naming clash with the cpufeature functions is unfortunate.  In my
> >head these names all became associated with "do something behind the
> >scenes that may or may not really read the underlying system reg".
> >
> >Would it be reasonable to rename read_system_reg() to something more
> >different, like read_kernel_sysreg(), read_system_id(),
> >read_sanitised_id_reg(), etc.?
> 
> I agree. read_system_reg() is not quite obvious name given all the other
> similar names. We could go with either read_sanitised_id_reg() or read_system_safe_reg() ?

I think read_sanitised_id_reg() sounds best, since "safe" cound mean a
few things, and having "id" in the name makes it clear that it's not a
general purpose sysreg accessor.

Thanks,
Mark.
