From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Mar 2017 17:59:57 +0000
Subject: [PATCH v5 38/39] media: imx: csi: fix crop rectangle reset in
 sink set_fmt
In-Reply-To: <1490031621.2917.110.camel@pengutronix.de>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-39-git-send-email-steve_longerbeam@mentor.com>
 <20170319152233.GW21222@n2100.armlinux.org.uk>
 <327d67d9-68c1-7f74-0c0f-f6aee1c4b546@gmail.com>
 <1490010926.2917.59.camel@pengutronix.de>
 <20170320120855.GH21222@n2100.armlinux.org.uk>
 <1490018451.2917.86.camel@pengutronix.de>
 <20170320141705.GL21222@n2100.armlinux.org.uk>
 <1490031621.2917.110.camel@pengutronix.de>
Message-ID: <20170320175957.GS21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 06:40:21PM +0100, Philipp Zabel wrote:
> On Mon, 2017-03-20 at 14:17 +0000, Russell King - ARM Linux wrote:
> > I have tripped over a bug in media-ctl when specifying both a crop and
> > compose rectangle - the --help output suggests that "," should be used
> > to separate them.  media-ctl rejects that, telling me the character at
> > the "," should be "]".  Replacing the "," with " " allows media-ctl to
> > accept it and set both rectangles, so it sounds like a parser bug - I've
> > not looked into this any further yet.
> 
> I can confirm this. I don't see any place in
> v4l2_subdev_parse_pad_format that handles the "," separator. There's
> just whitespace skipping between the v4l2-properties.

Maybe this is the easiest solution:

 utils/media-ctl/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/media-ctl/options.c b/utils/media-ctl/options.c
index 83ca1ca..8b97874 100644
--- a/utils/media-ctl/options.c
+++ b/utils/media-ctl/options.c
@@ -65,7 +65,7 @@ static void usage(const char *argv0)
 	printf("\tentity          = entity-number | ( '\"' entity-name '\"' ) ;\n");
 	printf("\n");
 	printf("\tv4l2            = pad '[' v4l2-properties ']' ;\n");
-	printf("\tv4l2-properties = v4l2-property { ',' v4l2-property } ;\n");
+	printf("\tv4l2-properties = v4l2-property { ' '* v4l2-property } ;\n");
 	printf("\tv4l2-property   = v4l2-mbusfmt | v4l2-crop | v4l2-interval\n");
 	printf("\t                | v4l2-compose | v4l2-interval ;\n");
 	printf("\tv4l2-mbusfmt    = 'fmt:' fcc '/' size ; { 'field:' v4l2-field ; } { 'colorspace:' v4l2-colorspace ; }\n");

;)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
