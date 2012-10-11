From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 11 Oct 2012 15:24:32 +0800
Subject: ARM_ATAG_DTB_COMPAT fails on fdt_ro.c compiling
In-Reply-To: <CAOMZO5BgJ0eSPvhnjCx_DVAUdLKpEhp-amJQw-8NZDX9AfCDeA@mail.gmail.com>
References: <20121009031715.GC21822@S2101-09.ap.freescale.net>
 <alpine.LFD.2.02.1210090018470.16518@xanadu.home>
 <20121009050109.GD21822@S2101-09.ap.freescale.net>
 <50744DBA.3070900@wwwdotorg.org>
 <CAOMZO5BgJ0eSPvhnjCx_DVAUdLKpEhp-amJQw-8NZDX9AfCDeA@mail.gmail.com>
Message-ID: <20121011072428.GA26298@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 01:21:02PM -0300, Fabio Estevam wrote:
> On Tue, Oct 9, 2012 at 1:15 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> >>> I just tried building mainline now.  It is at commit f5a246eab9.
> >>>
> >> The build still fails for me at this commit.
> >
> > I can't reproduce this.
> 
> Same here. It builds fine for me.
> 
Thanks all for confirming it works.

I just figured it out on my end.  Here is how it gets broken for me.

- Before commit cd29672 (dtc: import latest upstream dtc) gets in,
  I did a build without O=<output_dir>.  It results in a copy of those
  libfdt files in arch/arm/boot/compressed.

- After the commit gets in, I start a build with O=imx parameter.  When
  compiling imx/arch/arm/boot/compressed/fdt_ro.c, the #include <libfdt.h>
  in fdt_ro.c seems to match the one left in arch/arm/boot/compressed/
  from last build rather than imx/arch/arm/boot/compressed/libfdt.h.

Cleaning the libfdt copies in arch/arm/boot/compressed fixes the
problem.  Not sure why it's not "libfdt.h" but <libfdt.h> is used as
the inclusion though, since the .h and .c are in the same folder.

Shawn
