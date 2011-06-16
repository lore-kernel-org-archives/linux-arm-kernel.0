From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 16 Jun 2011 11:34:10 +0100
Subject: [RFC PATCH v2 0/5] Add generic macros for declaring various CPU
	structs
In-Reply-To: <20110616101536.GA32629@n2100.arm.linux.org.uk>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
	<20110616101241.GA4028@e102144-lin.cambridge.arm.com>
	<20110616101536.GA32629@n2100.arm.linux.org.uk>
Message-ID: <20110616103409.GB2460@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 11:15:36AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 16, 2011 at 11:12:41AM +0100, Will Deacon wrote:
> > >  * For consistency, I've renamed the arch/CPU name string labels.
> > >    If that is seen as unnecessary churn, it can be undone.
> > 
> > I don't see the win here, so let's leave the names like they are to avoid
> > unnecessary conflicts with other patches dealing with proc_info structs.
> 
> One of the issues is that there are proc-* files which use the same
> strings for several entries, for example, proc-xscale.S.
> 
> In general, the ELF name and arch name should be the same across all,
> just the CPU name should differ.

Hmmm, that explains why those strings were declared a bit differently.

A few of possible solutions to this:

1) Keep my macros as they are, but use a couple of #defines to make sure
	that arch_name and cpu_name are the same everywhere in a given
	proc-*.S file. Each cpu will get its own symbol for each of these
	strings, but the strings will be merged by the linker and so won't
	be duplicated in the kernel image.

2) Split define_proc_names into two macros, say, define_arch_names and
	define_cpu_name.  define_arch_names would be used once in the
	file.

3) Define a generic macro to define a string.  That would help automate
	string declarations, but really it would no longer be arch-
	specific and could live outside arch/arm.

4) Get rid of the define_proc_names macro altogether, and declare those
	things in the existing way.

Any view on these approaches?

Cheers
---Dave
