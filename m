From: rabin@rab.in (Rabin Vincent)
Date: Tue, 23 Feb 2010 23:53:38 +0530
Subject: [PATCH 07/10] ftrace: pass KBUILD_CFLAGS to record_mcount.pl
In-Reply-To: <1266931846.19540.9.camel@frodo>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-8-git-send-email-rabin@rab.in>
	<1266931846.19540.9.camel@frodo>
Message-ID: <20100223182338.GC5836@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 08:30:46AM -0500, Steven Rostedt wrote:
> On Sun, 2010-02-14 at 01:18 +0530, Rabin Vincent wrote:
> > On ARM, we have two ABIs, and the ABI used is controlled via a config
> > option.  Object files built with one ABI can't be merged with object
> > files built with the other ABI.  So, record_mcount.pl needs to use the
> > same compiler flags as the kernel when generating the object file with
> > the mcount locations.  Ensure this by passing CFLAGS to the script.
> 
> I'm fine with this for now, but I'm wondering if we should pass the
> autoconf.h to the script and parse that instead. This would give us all
> set config options that we can look at.

The correct ABI options are constructed using cc-option and friends, and
that logic would need to be duplicated in recordmcount.pl if we had to
parse autoconf.h.

I originally tried to add a new RECORDMCOUNT_CFLAGS variable in the ARM
Makefile and have that used here instead of KBUILD_CFLAGS (since
KBUILD_CFLAGS includes a whole bunch of possibly irrelevant options),
but coudn't figure out why my new variable wasn't accessible in
Makefile.build.

> 
> But I need to go back and start looking at converting recordmcount.pl to
> recordmcount.c again.
> 
> > 
> > Signed-off-by: Rabin Vincent <rabin@rab.in>
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
> 
> Doesn't this need to be with the change of recordmcount.pl too?
> Otherwise applying this patch alone will break it. We need every step of
> the patches to work otherwise we risk breaking a kernel bisect.

Dynamic ftrace for ARM is only enabled in the last patch of the series,
so this woudn't be breaking it.  No modification should be required for
record_mcount.pl for other archs because this doesn't add/remove any
parameters.

Rabin
