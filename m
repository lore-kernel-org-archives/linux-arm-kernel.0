From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jul 2014 15:09:35 +0100
Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
In-Reply-To: <CAFdej004ma0xyzBHCmijx1r3iQFiWPRMLRgi20ryZDJz5iJZGw@mail.gmail.com>
References: <1403775963-9785-1-git-send-email-achandran@mvista.com>
 <CAFdej004ma0xyzBHCmijx1r3iQFiWPRMLRgi20ryZDJz5iJZGw@mail.gmail.com>
Message-ID: <20140730140935.GA8989@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 03:01:35PM +0100, Arun Chandran wrote:
> On Thu, Jun 26, 2014 at 3:16 PM, Arun Chandran <achandran@mvista.com> wrote:
> > Building a kernel with CPU_BIG_ENDIAN fails if there are stale objects
> > from a !CPU_BIG_ENDIAN build. Due to a missing FORCE prerequisite on an
> > if_changed rule in the VDSO Makefile, we attempt to link a stale LE
> > object into the new BE kernel. According to Documentation/kbuild/makefiles.txt
> > FORCE is required for if_changed rules, and forgetting it is a common mistake
> >
> > So fix it by 'Forcing' the build of vdso.  Fixes build errors like these:
> >
> > arch/arm64/kernel/vdso/note.o: compiled for a little endian system and target is big endian
> > failed to merge target specific data of file arch/arm64/kernel/vdso/note.o
> >
> > arch/arm64/kernel/vdso/sigreturn.o: compiled for a little endian system and target is big endian
> > failed to merge target specific data of file arch/arm64/kernel/vdso/sigreturn.o
> >
> > Signed-off-by: Arun Chandran <achandran@mvista.com>
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/arm64/kernel/vdso/Makefile |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > index 6d20b7d..a268a9a 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -43,7 +43,7 @@ $(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
> >         $(call if_changed,vdsosym)
> >
> >  # Assembly rules for the .S files
> > -$(obj-vdso): %.o: %.S
> > +$(obj-vdso): %.o: %.S FORCE
> >         $(call if_changed_dep,vdsoas)
> >
> >  # Actual build commands
> > --
> > 1.7.9.5
> >
> 
> Any update on this?

Sorry, this slipped through the cracks (neither myself or Catalin were on CC
and we didn't spot it on the list).

I've applied it to our for-next branch targetting 3.17 and will push out
after a bit of testing.

Will
