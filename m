From: linus.luessing@c0d3.blue (Linus =?utf-8?Q?L=C3=BCssing?=)
Date: Sat, 28 Oct 2017 22:27:30 +0200
Subject: [PATCH] ARM: dts: meson8b: add reserved memory zone to fix
 silent freezes
In-Reply-To: <20171023074721.GB2049@otheros>
References: <20171002155903.19511-1-linus.luessing@c0d3.blue>
 <CAFBinCCde249b0o9aKMErEbKznM7UQrg1FzhLQ2whej0x_XLAg@mail.gmail.com>
 <20171002234755.GA18646@ingrassia.epigenesys.com>
 <20171003072703.GY6726@otheros>
 <20171003082310.GA15501@ingrassia.epigenesys.com>
 <20171003105427.GZ6726@otheros>
 <20171004201645.GA23053@ingrassia.epigenesys.com>
 <20171023074721.GB2049@otheros>
Message-ID: <20171028202730.GO2750@otheros>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 09:47:21AM +0200, Linus L?ssing wrote:
> I'm currently continuing to bisect which difference in Emiliano's
> and my kernel image makes mine boot successfully but not
> Emiliano's. (And I'm continuing reading and testing with the
> filter-range option to better understand what it's presence - or
> absence - does exactly)

I found the difference between Emiliano's and my kernel image and
could narrow it down to this particular difference via bisecting:

Using the multi_v7_defconfig target, but with the following
two options unselected:

* System Type
  -> Qualcomm Support
     - Enable support for MSM8X60 (disabled)
     - Enable support for MSM8960 (disabled)

Results in the following diff, according to ./scripts/diffconfig:

-CLKSRC_QCOM y
-MSM_IOMMU n
 ARCH_MSM8960 y -> n
 ARCH_MSM8X60 y -> n

Once this is unselected, the kernel hangs for me on boot, too.
Both with or without this 2MB reserved memory region patch.

Removing the "arm,filter-ranges" as tried by Emiliano makes it
boot again.

Finally, what also helps booting again is this diff from the
pending SMP support patch series from Carlo/Martin [0]:

~~~~~
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47d3a1ab08d2..82faa958ab88 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -147,6 +147,7 @@  textofs-$(CONFIG_SA1111) := 0x00208000
 endif
 textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
 textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
+textofs-$(CONFIG_ARCH_MESON) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
~~~~~

Note the $(CONFIG_ARCH_MSM8X60) and $(CONFIG_ARCH_MSM8960) just
above. Sounds familiar :-)?

With this textofs diff alone, stress-ng still hangs though. Only
with the 2MB memory zone reserved via DT or the "arm,filter-ranges"
removed, stress-ng succeeds, too.

Regards, Linus

[0]: "[v7,4/6] ARM: meson: Add SMP bringup code for Meson8 and Meson8b"
     -> https://patchwork.kernel.org/patch/9954935/


On Mon, Oct 23, 2017 at 09:47:21AM +0200, Linus L?ssing wrote:
> Subject: Re: [PATCH] ARM: dts: meson8b: add reserved memory zone to fix silent freezes
> To: Kevin Hilman <khilman@baylibre.com>
> Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Emiliano Ingrassia <ingrassia@epigenesys.com>, linux-amlogic at lists.infradead.org
> 
> Hi Kevin,
> 
> Just wanted to let you know that Emiliano and I are currently
> debugging further off-list.
> 
> So far I can reproduce that:
> 
> a) For the binary kernel image Emiliano sent me I can reproduce
> his hang ups during boot on my Odroid C1+.
> b) The 2MB reserved memory region this patch adds does not help
> for this image.
> c) Removing the "arm,filter-range" as proposed by Emiliano back
> then instead of adding this reserved memory zone fixes my freezes
> during boot in Emiliano's image and during stress-ng for my kernel
> image, too.
> 
> I'm currently continuing to bisect which difference in Emiliano's
> and my kernel image makes mine boot successfully but not
> Emiliano's. (And I'm continuing reading and testing with the
> filter-range option to better understand what it's presence - or
> absence - does exactly)
> 
> 
> If these observations ring a bell for anyone here, I'd be curious
> to hear what they think.
> 
> Regards, Linus
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
