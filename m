From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 17 May 2016 22:05:26 +0300
Subject: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
In-Reply-To: <20160516170605.GB19290@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
 <20160514150352.GA30533@yury-N73SV>
 <20160516170605.GB19290@e104818-lin.cambridge.arm.com>
Message-ID: <20160517190526.GA3731@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 06:06:05PM +0100, Catalin Marinas wrote:
> On Sat, May 14, 2016 at 06:03:52PM +0300, Yury Norov wrote:
> > +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> > +       unsigned long, prot, unsigned long, flags, unsigned long, fd,
> > +       unsigned long, pgoff)
> 
> To avoid the types confusion we could add __SC_WRAP to mmap2 in unistd.h
> and use COMPAT_SYSCALL_DEFINE6 here (together with compat_ptr_t etc.).
> 
> > +{
> > +       if (pgoff & (~PAGE_MASK >> 12))
> > +               return -EINVAL;
> > +
> > +       return sys_mmap_pgoff((compat_uptr_t) addr, (compat_size_t) len,
> > +		       (int) prot, (int) flags, (int) fd,
> > +		       pgoff >> (PAGE_SHIFT-12));
> 
> Then we wouldn't need the explicit casting here.

See below

> 
> > +}
> > +
> > +COMPAT_SYSCALL_DEFINE4(pread64, unsigned int, fd, compat_uptr_t __user *, ubuf,
> > +		       compat_size_t, count, off_t, offset)
> > +{
> > +	return sys_pread64(fd, (char *) ubuf, count, offset);
> > +}
> > +
> > +COMPAT_SYSCALL_DEFINE4(pwrite64, unsigned int, fd, compat_uptr_t __user *, ubuf,
> > +		       compat_size_t, count, off_t, offset)
> > +{
> > +	return sys_pwrite64(fd, (char *) ubuf, count, offset);
> 
> Nitpick: no space between cast type and variable name: (char *)ubuf, ...

I think it's really a matter of taste. I prefer to have a space, and
there's no solid rule in coding style.

And there are 13032 insertions of my version vs 35030 of yours:
~/work/linux$ git grep ' \*)[a-zA-Z]'|wc -l
35030
~/work/linux$ git grep ' \*) [a-zA-Z]'|wc -l
13032

Of course, I will change it if you insist.

> We can also make these functions static as they are not used outside
> this file.

If it's OK, we can use just compat_sys_xxx() instead of
COMPAT_SYSCALL_DEFINEx(xxx), and for mmap2 we'll not need to change 
_SYSCALL to _SC_WRAP in unistd.h that way.

> > -- 
> Catalin
