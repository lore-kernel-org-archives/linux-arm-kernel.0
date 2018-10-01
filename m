From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 1 Oct 2018 23:48:00 +0900
Subject: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <CAL_JsqLPaX3GB1Esw3DhkQ+2fQLVG8=_UbyJC5RJ-6_s=v288g@mail.gmail.com>
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
 <20180928154150.GA25013@bogus>
 <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
 <CAL_JsqLPaX3GB1Esw3DhkQ+2fQLVG8=_UbyJC5RJ-6_s=v288g@mail.gmail.com>
Message-ID: <CAK7LNASX+2iLbXmpgcsH9agrxkd5xeWbTZdh8hxL+zJm4L11gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2018?10?1?(?) 22:26 Rob Herring <robh@kernel.org>:
>
> On Mon, Oct 1, 2018 at 12:49 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Rob,
> >
> >
> > 2018?9?29?(?) 0:43 Rob Herring <robh@kernel.org>:
> >
> > > +#
> > > ---------------------------------------------------------------------------
> > > +# Devicetree files
> > > +
> > > +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> > > +dtstree := arch/$(SRCARCH)/boot/dts
> > > +endif
> > > +
> > > +ifneq ($(dtstree),)
> > > +
> > > +%.dtb : scripts_dtc
> >
> > %.dtb: prepare3 prepare
>
> I assume you didn't mean to drop scripts_dtc as that doesn't work.
>
> Why "prepare" here and not on dtbs?


Sorry, my mistake.


%.dtb: prepare3 scripts_dtc

is the correct one.



> > because we need to make sure KERNELRELEASE
> > is correctly defined before dtbs_install happens.
>
> Yes, indeed. With prepare3 added I get:
>
> cp: cannot create regular file
> '/boot/dtbs/4.19.0-rc3-00009-g0afba9b7b2ea-dirty': No such file or
> directory
>
> vs. with it:
>
> cp: cannot create regular file '/boot/dtbs/': Not a directory
>
> >
> >
> > > +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> > > +
> > > +PHONY += dtbs dtbs_install
> > > +dtbs: scripts_dtc
> >
> >
> > dtbs: prepare3 scripts_dtc
> >
> >
> >
> > > +       $(Q)$(MAKE) $(build)=$(dtstree)
> > > +
> > > +dtbs_install: dtbs
> >
> >
> > Please do not have dtbs_install to depend on dtbs.
> >
> > No install targets should ever trigger building anything
> > in the source tree.
> >
> >
> > For the background, see the commit log of
> > 19514fc665ffbce624785f76ee7ad0ea6378a527
>
> Okay, thanks.
>
> Rob



-- 
Best Regards
Masahiro Yamada
