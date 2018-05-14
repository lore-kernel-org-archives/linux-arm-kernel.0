From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Mon, 14 May 2018 22:34:14 +0200
Subject: [PATCH 13/18] kernel: add kcompat_sys_{f,}statfs64()
In-Reply-To: <20180514171427.qyietn3fhilwokb2@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-14-mark.rutland@arm.com>
 <20180514171427.qyietn3fhilwokb2@lakrids.cambridge.arm.com>
Message-ID: <20180514203414.GB26773@light.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 06:14:28PM +0100, Mark Rutland wrote:
> On Mon, May 14, 2018 at 10:46:35AM +0100, Mark Rutland wrote:
> > Using this helper allows us to avoid the in-kernel calls to the
> > compat_sys_{f,}statfs64() sycalls, as are necessary for parameter
> > mangling in arm64's compat handling.
> > 
> > Following the example of ksys_* functions, kcompat_sys_* functions are
> > intended to be a drop-in replacement for their compat_sys_*
> > counterparts, with the same calling convention.
> > 
> > This is necessary to enable conversion of arm64's syscall handling to
> > use pt_regs wrappers.
> 
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 6723ea51ec99..e0bf3e4bb897 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -59,6 +59,7 @@ struct tms;
> >  struct utimbuf;
> >  struct mq_attr;
> >  struct compat_stat;
> > +struct compat_statfs64;
> >  struct compat_timeval;
> >  struct robust_list_head;
> >  struct getcpu_cache;
> > @@ -1150,6 +1151,13 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
> >  ssize_t ksys_readahead(int fd, loff_t offset, size_t count);
> >  unsigned int ksys_personality(unsigned int personality);
> >  
> > +#ifdef CONFIG_COMPAT
> > +int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz,
> > +		     struct compat_statfs64 __user * buf);
> > +int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
> > +			  struct compat_statfs64 __user * buf);
> > +#endif
> 
> I've moved these to <linux/compat.h>, so that they live with the rest of
> the compat syscall stuff. That should avoid build failures the kbuild
> test robot picked up where compat_size_t wasn't dfined.

Please add a comment there, similar to what is in syscalls.h:

	/*
	 * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
	 * Instead, use one of the functions which work equivalently, such as
	 * the ksys_xyzyyz() functions prototyped below.
	 */

Once you have done so, feel free to add my

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

tag to this patch.

Thanks,
	Dominik
