From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Mar 2017 15:43:39 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <1490016016.2917.68.camel@pengutronix.de>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170319121402.GS21222@n2100.armlinux.org.uk>
 <1490016016.2917.68.camel@pengutronix.de>
Message-ID: <20170320154339.GN21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 02:20:16PM +0100, Philipp Zabel wrote:
> To set and read colorimetry information:
> https://patchwork.linuxtv.org/patch/39350/

Thanks, I've applied all four of your patches, but there's a side effect
from that.  Old media-ctl (modified by me):

- entity 53: imx219 0-0010 (2 pads, 2 links)
             type V4L2 subdev subtype Unknown flags 0
             device node name /dev/v4l-subdev9
        pad0: Source
                [fmt:SRGGB8/816x616 field:none
                 frame_interval:1/25]
                -> "imx6-mipi-csi2":0 [ENABLED]
        pad1: Sink
                [fmt:SRGGB10/3280x2464 field:none
                 crop.bounds:(0,0)/3280x2464
                 crop:(0,0)/3264x2464
                 compose.bounds:(0,0)/3264x2464
                 compose:(0,0)/816x616]
                <- "imx219 pixel 0-0010":0 [ENABLED,IMMUTABLE]

New media-ctl:

- entity 53: imx219 0-0010 (2 pads, 2 links)
             type V4L2 subdev subtype Unknown flags 0
             device node name /dev/v4l-subdev9
        pad0: Source
                [fmt:SRGGB8_1X8/816x616@1/25 field:none colorspace:srgb xfer:srgb]
                -> "imx6-mipi-csi2":0 [ENABLED]
        pad1: Sink
                <- "imx219 pixel 0-0010":0 [ENABLED,IMMUTABLE]

It looks like we successfully retrieve the frame interval for pad 0
and print it, but when we try to retrieve the frame interval for pad 1,
we get EINVAL (because that's what I'm returning, but I'm wondering if
that's the correct thing to do...) and that prevents _all_ format
information being output.

Maybe something like the following would be a better idea?

 utils/media-ctl/media-ctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/utils/media-ctl/media-ctl.c b/utils/media-ctl/media-ctl.c
index f61963a..a50a559 100644
--- a/utils/media-ctl/media-ctl.c
+++ b/utils/media-ctl/media-ctl.c
@@ -81,22 +81,22 @@ static void v4l2_subdev_print_format(struct media_entity *entity,
 	struct v4l2_mbus_framefmt format;
 	struct v4l2_fract interval = { 0, 0 };
 	struct v4l2_rect rect;
-	int ret;
+	int ret, err_fi;
 
 	ret = v4l2_subdev_get_format(entity, &format, pad, which);
 	if (ret != 0)
 		return;
 
-	ret = v4l2_subdev_get_frame_interval(entity, &interval, pad);
-	if (ret != 0 && ret != -ENOTTY)
-		return;
+	err_fi = v4l2_subdev_get_frame_interval(entity, &interval, pad);
 
 	printf("\t\t[fmt:%s/%ux%u",
 	       v4l2_subdev_pixelcode_to_string(format.code),
 	       format.width, format.height);
 
-	if (interval.numerator || interval.denominator)
+	if (err_fi == 0 && (interval.numerator || interval.denominator))
 		printf("@%u/%u", interval.numerator, interval.denominator);
+	else if (err_fi != -ENOTTY)
+		printf("@<error: %s>", strerror(-err_fi));
 
 	if (format.field)
 		printf(" field:%s", v4l2_subdev_field_to_string(format.field));


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
