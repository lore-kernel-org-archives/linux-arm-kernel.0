From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Oct 2016 23:52:56 +0200
Subject: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
In-Reply-To: <20161029214541.GA20037@yury-N73SV>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
 <2502005.4risrb1P1I@wuerfel> <20161029214541.GA20037@yury-N73SV>
Message-ID: <5026984.UigzJE9bBY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, October 30, 2016 12:45:41 AM CEST Yury Norov wrote:
> On Sat, Oct 29, 2016 at 11:02:40PM +0200, Arnd Bergmann wrote:
> > On Saturday, October 22, 2016 3:14:04 PM CEST Yury Norov wrote:
> > > The newer prlimit64 syscall provides all the functionality provided by
> > > the getrlimit and setrlimit syscalls and adds the pid of target process,
> > > so future architectures won't need to include getrlimit and setrlimit.
> > > 
> > > Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> > > list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> > > unistd.h prior to including asm-generic/unistd.h, and adjust all
> > > architectures using the generic syscall list to define it so that no
> > > in-tree architectures are affected.
> > 
> > The patch looks good, but shouldn't we also hide the actual syscall
> > implementation if the symbol is not set? It's just dead code otherwise
> > for new architectures.
> 
> I was thinking on it. The patch of James Hogan, b0da6d4415 (asm-generic:
> Drop renameat syscall from default list) doesn't do it for renameat(), so
> I decided not to do it too. It's not so easy to disable syscalls because arch
> may support few ABIs, and some of them may require the syscall. For example,
> arm64 supports lp64, aarch32 and ilp32, and first two ABIs need renameat()
> and getrlimit/setrlimit.
> 
> At now there's no arches that doesn't need renameat() and getrlimit/setrlimit,
> and there will be no such arch in nearest future. So there will be no
> dead code.
> 
> But I agree with you that we need make that implementations 
> conditional. If I understand it correctly, we need something like
> __ARCH_WANT_SET_GET_RLIMIT in all existing Kconfigs, correct?
> 
> I think this patch may be applied as is, and if needed I can send
> another patch that disables renameat() and getrlimit/setrlimit soon.

Fair enough. Actually now that I think about it, there are probably
lots of other syscalls that are unused on modern architectures.

It would be good to go through the full list and hide all the ones
that are not referenced, but that is clearly independent of your
patch.

	Arnd
