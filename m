From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2016 16:28:02 +0100
Subject: [PATCH v2] serial: amba-pl011: complete support to ZTE uart
In-Reply-To: <20160707150107.GA20896@tiger>
References: <1458717126-20814-1-git-send-email-jun.nie@linaro.org>
 <CABymUCN_Os0gxoWjfwB_8V4kEkwBqKcrCCRjH8+-gm-Xt3-tYQ@mail.gmail.com>
 <570CF1B3.8080305@linaro.org>
 <CABymUCPvayLkc5h-3e0671pEEO_SshNJazk7W0B_oAUfL-6r0w@mail.gmail.com>
 <20160428201106.GA2924@kroah.com>
 <CABymUCPH1CwxhBxGq5_epgn-19j9WrfrxxG8zuzpZnXk26Ps9A@mail.gmail.com>
 <20160707095453.GA10000@tiger> <20160707150107.GA20896@tiger>
Message-ID: <20160707152802.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 11:01:07PM +0800, Shawn Guo wrote:
> On Thu, Jul 07, 2016 at 05:54:53PM +0800, Shawn Guo wrote:
> > I think this version of the patch is trying to address the comment you
> > put on v1, i.e. instead of extending platform driver we should try to
> > probe ZTE UART from AMBA bus.
> > 
> > The solution here is to fake a AMBA peripheral ID which does not exist
> > on hardware with a magic number.  While it's working, it looks too
> > hackish, and doesn't really scale in the long run.  I hope that's also
> > the reason you are unwilling to provide your ACK :)
> > 
> > Unless you have a better solution to suggest, I would think that
> > platform driver is a sensible way to support the device, and will go
> > back to v1 approach.
> 
> Just found that Russell's email address changed.  Resend to the new
> address.

So, if I were to do this, there wouldn't be any objection?

An alternative would be to use the real hardware ID if it exists, add
a compatible to DT, and use of_device_is_compatible() in the driver
to discover if it's a zte device.

8<====
Subject: [PATCH] amba: make ZTE pseudo-ID more "official"

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 4 ++--
 include/linux/amba/bus.h        | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 77b05f5bf866..2dbe5776ac56 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2659,8 +2659,8 @@ static struct amba_id pl011_ids[] = {
 		.data	= &vendor_st,
 	},
 	{
-		.id	= 0xfefefe,
-		.mask	= 0xffffff,
+		.id	= AMBA_LINUX_ID(0x00, 0xf, 0xefe),
+		.mask	= 0x00ffffff,
 		.data	= &vendor_zte,
 	},
 	{ 0, 0 },
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 3d8dcdd1aeae..dc29d504b4fc 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -53,8 +53,13 @@ enum amba_vendor {
 	AMBA_VENDOR_ST = 0x80,
 	AMBA_VENDOR_QCOM = 0x51,
 	AMBA_VENDOR_LSI = 0xb6,
+	AMBA_VENDOR_LINUX = 0xef,	/* This value is not official */
 };
 
+#define AMBA_LINUX_ID(conf, rev, part) \
+	(((conf) & 0xff) << 24 | ((rev) & 0xf) << 20 | \
+	 AMBA_VENDOR_LINUX << 12 | ((part) & 0xfff))
+
 extern struct bus_type amba_bustype;
 
 #define to_amba_device(d)	container_of(d, struct amba_device, dev)
-- 
2.1.0

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
