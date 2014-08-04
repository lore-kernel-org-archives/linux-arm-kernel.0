From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Aug 2014 21:32:59 +0200
Subject: [PATCH 2/9] ARM: sunxi: quirk support
In-Reply-To: <53DEAB9B.1090400@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-3-git-send-email-emilio@elopez.com.ar>
 <20140803124211.GU3952@lukather> <53DEAB9B.1090400@elopez.com.ar>
Message-ID: <20140804193259.GG3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 03, 2014 at 06:37:31PM -0300, Emilio L?pez wrote:
> Hi Maxime,
> 
> El 03/08/14 a las 09:42, Maxime Ripard escibi?:
> >On Thu, Jul 31, 2014 at 06:28:05PM -0300, Emilio L?pez wrote:
> >>Currently, some hardware revisions of sunxi SoCs need special care on
> >>some blocks because of hardware differences and/or bugs. Unfortunately,
> >>it is unfeasible to account for these issues directly when writing the
> >>device tree, as SoC revision can vary between different units of the
> >>same device. This commit introduces a place to adjust DT compatibles
> >>as needed to work around said issues before devices are probed. To
> >>demonstrate usage, two quirks are added for the PLL2 and audio codec
> >>on sun4i.
> >>
> >>Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >>---
> (...)
> >>+static int __init sunxi_apply_quirks(void)
> >>+{
> >>+	if (of_machine_is_compatible("allwinner,sun4i-a10")) {
> >>+		sun4i_pll2_quirk();
> >>+		sun4i_codec_quirk();
> >>+	}
> >>+
> >>+	return 0;
> >>+}
> >>+postcore_initcall(sunxi_apply_quirks)
> >
> >Have you tested it? My guess is that it wolud have to run *much*
> >sooner, before of_platform_populate to be effective.
> 
> I have, I was able to break my UART with it :)
> 
> of_platform_populate() is called from arch/arm/kernel/setup.c on
> arch_initcall. From include/linux/init.h
> 
> ...
> #define postcore_initcall(fn)           __define_initcall(fn, 2)
> #define postcore_initcall_sync(fn)      __define_initcall(fn, 2s)
> #define arch_initcall(fn)               __define_initcall(fn, 3)
> ...
> 
> So it should be fine.

Hmmm, right.

I was under the impression it was done sooner, but I was wrong,
obviously.

Still, the machine init callback has the advantage of being run only
on the current machine, not in every case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/6657bbdd/attachment.sig>
