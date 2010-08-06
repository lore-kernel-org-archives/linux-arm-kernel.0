From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 06 Aug 2010 16:23:18 -0400
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <20100803164247.GA6133@debian>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-8-git-send-email-rabin@rab.in>
	<20100803164247.GA6133@debian>
Message-ID: <1281126198.3352.6.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the late reply, just got back from vacation.

On Tue, 2010-08-03 at 22:12 +0530, Rabin Vincent wrote:
> Steven, Frederic,
> 
> I'd like to resurrect this old ARM dynamic ftrace patchset.  It still
> applies on next except for a small merge conflict in one of the
> ARM-specific patches.
> 
> On Sat, Mar 13, 2010 at 12:19:44PM +0530, Rabin Vincent wrote:
> > On ARM, we have two ABIs, and the ABI used is controlled via a config
> > option.  Object files built with one ABI can't be merged with object
> > files built with the other ABI.  So, record_mcount.pl needs to use the
> > same compiler flags as the kernel when generating the object file with
> > the mcount locations.  Ensure this by passing CFLAGS to the script.
> > 
> > Signed-off-by: Rabin Vincent <rabin@rab.in>
> 
> This is the only non-arch/arm/ patch in the series which doesn't have
> either of your Acked-bys, so if you'd be willing to ack it, I'll send in
> the lot via rmk's ARM patch system for .37.
> 
> Alternatively, this one and "[PATCH 03/10] ftrace: allow building
> without frame pointers" could go in via the tracing tree for .36?  Then
> I'll send in the ARM specific stuff for .37 via the ARM tree.
> 
> Thanks,
> Rabin
> 
> > ---
> >  scripts/Makefile.build |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 0b94d2f..2535c11 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -209,7 +209,8 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
> >  cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
> >  	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
> >  	"$(if $(CONFIG_64BIT),64,32)" \
> > -	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
> > +	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CFLAGS)" \
> > +	"$(LD)" "$(NM)" "$(RM)" "$(MV)" \

Hmm, this changes the number of parameters passed to the
recordmcount.pl. shouldn't this be part of the change to
recordmcount.pl? Otherwise, we can break a bisect.

-- Steve

> >  	"$(if $(part-of-module),1,0)" "$(@)";
> >  endif
> >  
> > -- 
> > 1.7.0
> > 
