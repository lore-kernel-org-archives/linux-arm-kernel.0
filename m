From: paul@codesourcery.com (Paul Brook)
Date: Tue, 21 Feb 2012 01:24:22 +0000
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU
 platforms
In-Reply-To: <20120220194634.GK26840@n2100.arm.linux.org.uk>
References: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
 <20120220194634.GK26840@n2100.arm.linux.org.uk>
Message-ID: <201202210124.23028.paul@codesourcery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Feb 20, 2012 at 06:37:09PM +0000, Will Deacon wrote:
> > Commit 68b7f715 ("nommu: ptrace support") added definitions for
> > PT_TEXT_ADDR and friends, as well as adding ptrace support for reading
> > from these magic offsets.
> > 
> > Unfortunately, this has probably never worked, since ptrace_read_user
> > predicates reading on off < sizeof(struct user), returning -EOI
> > otherwise.
> > 
> > This patch moves the offset size check until after we have tried to
> > match it against either a magic value or an offset into pt_regs.
> 
> Does this actually get used?  The fact that it's been broken from day one
> and no one's raised the issue in 2.5 years suggests that it's dead code.

I suspect I submitted the original patch.  I don't remember the details, but 
it definitely worked at the time.   IIRC some other targets (m68k?) used an 
even less palatable hack.

This (or equivalent) is necessary to do any debugging on an mmu-less (i.e. 
uclinux) system.

Paul
