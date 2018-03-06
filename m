From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Mar 2018 17:54:46 +0000
Subject: [RFC PATCH] arm64: fault: Don't populate ESR context for user
 fault on kernel VA
In-Reply-To: <20180306160553.GN32331@e103592.cambridge.arm.com>
References: <1520245875-32527-1-git-send-email-will.deacon@arm.com>
 <20180305140506.GJ32331@e103592.cambridge.arm.com>
 <20180305172418.GD12869@arm.com>
 <CAFEAcA9e1swOcYx5YCokSmb_37pyaJYJZTudt57babkngicutw@mail.gmail.com>
 <20180306160553.GN32331@e103592.cambridge.arm.com>
Message-ID: <20180306175446.GD19134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 04:05:53PM +0000, Dave Martin wrote:
> On Tue, Mar 06, 2018 at 03:59:59PM +0000, Peter Maydell wrote:
> > On 5 March 2018 at 17:24, Will Deacon <will.deacon@arm.com> wrote:
> > > On Mon, Mar 05, 2018 at 02:05:06PM +0000, Dave Martin wrote:
> > >> Does Debian's codesearch throw up any nontrivial users of esr_context?
> > >
> > > The main one seems to be ASAN, which uses the RnW bit to report "READ",
> > > "WRITE" or "UNKNOWN". So with this change, the access will be treated as
> > > UNKNOWN for kernel addresses.
> > >
> > > Whilst I can see how that might cause a testsuite regression, I'm struggling
> > > to see how it could sensible impact ASAN given that userspace never has
> > > permission to access these addresses and so the fault should be treated as
> > > fatal regardless of whether or not it's a read or a write.
> > 
> > Right, but the read/write/unknown classification also affects the
> > severity of that warning level ('scariness' in the asan code),
> > and it's not immediately clear how much might then in turn be relying
> > on that.
> > 
> > I think that if you have widely deployed code that is using this
> > ESR value, then it's kernel ABI that people are relying on, and
> > the safest thing to do is to make the minimal change that will
> > fix the problem you have, not to yank the whole thing entirely
> > and hope that the users will cope.
> > 
> > QEMU is not currently using the ESR value, but it would be nice to
> > in future, and it would certainly be irritating not to have the
> > WnR information just because the faulting address happens to be in
> > the top half of memory.
> > 
> > AFAIK the major thing that consumers actually are after here
> > is the WnR information, so preserving that and sanitizing
> > the rest of the ESR if necessary would be a less risky fix IMHO.
> 
> If there is a way of squashing the syndrome information so that it
> reports a fixed syndrome except for information about what userspace
> attempted to do (i.e., WnR -- I dunno if there's anything else), that
> seems reasonable.

I don't know how we can do that, and I'm deeply sceptical of claims that
the WnR bit matters at all for kernel addresses. Any change we make here
will be user visible but I don't think that means we shouldn't consider
changes for cases that are highly unlikely to cause problems. We'll
obviously revert anything that does causes issues, but that shouldn't
be the goal.

I'll try to reach out to the ASAN people to get their feedback on this.

If we do want to use a sanitised ESR value, then we need to do this within
the constraints of the architecture because Linux advertises this as the
ESR when it is provided. What encoding would you suggest? Should we report
all faults on kernel addresses as Translation fault level 0?

Will
