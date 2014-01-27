From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jan 2014 12:15:05 +0000
Subject: [PATCH v3] audit: Add generic compat syscall support
In-Reply-To: <52E5F56F.2030502@linaro.org>
References: <1384854235-6567-1-git-send-email-takahiro.akashi@linaro.org>
 <1389945795-4255-1-git-send-email-takahiro.akashi@linaro.org>
 <1389945795-4255-2-git-send-email-takahiro.akashi@linaro.org>
 <20140123145119.GE27520@arm.com> <52E5F56F.2030502@linaro.org>
Message-ID: <20140127121505.GD32608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 05:58:07AM +0000, AKASHI Takahiro wrote:
> Catalin and audit maintainers,
> 
> On 01/23/2014 11:51 PM, Catalin Marinas wrote:
> > On Fri, Jan 17, 2014 at 08:03:15AM +0000, AKASHI Takahiro wrote:
> >> diff --git a/lib/compat_audit.c b/lib/compat_audit.c
> >> new file mode 100644
> >> index 0000000..94f6480
> >> --- /dev/null
> >> +++ b/lib/compat_audit.c
> >> @@ -0,0 +1,51 @@
> >> +#include <linux/init.h>
> >> +#include <linux/types.h>
> >> +/* FIXME: this might be architecture dependent */
> >> +#include <asm/unistd_32.h>
> >
> > It most likely is architecture dependent.
> 
> I'm wondering what name is the most appropriate in this case.
> Most archictures have __NR_xyz definitions in "unistd_32.h",
> but arm64 doesn't have it, instead "unistd32." which contains
> only __SYSCALL(xyz, NO). Confusing?

I don't think we should introduce a new file (or at least it should be
named something containing "audit" to make it clearer).

> >> +int audit_classify_compat_syscall(int abi, unsigned syscall)
> >> +{
> >> +	switch (syscall) {
> >> +#ifdef __NR_open
> >> +	case __NR_open:
> >> +		return 2;
> >> +#endif
> >> +#ifdef __NR_openat
> >> +	case __NR_openat:
> >> +		return 3;
> >> +#endif
> >> +#ifdef __NR_socketcall
> >> +	case __NR_socketcall:
> >> +		return 4;
> >> +#endif
> >> +	case __NR_execve:
> >> +		return 5;
> >> +	default:
> >> +		return 1;
> >> +	}
> >> +}
> >
> > BTW, since they aren't many, you could get the arch code to define
> > __NR_compat_open etc. explicitly and use these. On arm64 we have a few
> > of these defined to avoid name collision in signal handling code.
> 
> Again, most architecture have their own unistd32.h for compat system calls,
> and use __NR_open-like naming.
> It's unlikely for these archs to migrate to "generic compat" auditing,
> but I believe that '__NR_open'-like naming is better because we may be able to avoid
> arch-specific changes even for future(?) syscall-related enhancements in audit.

My preference is as above, a few __NR_compat_* (just those required by
audit) defined in unistd.h but I'm not an audit maintainer.

-- 
Catalin
