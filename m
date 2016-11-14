From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 14 Nov 2016 10:40:08 -0500
Subject: [PATCH] ARM: ftrace: fix syscall name matching
In-Reply-To: <20161114134017.GJ1041@n2100.armlinux.org.uk>
References: <1479128625-20948-1-git-send-email-rabin.vincent@axis.com>
 <20161114134017.GJ1041@n2100.armlinux.org.uk>
Message-ID: <20161114104008.36e9c40d@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Nov 2016 13:40:17 +0000
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Mon, Nov 14, 2016 at 02:03:45PM +0100, Rabin Vincent wrote:
> > From: Rabin Vincent <rabinv@axis.com>
> > 
> > ARM has a few system calls (most notably mmap) for which the names of
> > the functions which are referenced in the syscall table do not match the
> > names of the syscall tracepoints.  As a consequence of this, these
> > tracepoints are not made available.  Implement
> > arch_syscall_match_sym_name to fix this and allow tracing even these
> > system calls.
> > 
> > Signed-off-by: Rabin Vincent <rabinv@axis.com>
> > ---
> >  arch/arm/include/asm/ftrace.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> > index bfe2a2f..8467909 100644
> > --- a/arch/arm/include/asm/ftrace.h
> > +++ b/arch/arm/include/asm/ftrace.h
> > @@ -54,6 +54,27 @@ static inline void *return_address(unsigned int level)
> >  
> >  #define ftrace_return_address(n) return_address(n)
> >  
> > +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> > +
> > +static inline bool arch_syscall_match_sym_name(const char *sym,
> > +					       const char *name)
> > +{
> > +	/* Skip sys_ */
> > +	sym += 4;
> > +	name += 4;  
> 
> Is this really safe?  What guarantees that we can wind forward four
> bytes here?  If it's always safe, it needs a better comment than just
> two words.

I believe it is, but a comment would do well.

The "sym" comes from kallsyms_lookup(syscall-address...)

Which it becomes the syscall function. Mostly defined by:

 include/linux/syscalls.h:

#define SYSCALL_DEFINEx(x, name)
	asmlinkage long sys_##name(...)

But there are cases that archs can define their own system calls
outside of this method. But then again, those system calls wont have
tracepoints attached to them, and they wont be called with this
function.

The "name" part comes from the system call tracepoint.

#define SYSCALL_METADATA(sname, ...)
	static struct syscall_metadata
	  __syscall_meta_##sname = {
		.name		= "sys"#sname,


It too appends the "sys" to the name. Note, sname here is called with
appending "_" to name, so the .name will start with "sys_" as well.

I'm guessing that there's an issue if more than one function name is
used for the same function, that is, the symbol maps to the same IP.
Then kallsyms_lookup() can return different function names for the same
function being called, and I'm guessing that's what this is trying to
fix.

-- Steve

> 
> > +
> > +	if (!strcmp(sym, "mmap2"))
> > +		sym = "mmap_pgoff";
> > +	else if (!strcmp(sym, "statfs64_wrapper"))
> > +		sym = "statfs64";
> > +	else if (!strcmp(sym, "fstatfs64_wrapper"))
> > +		sym = "fstatfs64";
> > +	else if (!strcmp(sym, "arm_fadvise64_64"))
> > +		sym = "fadvise64_64";
> > +
> > +	return !strcmp(sym, name);
> > +}
> > +
> >  #endif /* ifndef __ASSEMBLY__ */
> >  
> >  #endif /* _ASM_ARM_FTRACE */
> > -- 
> > 2.1.4
> >   
> 
