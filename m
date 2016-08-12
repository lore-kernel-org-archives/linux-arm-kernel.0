From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 12 Aug 2016 18:44:16 -0300
Subject: [PATCH v2 2/2] kexec: extend kexec_file_load system call
In-Reply-To: <20160812081739.GB22218@350D>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956638-3589-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160812081739.GB22218@350D>
Message-ID: <1606244.4vNzhVNUBR@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Balbir,

Thank you for the review!

Am Freitag, 12 August 2016, 18:17:39 schrieb Balbir Singh:
> On Thu, Aug 11, 2016 at 08:03:58PM -0300, Thiago Jung Bauermann wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 3523bf62f328..847d9c31f428 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2656,6 +2656,7 @@ extern int do_pipe_flags(int *, int);
> > 
> >  	id(MODULE, kernel-module)		\
> >  	id(KEXEC_IMAGE, kexec-image)		\
> >  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
> > 
> > +	id(KEXEC_PARTIAL_DTB, kexec-partial-dtb)		\
> 
> The backspace is over-indented?

Indeed, I'll fix that. But to keep it aligned with the other backslashes, 
there would be no spaces between it and the final closing parenthesis. 
Either that, or reindent the other backslashes one more level. I think I 
prefer the former.
 
> > @@ -160,6 +180,55 @@ kimage_file_prepare_segments(struct kimage *image,
> > int kernel_fd, int initrd_fd,> 
> >  		image->initrd_buf_len = size;
> >  	
> >  	}
> > 
> > +	if (flags & KEXEC_FILE_EXTRA_FDS) {
> > +		int nr_fds, i;
> > +		size_t fdset_size;
> > +		char fdset_buf[MAX_FDSET_SIZE];
> 
> Do we really want this on the stack?  I presume the size is not large

It has 132 bytes. Would it be better to use kmalloc instead?

> > +		struct kexec_fdset *fdset = (struct kexec_fdset *) 
fdset_buf;
> > +
> > +		ret = copy_from_user(&nr_fds, ufdset, sizeof(int));
> > +		if (ret) {
> > +			ret = -EFAULT;
> > +			goto out;
> > +		}
> > +
> > +		if (nr_fds > KEXEC_SEGMENT_MAX) {
> 
> We need an nr_fds < 0 check as well

Indeed, I forgot to do that. I will add the check.

> > +			ret = -E2BIG;
> > +			goto out;
> > +		}
> > +
> > +		fdset_size = sizeof(struct kexec_fdset)
> > +				+ nr_fds * sizeof(struct kexec_file_fd);
> > +
> > +		ret = copy_from_user(fdset, ufdset, fdset_size);
> 
> Can the user change nr_fds between the two copy_from_users, ideally not,
> but we should validate it.

Good catch. I'll check if nr_fds == fdset->nr_fds and return with an error 
if they're different.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
