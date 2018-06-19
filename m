From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jun 2018 16:53:15 +0100
Subject: [PATCHv3 13/19] kernel: add ksys_personality()
In-Reply-To: <20180619154541.7uugqiquxzkcpfwj@armageddon.cambridge.arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-14-mark.rutland@arm.com>
 <20180619154541.7uugqiquxzkcpfwj@armageddon.cambridge.arm.com>
Message-ID: <20180619155314.lnqzwrnyz5pxwian@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 04:45:41PM +0100, Catalin Marinas wrote:
> On Mon, Jun 18, 2018 at 01:03:04PM +0100, Mark Rutland wrote:
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 73810808cdf2..14312d334345 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -80,6 +80,7 @@ union bpf_attr;
> >  #include <linux/unistd.h>
> >  #include <linux/quota.h>
> >  #include <linux/key.h>
> > +#include <linux/personality.h>
> >  #include <trace/syscall.h>
> >  
> >  #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
> > @@ -1277,4 +1278,14 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
> >  	return do_sys_truncate(pathname, length);
> >  }
> >  
> > +static inline unsigned int ksys_personality(unsigned int personality)
> > +{
> > +	unsigned int old = current->personality;
> > +
> > +	if (personality != 0xffffffff)
> > +		set_personality(personality);
> > +
> > +	return old;
> > +}
> > +
> >  #endif
> 
> It looks like this is identical to sys_personality() in
> kernel/exec_domain.c. Should you call ksys_personality() from there
> directly (a few lines saved)?

I had originally done so [1], but Christophe preferred that I open-code
the logic [2].

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20180514094640.27569-13-mark.rutland at arm.com
[2] https://lkml.kernel.org/r/20180514120756.GA11638 at infradead.org
