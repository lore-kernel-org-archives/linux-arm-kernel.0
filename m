From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Dec 2016 21:40:13 +0100
Subject: [PATCH 16/18] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
In-Reply-To: <20161207165913.GD31779@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161206062508.GA17835@yury-N73SV>
 <20161207165913.GD31779@e104818-lin.cambridge.arm.com>
Message-ID: <3703608.GKr1zzErMk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 7, 2016 4:59:13 PM CET Catalin Marinas wrote:
> On Tue, Dec 06, 2016 at 11:55:08AM +0530, Yury Norov wrote:
> > On Mon, Dec 05, 2016 at 04:34:23PM +0000, Catalin Marinas wrote:
> > > On Fri, Oct 21, 2016 at 11:33:15PM +0300, Yury Norov wrote:
> > > > New aarch32 ptrace syscall handler is introduced to avoid run-time
> > > > detection of the task type.
> > > 
> > > What's wrong with the run-time detection? If it's just to avoid a
> > > negligible overhead, I would rather keep the code simpler by avoiding
> > > duplicating the generic compat_sys_ptrace().
> > 
> > Nothing wrong. This is how Arnd asked me to do. You already asked this
> > question: http://lkml.iu.edu/hypermail/linux/kernel/1604.3/00930.html
> 
> Hmm, I completely forgot about this ;). There is still an advantage to
> doing run-time checking if we avoid touching core code (less acks to
> gather and less code duplication).
> 
> Let's see what Arnd says but the initial patch looked simpler.

I don't currently have either version of the patch in my inbox
(the archive is on a different machine), but in general I'd still
think it's best to avoid the runtime check for aarch64-ilp32
altogether. I'd have to look at the overall kernel source to
see if it's worth avoiding one or two instances though, or
if there are an overwhelming number of other checks that we
can't avoid at all.

Regarding ptrace, I notice that arch/tile doesn't even use
the compat entry point for its ilp32 user space on 64-bit
kernels, it just calls the regular 64-bit one. Would that
help here?

	Arnd
