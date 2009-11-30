From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Nov 2009 13:31:29 +0100
Subject: [PATCH] i.MX27 audmux: Fix register offsets
Message-ID: <mailman.61.1259752849.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have two holes in the register space. The driver did not
handle this. Fix it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/audmux-v1.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c
index 70ab5af..da6387d 100644
--- a/arch/arm/plat-mxc/audmux-v1.c
+++ b/arch/arm/plat-mxc/audmux-v1.c
@@ -28,7 +28,9 @@
 
 static void __iomem *audmux_base;
 
-#define MXC_AUDMUX_V1_PCR(x)	((x) * 4)
+static unsigned char port_mapping[] = {
+	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
+};
 
 int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
 {
@@ -37,7 +39,10 @@ int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
 		return -ENOSYS;
 	}
 
-	writel(pcr, audmux_base + MXC_AUDMUX_V1_PCR(port));
+	if (port >= ARRAY_SIZE(port_mapping))
+		return -EINVAL;
+
+	writel(pcr, audmux_base + port_mapping[port]);
 
 	return 0;
 }
-- 
1.6.5.2


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.68.1260108978.2170.linux-arm-kernel@lists.infradead.org>

working as intended.

The only explaination I have at present is that the CPU is buggy, and
for whatever reason, it _is_ caching the values for a C=0 B=1 mapping.
Maybe not a buggy L1 but a buggy L2 cache?

No idea, I know nothing about Feroceon CPUs, so I'm afraid its up to
others to investigate why they're having this problem.  All I can say
is that from the kernel point of view, the kernel is doing everything
it should.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.75.1260172499.2170.linux-arm-kernel@lists.infradead.org>

working as intended.

The only explaination I have at present is that the CPU is buggy, and
for whatever reason, it _is_ caching the values for a C=3D0 B=3D1 mapping.
Maybe not a buggy L1 but a buggy L2 cache?

No idea, I know nothing about Feroceon CPUs, so I'm afraid its up to
others to investigate why they're having this problem.  All I can say
is that from the kernel point of view, the kernel is doing everything
it should.


>From bogus@does.not.exist.com  Fri Nov  6 13:01:15 2009
From: bogus@does.not.exist.com ()
Date: Fri, 06 Nov 2009 18:01:15 -0000
Subject: No subject
Message-ID: <mailman.77.1260289106.2170.linux-arm-kernel@lists.infradead.org>

<div class=3D"im">From: Sascha Hauer &lt;<a href=3D"mailto:s.hauer@pengutro=
nix.de">s.hauer at pengutronix.de</a>&gt;<br>
Date: Mon, 30 Nov 2009 13:31:29 +0100<br>
Subject: [PATCH] i.MX27 audmux: Fix register offsets<br>
<br>
</div>We have two holes in the register space. The driver did not<br>
handle this. Fix it.<br>
<div class=3D"im"><br>
Signed-off-by: Sascha Hauer &lt;<a href=3D"mailto:s.hauer@pengutronix.de">s=
.hauer at pengutronix.de</a>&gt;<br>
---<br>
</div>=A0arch/arm/plat-mxc/audmux-v1.c | =A0 =A09 +++++++--<br>
<div class=3D"im">=A01 files changed, 7 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/arch/arm/plat-mxc/audmux-v1.c b/arch/arm/plat-mxc/audmux-v1.c<=
br>
</div>index 70ab5af..da6387d 100644<br>
<div class=3D"im">--- a/arch/arm/plat-mxc/audmux-v1.c<br>
+++ b/arch/arm/plat-mxc/audmux-v1.c<br>
</div>@@ -28,7 +28,9 @@<br>
<div class=3D"im"><br>
=A0static void __iomem *audmux_base;<br>
<br>
-#define MXC_AUDMUX_V1_PCR(x) =A0 ((x) * 4)<br>
</div>+static unsigned char port_mapping[] =3D {<br>
+ =A0 =A0 =A0 0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,<br>
+};<br>
<div class=3D"im"><br>
=A0int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)<br=
>
</div>=A0{<br>
@@ -37,7 +39,10 @@ int mxc_audmux_v1_configure_port(unsigned int port, unsi=
gned int pcr)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOSYS;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
- =A0 =A0 =A0 writel(pcr, audmux_base + MXC_AUDMUX_V1_PCR(port));<br>
+ =A0 =A0 =A0 if (port &gt;=3D ARRAY_SIZE(port_mapping))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+<br>
+ =A0 =A0 =A0 writel(pcr, audmux_base + port_mapping[port]);<br>
<div class=3D"im"><br>
 =A0 =A0 =A0 =A0return 0;<br>
=A0}<br>
--<br>
1.6.5.2<br></div></blockquote></div><br>Yes,<br>it works now. Thank you for=
 your patience with this.<br clear=3D"all"><br>-- <br>Javier Martin<br>Vist=
a Silicon S.L.<br>CDTUC - FASE C - Oficina S-345<br>Avda de los Castros s/n=
<br>
39005- Santander. Cantabria. Spain<br>+34 942 25 32 60<br><a href=3D"http:/=
/www.vista-silicon.com">www.vista-silicon.com</a><br>

--0016e6d9a0e87b335c0479be44de--
