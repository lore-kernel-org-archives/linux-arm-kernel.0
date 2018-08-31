From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Aug 2018 10:54:18 +0100
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
 <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
Message-ID: <20180831095417.GF13166@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 06:04:12PM -0700, Linus Torvalds wrote:
> On Thu, Aug 30, 2018 at 6:01 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Well it would help if powerpc say wanted to start using them without a
> > merge cycle lag. Not a huge issue because powerpc already does
> > reasonably well here and there's other work that can be done.
> 
> Sure. If somebody wants to send the generic changes I can just take
> them directly to make it easier for people to work on this.

Tell you what: how about I stick the following patches (with Nick's and
Peter's acks) on a separate, stable branch:

  asm-generic/tlb: Track which levels of the page tables have been cleared
  asm-generic/tlb: Track freeing of page-table directories in struct mmu_gather
  asm-generic/tlb: Guard with #ifdef CONFIG_MMU

and then anybody who needs them can just pull that in for the merge window?

Also, how would people feel about adding a MAINTAINERS entry for all the
tlb.h files? A big part of the recent "fun" was us figuring out what the
code is actually doing ("It used to do foo() but that may have changed").
and it certainly took me the best part of a day to figure things out again.
If we're trying to do more in the generic code and less in the arch code,
it would help if we're on top of the changes in this area.

Proposal below (omitted Linus because that seems to be the pattern elsewhere
in the file and he's not going to shout at himself when things break :)
Anybody I've missed?

Will

--->8

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..7224b5618883 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9681,6 +9681,15 @@ S:	Maintained
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
 
+MMU GATHER AND TLB INVALIDATION
+M:	Will Deacon <will.deacon@arm.com>
+M:	Nick Piggin <npiggin@gmail.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+L:	linux-arch at vger.kernel.org
+S:	Maintained
+F:	include/asm-generic/tlb.h
+F:	arch/*/include/asm/tlb.h
+
 MN88472 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media at vger.kernel.org
