From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 11:10:58 +0200
Subject: [PATCH v2 1/3] asm-generic/io.h: Implement generic
 {read,write}s*()
In-Reply-To: <53C05E4A.2030708@codeaurora.org>
References: <1405092672-18549-1-git-send-email-thierry.reding@gmail.com>
 <53C05E4A.2030708@codeaurora.org>
Message-ID: <20140714091057.GP2081@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 02:59:38PM -0700, Stephen Boyd wrote:
> On 07/11/14 08:31, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > This patch implements generic versions of readsb(), readsw(), readsl(),
> > readsq(), writesb(), writesw(), writesl() and writesq(). Variants of
> > these string functions for I/O accesses (ins*() and outs*() as well as
> > ioread*_rep() and iowrite*_rep()) are now implemented in terms of the
> > new functions.
> >
> > While at it, also make sure that any of the functions provided as
> > fallback for architectures that don't override them can't be overridden
> > subsequently.
> >
> > This is compile- and runtime-tested on 32-bit and 64-bit ARM and compile
> > tested on Microblaze, s390, SPARC and Xtensa. For ARC, Blackfin, Metag,
> > OpenRISC, Score and Unicore32 which also use asm-generic/io.h I couldn't
> > find or build a cross-compiler that would run on my system. But by code
> > inspection they shouldn't break with this patch.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> There isn't any mention of why we're doing this in the commit text. It
> looks like patch 2 and 3 sort of mention why.
> 
> I also wonder if it could be explained how this about turn is desired,
> given that patch b2656a138ab7 (asm-generic: io: remove {read,write}
> string functions, 2012-10-17) did the complete opposite. Can you please
> explain?

The reason behind this was that people have been told to migrate towards
using io{read,write}{8,16,32}_rep() because {read,write}s{b,w,l}() are
not as "portable". The only reason why the aren't portable is because no
generic versions of them existed. That's what this series originally
started out as.

Also, it's somewhat backwards (and inconsistent) to go through the io*()
functions when it's known up front that the device will always only be
memory-mapped and never I/O mapped. So with these patches going forward,
people should be using either {read,write}{,s}{b,w,l}() *or* their
io{read,write}{8,16,32}{,_rep}() counterparts, not mixing them.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/d0b35e5a/attachment-0001.sig>
