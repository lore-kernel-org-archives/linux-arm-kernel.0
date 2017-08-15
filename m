From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 16 Aug 2017 00:03:49 +0200
Subject: [PATCH] nokia n900: update dts with camera support
In-Reply-To: <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
Message-ID: <20170815220349.GA15441@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> I understand Tony already applied this one. I'd have a few comments below,
> could you address them in another patch, please?

Yes.

> > +	rear_camera: camera at 0 {
> > +		compatible = "linux,camera";
> > +
> > +		module {
> > +			model = "TCM8341MD";
> > +			sensor = <&cam1>;
> > +		};
> > +	};
> 
> There's no reference to rear_camera. I understand that this represents the
> camera module but as we don't have any documented way to describe camera
> modules (nor we have really discussed the matter), this should be removed
> for now.
> 
> Perhaps later on, but I be it'd look quite different.

Ok, this is easy.

> > +				bus-type = <3>; /* CCP2 */
> > +				clock-lanes = <1>;
> > +				data-lanes = <0>;
> > +				lane-polarity = <0 0>;
> > +				clock-inv = <0>;
> > +				/* Select strobe = <1> for back camera, <0> for front camera */
> > +				strobe = <1>;
> > +				crc = <0>;
> 
> crc is not a documented binding in video-interfaces.txt. Same for
> clock-inv. clock-inv is used by v4l2-fwnode.c already. Describing both in
> video-interfaces.txt would certainly make sense though, as well as adding
> support for crc in CCP2 to V4L2 fwnode.
> 
> Could you submit patches for that? I can do that as well but it'll probably
> take some days at least.

Ok, no longer that easy. But see below, something like that?

Could you suggest better documentation lines? I'm afraid Rob will not
like "not inverted" vs. "inverted"... would "camera sensor protects
image data of each frame with crc" be suitable?

Best regards,

Signed-off-by: Pavel Machek <pavel@ucw.cz>

									Pavel

diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
index 852041a..aade681 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.txt
+++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
@@ -119,6 +119,8 @@ Optional endpoint properties
   as 0 (normal). This property is valid for serial busses only.
 - strobe: Whether the clock signal is used as clock (0) or strobe (1). Used
   with CCP2, for instance.
+- clock-inv: polarity of clock/strobe signal. 0 - not inverted, 1 - inverted
+- crc: crc is in use
 
 Example
 -------
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index b1be53d..0c1ef5c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -144,15 +144,6 @@
 		io-channel-names = "temp", "bsi", "vbat";
 	};
 
-	rear_camera: camera at 0 {
-		compatible = "linux,camera";
-
-		module {
-			model = "TCM8341MD";
-			sensor = <&cam1>;
-		};
-	};
-
 	pwm9: dmtimer-pwm {
 		compatible = "ti,omap-dmtimer-pwm";
 		#pwm-cells = <3>;
@@ -192,7 +183,7 @@
 				clock-inv = <0>;
 				/* Select strobe = <1> for back camera, <0> for front camera */
 				strobe = <1>;
-				crc = <0>;
+				crc = <1>;
 			};
 		};
 	};
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 6cb1f04..3e17d72 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -2098,12 +2098,12 @@ static int isp_fwnode_parse(struct device *dev, struct fwnode_handle *fwnode,
 
 			buscfg->bus.ccp2.strobe_clk_pol =
 				vep.bus.mipi_csi1.clock_inv;
+			buscfg->bus.ccp2.crc =
+				vep.bus.mipi_csi1.crc;
 			buscfg->bus.ccp2.phy_layer = vep.bus.mipi_csi1.strobe;
 			buscfg->bus.ccp2.ccp2_mode =
 				vep.bus_type == V4L2_MBUS_CCP2;
 			buscfg->bus.ccp2.vp_clk_pol = 1;
-
-			buscfg->bus.ccp2.crc = 1;
 		} else {
 			buscfg->bus.csi2.lanecfg.clk.pos =
 				vep.bus.mipi_csi2.clock_lane;
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 5cd2687..ce1af2d 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -170,6 +170,9 @@ v4l2_fwnode_endpoint_parse_csi1_bus(struct fwnode_handle *fwnode,
 	if (!fwnode_property_read_u32(fwnode, "clock-lanes", &v))
 		bus->clock_lane = v;
 
+	if (!fwnode_property_read_u32(fwnode, "crc", &v))
+		bus->crc = v;
+
 	if (bus_type == V4L2_FWNODE_BUS_TYPE_CCP2)
 		vep->bus_type = V4L2_MBUS_CCP2;
 	else
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index cb34dcb..eb820dc 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -66,11 +66,13 @@ struct v4l2_fwnode_bus_parallel {
  *		   index (1)
  * @data_lane: the number of the data lane
  * @clock_lane: the number of the clock lane
+ * @crc: crc is in use
  */
 struct v4l2_fwnode_bus_mipi_csi1 {
 	bool clock_inv;
 	bool strobe;
 	bool lane_polarity[2];
+	bool crc;
 	unsigned char data_lane;
 	unsigned char clock_lane;
 };
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170816/b4598985/attachment.sig>
