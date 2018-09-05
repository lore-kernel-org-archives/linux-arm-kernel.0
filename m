From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 5 Sep 2018 16:38:10 -0500
Subject: [RESEND PATCHv2 2/4] ARM: dts: add support for individual build
 flags for DT subdirs
In-Reply-To: <45fada0c-af5c-ee94-9878-8ea78a34da26@gmail.com>
References: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
 <1536048344-9995-1-git-send-email-t-kristo@ti.com>
 <1536048344-9995-3-git-send-email-t-kristo@ti.com>
 <45fada0c-af5c-ee94-9878-8ea78a34da26@gmail.com>
Message-ID: <CAL_JsqJY0iqodKoEW2HjO=O+_Jo1iDt-Jt+ShZYvPaDksVLTWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 3:36 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 09/04/18 01:05, Tero Kristo wrote:
> > Currently the makefile is setup in such manner that even if
> > we build a DT file in a subdirectory under arch/arm/boot/dts,
> > it gets built based on the base boot/dts/Makefile rules.
> > This patch modifies the base makefile in such manner, that
> > it detects which makefile to use based on build target path.
> > This allows setting for example per-directory DTC_FLAGS and
> > using those for the subdir build. The dtbdir local variable
> > is setup to target to the build path.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index ab555a0..b7c21e8 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -339,8 +339,10 @@ $(BOOT_TARGETS): vmlinux
> >  $(INSTALL_TARGETS):
> >       $(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
> >
> > +%.dtb %.dtbo: dtbdir = $(patsubst %/,%,$(patsubst %./,%,$(boot)/dts/$(dir $@)))
> > +
> >  %.dtb %.dtbo: | scripts
> > -     $(Q)$(MAKE) $(build)=$(boot)/dts MACHINE=$(MACHINE) $(boot)/dts/$@
> > +     $(Q)$(MAKE) $(build)=$(dtbdir) MACHINE=$(MACHINE) $(boot)/dts/$@
> >
> >  PHONY += dtbs dtbs_install
> >
> >
>
> The makefile magic to handle subdirectories below $(boot)/dts/ already
> works properly to have Makefiles in $(boot)/dts/, using the following
> rule in arch/arm64/Makefile:
>
> %.dtb: scripts
>         $(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
>
> I don't understand why that works for arm64, but it should work the
> same way for arm.  Or if arch/arm is missing another piece from
> arch/arm64 we should be consistent with however the make system
> specifies it in arch/arm64

It should just need a subdir-y for the sub-directory. The target is
"subdir/some.dtb" though.

If we want to build specific directories, we should get the standard
way of doing that to work: make arch/arm/boot/dts/subdir/

Rob
