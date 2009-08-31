From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 31 Aug 2009 15:48:04 +0530
Subject: [PATCH 13/46] davinci: support re-parenting a clock in the clock framework
Message-ID: <mailman.81.1255994808.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_set_parent() API is implemented to enable re-parenting
clocks in the clock tree.

This is useful in DVFS and helps by shifting clocks to an asynchronous
domain where supported by hardware

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 09e0e1c..e7696fc 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -141,6 +141,33 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL(clk_set_rate);
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	unsigned long flags;
+
+	if (clk == NULL || IS_ERR(clk))
+		return -EINVAL;
+
+	/* Cannot change parent on enabled clock */
+	if (WARN_ON(clk->usecount))
+		return -EINVAL;
+
+	mutex_lock(&clocks_mutex);
+	clk->parent = parent;
+	list_del_init(&clk->childnode);
+	list_add(&clk->childnode, &clk->parent->children);
+	mutex_unlock(&clocks_mutex);
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+	if (clk->recalc)
+		clk->rate = clk->recalc(clk);
+	propagate_rate(clk);
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
 int clk_register(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
-- 
1.6.4.3



>From bogus@does.not.exist.com  Mon Aug 24 09:56:15 2009
From: bogus@does.not.exist.com ()
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.96.1256827883.2253.linux-arm-kernel@lists.infradead.org>

solution which may can be referenced and benefit the final result.

The problem with this driver I guess is that how other Marvell apps
depends on this, and it's currently unknown since the API and user-
space stuffs are not public at the moment. And apparently, the one
you posted has already included a link to the directfb usage.

Technically, these drivers are based on samilar ideas, I don't have
any preference. The real issue is that Marvell should have a look
into the directfb version, and evaluate if something is missing and
the effort of porting existing apps over to that driver because
eventually I'd like to see only one driver there. And vice versa
from the directfb POV.

Note I'm neutral on this, and this could be the chance both parties
look into the solution of the other one, and improve the final
result. (what I care only is good code ;-)

- eric


>From Jonathan  Mon Aug 24 09:56:15 2009
From: Jonathan (Jonathan)
Date: Mon, 24 Aug 2009 13:56:15 -0000
Subject: No subject
Message-ID: <mailman.106.1257339474.2253.linux-arm-kernel@lists.infradead.org>

uk</a>&gt;<br>
Date: Sat, 4 Jul 2009 13:25:06 +0000<br>
Subject: [PATCH 02/10] ov7670: Temporary soc-camera support<br>
<br>
Signed-off-by: Jonathan Cameron &lt;<a href=3D"mailto:jic23@cam.ac.uk">jic2=
3 at cam.ac.uk</a>&gt;<br>
---<br>
&nbsp;drivers/media/video/ov7670.c | &nbsp; 50 ++++++++++++++++++++++++++++=
++++++++++++++<br>
&nbsp;1 files changed, 50 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/drivers/media/video/ov7670.c b/drivers/media/video/ov7670.c<br=
>
index 0e2184e..910a499 100644<br>
--- a/drivers/media/video/ov7670.c<br>
+++ b/drivers/media/video/ov7670.c<br>
@@ -19,6 +19,8 @@<br>
&nbsp;#include &lt;media/v4l2-chip-ident.h&gt;<br>
&nbsp;#include &lt;media/v4l2-i2c-drv.h&gt;<br>
<br>
+#include &lt;media/soc_camera.h&gt;<br>
+#include &lt;linux/autoconf.h&gt;<br>
<br>
&nbsp;MODULE_AUTHOR(&quot;Jonathan Corbet &lt;<a href=3D"mailto:corbet@lwn.=
net">corbet at lwn.net</a>&gt;&quot;);<br>
&nbsp;MODULE_DESCRIPTION(&quot;A low-level driver for OmniVision ov7670 sen=
sors&quot;);<br>
@@ -745,6 +747,10 @@ static int ov7670_s_fmt(struct v4l2_subdev *sd, struct=
 v4l2_format *fmt)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct ov7670_info *info =3D to_state(sd);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;unsigned char com7, clkrc =3D 0;<br>
<br>
+ &nbsp; &nbsp; &nbsp; ret =3D ov7670_init(sd, 0);<br>
+ &nbsp; &nbsp; &nbsp; if (ret)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp;ret =3D ov7670_try_fmt_internal(sd, fmt, &amp;o=
vfmt, &amp;wsize);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (ret)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
@@ -1239,6 +1245,41 @@ static const struct v4l2_subdev_ops ov7670_ops =3D {=
<br>
&nbsp;};<br>
<br>
&nbsp;/* ------------------------------------------------------------------=
----- */<br>
+static unsigned long ov7670_soc_query_bus_param(struct soc_camera_device *=
icd)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; struct soc_camera_link *icl =3D to_soc_camera_link(i=
cd);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; unsigned long flags =3D SOCAM_PCLK_SAMPLE_RISING | S=
OCAM_MASTER |<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SOCAM_VSYNC_ACTIVE_HIGH =
| SOCAM_HSYNC_ACTIVE_HIGH |<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SOCAM_DATAWIDTH_8 | SOCA=
M_DATA_ACTIVE_HIGH;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; return soc_camera_apply_sensor_flags(icl, flags);<br=
>
+}<br>
+<br>
+/* This device only supports one bus option */<br>
+static int ov7670_soc_set_bus_param(struct soc_camera_device *icd,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned long flags)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; return 0;<br>
+}<br>
+<br>
+static struct soc_camera_ops ov7670_soc_ops =3D {<br>
+ &nbsp; &nbsp; &nbsp; .set_bus_param =3D ov7670_soc_set_bus_param,<br>
+ &nbsp; &nbsp; &nbsp; .query_bus_param =3D ov7670_soc_query_bus_param,<br>
+};<br>
+<br>
+#define SETFOURCC(type) .name =3D (#type), .fourcc =3D (V4L2_PIX_FMT_ ## t=
ype)<br>
+static const struct soc_camera_data_format ov7670_soc_fmt_lists[] =3D {<br=
>
+ &nbsp; &nbsp; &nbsp; {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SETFOURCC(YUYV),<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .depth =3D 16,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .colorspace =3D V4L2_COL=
ORSPACE_JPEG,<br>
+ &nbsp; &nbsp; &nbsp; }, {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SETFOURCC(RGB565),<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .depth =3D 16,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .colorspace =3D V4L2_COL=
ORSPACE_SRGB,<br>
+ &nbsp; &nbsp; &nbsp; },<br>
+};<br>
<br>
&nbsp;static int ov7670_probe(struct i2c_client *client,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp;const struct i2c_device_id *id)<br>
@@ -1246,7 +1287,16 @@ static int ov7670_probe(struct i2c_client *client,<b=
r>
 &nbsp; &nbsp; &nbsp; &nbsp;struct v4l2_subdev *sd;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;struct ov7670_info *info;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
+ &nbsp; &nbsp; &nbsp; struct soc_camera_device *icd =3D client-&gt;dev.pla=
tform_data;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (!icd) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_err(&amp;client-&gt;=
dev, &quot;OV7670: missing soc-camera data!\n&quot;);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;<br>
+ &nbsp; &nbsp; &nbsp; }<br>
<br>
+ &nbsp; &nbsp; &nbsp; icd-&gt;ops =3D &amp;ov7670_soc_ops;<br>
+ &nbsp; &nbsp; &nbsp; icd-&gt;formats =3D ov7670_soc_fmt_lists;<br>
+ &nbsp; &nbsp; &nbsp; icd-&gt;num_formats =3D ARRAY_SIZE(ov7670_soc_fmt_li=
sts);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;info =3D kzalloc(sizeof(struct ov7670_info), GF=
P_KERNEL);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (info =3D=3D NULL)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -ENOMEM;<br>
<font color=3D"#888888">--<br>
1.6.3.3<br>
<br>
<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>=D3=D0=CB=BD,=C9=
=FA=CF=A2=C2=D6=BB=D8=D5=DF=CE=AA=C9=FA<br>=D6=AA=CE=D2,=BF=C9=D0=D0=C4=E6=
=CC=EC=D5=DF=CE=AA=C1=E9<br>=D7=D4=CA=C0=C9=CF=C9=FA=C1=E9=D6=AA=D3=D0=CE=
=D2=CA=B1=C6=F0=A3=AC<br>=BC=B4=D6=AA=C7=F7=B1=DC=A3=AC<br>=D2=D4=C0=FB=CE=
=D2=D5=DF=CE=AA=C9=C6=A3=AC=D2=D4=BA=A6=CE=D2=D5=DF=CE=AA=B6=F1=A3=AC<br>=
=CB=B9=CE=AA=B6=C0=D3=FB=D6=AE=D0=C4=A3=AC=D2=E0=CA=C7=C3=C9=C3=C1=D4=B4=C1=
=F7=A1=A3<br>=BE=FD=D7=D3=B9=A4=D7=F7=CA=D2<br><a href=3D"http://www.junzij=
u.com.cn">www.junziju.com.cn</a><br>=D6=D0=B9=FA=B5=E7=D7=D3=C9=E8=BC=C6=C2=
=DB=CC=B3<br>
<a href=3D"http://www.eledsn.com">www.eledsn.com</a><br>

--001636e9087a46691e0477753ba4--
