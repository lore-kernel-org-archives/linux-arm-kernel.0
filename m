From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 1 Oct 2018 14:49:06 +0900
Subject: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <20180928154150.GA25013@bogus>
References: <20180910150403.19476-1-robh@kernel.org>
 <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
 <20180928154150.GA25013@bogus>
Message-ID: <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2018?9?29?(?) 0:43 Rob Herring <robh@kernel.org>:

> +#
> ---------------------------------------------------------------------------
> +# Devicetree files
> +
> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> +dtstree := arch/$(SRCARCH)/boot/dts
> +endif
> +
> +ifneq ($(dtstree),)
> +
> +%.dtb : scripts_dtc

%.dtb: prepare3 prepare


because we need to make sure KERNELRELEASE
is correctly defined before dtbs_install happens.


> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +
> +PHONY += dtbs dtbs_install
> +dtbs: scripts_dtc


dtbs: prepare3 scripts_dtc



> +       $(Q)$(MAKE) $(build)=$(dtstree)
> +
> +dtbs_install: dtbs


Please do not have dtbs_install to depend on dtbs.

No install targets should ever trigger building anything
in the source tree.


For the background, see the commit log of
19514fc665ffbce624785f76ee7ad0ea6378a527




> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE
> +all: dtbs
> +endif
> +
> +endif
> +
> +PHONY += scripts_dtc
> +scripts_dtc: scripts_basic
> +       $(Q)$(MAKE) $(build)=scripts/dtc
> +
>  #
> ---------------------------------------------------------------------------
>  # Modules
>


-- 
Best Regards
Masahiro Yamada
