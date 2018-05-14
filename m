From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 May 2018 13:43:19 +0100
Subject: [PATCH 17/18] arm64: convert compat wrappers to C
In-Reply-To: <20180514121022.GB11638@infradead.org>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-18-mark.rutland@arm.com>
 <20180514121022.GB11638@infradead.org>
Message-ID: <20180514124318.pwmz63cduxibwfom@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 05:10:22AM -0700, Christoph Hellwig wrote:
> > +COMPAT_SYSCALL_DEFINE3(aarch32_statfs64, const char __user *, pathname,
> > +		       compat_size_t, sz, struct compat_statfs64 __user *, buf)
> > +{
> > +	if (sz == 88)
> > +		sz = 84;
> > +
> > +	return kcompat_sys_statfs64(pathname, sz, buf);
> 
> This really needs a comment, and it looks very obviously bogus.
> In case it isn't it needs a very good explanation.

Per arch/arm/kernel/sys_oabi-compat.c:

    struct statfs64 has extra padding with EABI growing its size from
    84 to 88.  This struct is now __attribute__((packed,aligned(4)))
    with a small assembly wrapper to force the sz argument to 84 if it is 88
    to avoid copying the extra padding over user space unexpecting it.

This is the behaviour for both EABI and OABI on 32-bit arm, and thus we
must do the same for compat (and have done since day one of arm64).

I'll add a comment.

Thanks,
Mark.
