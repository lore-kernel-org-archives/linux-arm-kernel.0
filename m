From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Jan 2013 14:11:18 +0800
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <201301212137.42611.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1301211459550.24224-100000@netrider.rowland.org>
 <201301212137.42611.arnd@arndb.de>
Message-ID: <20130122061116.GD29677@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 09:37:42PM +0000, Arnd Bergmann wrote:
> > Arnd, please take a look at
> > 
> >         http://marc.info/?l=linux-usb&amp;m=135843716515529&amp;w=2
> > 
> > I can't test it easily, not being set up for cross compilation.  I'm 
> > waiting to hear from anybody whether it works before submitting it.
> > (There's also a report of memory corruption involving a similar patch 
> > for ehci-omap; it hasn't been tracked down yet.)
> 
> Your patch looks good to me, but it also seems to do some other
> changes that are not required to fix the problem but could wait
> for 3.9 instead. You definitely have my Ack if you are willing
> to take it for 3.8 though.
> 
> Shawn or Sascha should be able to test it.
> 
Alan,

Thanks for the patch.  I just gave it try.  The USB Host port still
works for me with a couple of fixes on your changes integrated (one
for compiling and the other for probing).  So you have my ACK with
the changes below rolled into your patch.

Acked-by: Shawn Guo <shawn.guo@linaro.org>

---8<----

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 177b354..a685945 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -37,7 +37,7 @@

 #define DRIVER_DESC "Freescale On-Chip EHCI Host driver"

-static const char hcd_name[] = "ehci-mxc";
+static const char hcd_name[] = "mxc-ehci";

 #define ULPI_VIEWPORT_OFFSET   0x170

@@ -48,7 +48,7 @@ struct ehci_mxc_priv {
 static struct hc_driver __read_mostly ehci_mxc_hc_driver;

 static const struct ehci_driver_overrides ehci_mxc_overrides __initdata = {
-       .extra_priv_size =      sizeof(struct ehci_mxc_priv);
+       .extra_priv_size =      sizeof(struct ehci_mxc_priv),
 };

 static int ehci_mxc_drv_probe(struct platform_device *pdev)
