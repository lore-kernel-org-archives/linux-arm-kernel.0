From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 May 2013 11:52:54 +0100
Subject: [PATCH 3/3] ARM: cacheflush: add new iovec-based cache flushing
 system call
In-Reply-To: <20130327111210.GH801@MacBook-Pro.local>
References: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
 <1364235486-17738-4-git-send-email-will.deacon@arm.com>
 <20130327111210.GH801@MacBook-Pro.local>
Message-ID: <20130523105254.GE31543@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 11:12:11AM +0000, Catalin Marinas wrote:
> On Mon, Mar 25, 2013 at 06:18:06PM +0000, Will Deacon wrote:
> > +static inline int
> > +do_cache_op_iov(const struct iovec __user *uiov, unsigned long cnt, int flags)
> > +{
> > +	int i, ret = 0;
> > +	unsigned long len = cnt * sizeof(struct iovec);
> > +	struct iovec *iov = kmalloc(len, GFP_KERNEL);
> > +
> > +	if (iov == NULL) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	if (copy_from_user(iov, uiov, len)) {
> > +		ret = -EFAULT;
> > +		goto out_free;
> > +	}
> > +
> > +	for (i = 0; i < cnt; ++i) {
> > +		unsigned long start = (unsigned long __force)iov[i].iov_base;
> > +		unsigned long end = start + iov[i].iov_len;
> > +		ret = do_cache_op(start, end, flags);
> > +		if (ret)
> > +			break;
> > +	}
> 
> Could you use get_user() on struct iovec fields directly to avoid
> kmalloc? It would be slightly faster.

I just had a look at this, but the problem is that we want to know the
entire (combined) region size so that we may just decide to flush the entire
cache, rather than iterate over each region line-by-line. This requires
copying the whole iovec into kernel space up front, so that we can iterate
over the regions with iov_length.

Will
