From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 3 Sep 2012 13:21:34 +0100
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120901144922.GA25277@lunn.ch>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120901144922.GA25277@lunn.ch>
Message-ID: <20120903122134.GA3290@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 01, 2012 at 04:49:22PM +0200, Andrew Lunn wrote:
> On Thu, Aug 30, 2012 at 07:14:47AM +0200, Andrew Lunn wrote:
> > Tools like kisskb are good at finding build regressions in the kernel
> > sources. However, regressions in the DT desscriptions are not found,
> > because generally these build systems don't build the DT binary blobs.
> > 
> > Extend the ARM all target to build all enabled DTB files.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > v2: * in the help test
> >     Only invoke dtbs if CONFIGUSE_OF=y
> > 
> >  arch/arm/Makefile |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 30eae87..0457ef4 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -268,7 +268,12 @@ else
> >  KBUILD_IMAGE := zImage
> >  endif
> >  
> > -all:	$(KBUILD_IMAGE)
> > +# Build the DT binary blobs if we have OF configured
> > +ifeq ($(CONFIG_USE_OF),y)
> > +KBUILD_DTBS := dtbs
> > +endif
> > +
> > +all:	$(KBUILD_IMAGE) $(KBUILD_DTBS)
> >  
> >  boot := arch/arm/boot
> >  
> > @@ -306,7 +311,7 @@ define archhelp
> >    echo  '  uImage        - U-Boot wrapped zImage'
> >    echo  '  bootpImage    - Combined zImage and initial RAM disk' 
> >    echo  '                  (supply initrd image via make variable INITRD=<path>)'
> > -  echo  '  dtbs          - Build device tree blobs for enabled boards'
> > +  echo  '* dtbs          - Build device tree blobs for enabled boards'
> >    echo  '  install       - Install uncompressed kernel'
> >    echo  '  zinstall      - Install compressed kernel'
> >    echo  '  uinstall      - Install U-Boot wrapped compressed kernel'
> > -- 
> > 1.7.10.4
> > 
> 
> Hi Folks
> 
> Would anybody like to comment about the patch itself?
> 
> Assuming the patch is acceptable, through which maintainers tree
> should it be submitted?
> 
>        Thanks
>   	  Andrew

My only concern here is that because of the missing make dependency
between dtbs and dtc, this could cause unexpected build failures during
parallel builds.  However, so far as I can see this is not a problem
unless explicit targets are put on the command line (which is already
problematic with or without this patch).  There is a separate patch
under discussion to fix that, so your patch need not address it.


This looks like a sensible fix for something which has been niggling
at me, so

Reviewed-by: Dave Martin <dave.martin@linaro.org>

This is ARM core build system stuff, so I would expect that it should
be submitted via Russell.

Because this is related to DT, I suggest that you repost first, CC'ing
devicetree-discuss at lists.ozlabs.org so those guys have a chance to
comment (though the relevant people will generally be reading alkml
anyway).  They might have a view on whether there are better ways to
write the patch ... but probably not.


I'll leave it for the stable guys to judge whether this patch is
appropriate for them.  The patch itself is a feature addition, which
would normally exclude it.  But its inclusion might still be considered
justified on grounds of improving build regression coverage of dtbs and
dtc on stable.

Cheers
---Dave
