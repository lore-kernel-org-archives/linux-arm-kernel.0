From: schen@mvista.com (Steve Chen)
Date: Tue, 15 Sep 2009 07:29:21 -0500
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <20090915103739.GA19519@elf.ucw.cz>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<200909132328.47079.marek.vasut@gmail.com>
	<20090913230008.GC30169@n2100.arm.linux.org.uk>
	<20090914002100.GD30621@shareable.org>
	<20090914081001.GB14519@n2100.arm.linux.org.uk>
	<94a0d4530909140558nd8d2c47lc9954563c80a574f@mail.gmail.com>
	<20090914140059.GC21580@n2100.arm.linux.org.uk>
	<94a0d4530909140738t7e4d646r134cfd884da21348@mail.gmail.com>
	<20090914144028.GG21580@n2100.arm.linux.org.uk>
	<94a0d4530909140814w36f7f5f0td2c25db07fbd4e57@mail.gmail.com>
	<20090915103739.GA19519@elf.ucw.cz>
Message-ID: <1253017761.3273.117.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-09-15 at 12:37 +0200, Pavel Machek wrote:
> > >> > Because then you get it whenever you configure for V4 as the lowest
> > >> > denominator CPU, which leads to the buggy behaviour on better CPUs.
> > >> > It's far better to leave it as is and just accept that the old CPUs
> > >> > will have longer than necessary delays.  If people really really
> > >> > care (and there's likely to only be a small minority of them now)
> > >> > changing the '0' to a '1' is a very simple change for them to carry
> > >> > in their local tree.  Unlike getting the right unrolling etc.
> > >>
> > >> Well, they can also 'git revert' this patch. If somebody really cares
> > >> I think they should shout now and provide a better patch, otherwise
> > >> this one should be merged.
> > >
> > > On the other hand, having the code there as it currently stands is not
> > > harmful in any way, so leaving it there is just as easy.
> > 
> > It makes the code less understandable. I'm not sure about linux's
> > practices, but an #if 0 generally means somebody is being lazy.
> 
> Not in this case, as you was explained to you. You may want to add
> explaining comment above #if 0....
> 								Pavel

Perhaps we can document with something like..

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aef63c8..ca8d535 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -813,6 +813,14 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR
register
 	  may not be available in non-secure mode.
 
+config OLD_CPU_DELAY
+	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
+	bool "Accurate delays for older CPU"
+	def_bool n
+	help
+	  Enable if observing longer than expected delays and need more
+	  accurate delays on older CPUs.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/lib/delay.S b/arch/arm/lib/delay.S
index 8d6a876..8b3fa63 100644
--- a/arch/arm/lib/delay.S
+++ b/arch/arm/lib/delay.S
@@ -42,7 +42,7 @@ ENTRY(__const_udelay)				@ 0 <= r0 <= 0x7fffff06
 @ Delay routine
 ENTRY(__delay)
 		subs	r0, r0, #1
-#if 0
+#if CONFIG_OLD_CPU_DELAY
 		movls	pc, lr
 		subs	r0, r0, #1
 		movls	pc, lr
