From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Sep 2015 16:37:28 +0100
Subject: [PATCH] arm64: dmi: initialize DMI earlier in boot
In-Reply-To: <1442589968.28550.18.camel@redhat.com>
References: <1442585666-14093-1-git-send-email-msalter@redhat.com>
 <20150918143124.GA31683@leverpostej>
 <1442589968.28550.18.camel@redhat.com>
Message-ID: <20150918153728.GD12837@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 04:26:08PM +0100, Mark Salter wrote:
> On Fri, 2015-09-18 at 15:31 +0100, Mark Rutland wrote:
> > On Fri, Sep 18, 2015 at 03:14:26PM +0100, Mark Salter wrote:
> > > Currently, DMI initialization takes place in a core initcall. This
> > > limits how early in boot the kernel can make DMI-based decisions
> > > about firmware/hardware quirks. This patch moves DMI initialization
> > > to setup_arch() so that DMI info is available before initcalls run.
> > 
> > Which firmware/hardware quirks in particular necessitate moving this?
> 
> The thing that prompted it for me was my testing of Lorenzo's parking
> protocol patch. I have a platform which has a quirky implementation of
> that and which has modified firmware to implement it according to the
> latest spec. So I need to tell the difference before secondary cores
> were brought up. This doesn't really effect upstream in that there is
> no need for backwards compatibility because there is no upstream
> parking protocol support currently. But it seemed reasonable to post
> this patch anyway since having DMI available earlier adds a little
> more utility, generally.

I think I'd rather hold off until we actually need this upstream for
something. The general tendency to move things earlier often causes
problems in the long-run.

> > > ---
> > >  arch/arm64/include/asm/dmi.h | 19 ++++++++++++++++---
> > >  arch/arm64/kernel/efi.c      | 15 ---------------
> > >  arch/arm64/kernel/setup.c    |  5 +++++
> > >  3 files changed, 21 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
> > > index 69d37d8..e6389fd 100644
> > > --- a/arch/arm64/include/asm/dmi.h
> > > +++ b/arch/arm64/include/asm/dmi.h
> > > @@ -16,16 +16,29 @@
> > >  
> > >  #include <linux/io.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/memblock.h>
> > 
> > Nit: please keep includes ordered (given they were already).
> 
> Alphabetically? (some maintainers like them ordered by name length :)

I prefer them ordered by hamming distance from the SHA1 of the file.

Will
