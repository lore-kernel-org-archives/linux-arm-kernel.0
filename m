From: horms@verge.net.au (Simon Horman)
Date: Sat, 25 May 2013 09:59:08 +0900
Subject: [PATCH] ARM: shmobile: marzen: Use error values in usb_power_*
In-Reply-To: <519D217D.2060405@cogentembedded.com>
References: <1369205290-6272-1-git-send-email-horms+renesas@verge.net.au>
 <1369205290-6272-2-git-send-email-horms+renesas@verge.net.au>
 <519D217D.2060405@cogentembedded.com>
Message-ID: <20130525005908.GE4476@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 11:50:21PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/22/2013 10:48 AM, Simon Horman wrote:
> 
> >This patch updates the marzen board code as if USB PHY isn't enabled
> >they phy will have a value set by ERR_PTR() rather than be NULL.
> >
> >Without this patch a NULL pointer dereference  and kernel panic
> >occurs on initialisation of USB on marzen.
> >
> >This resolves a regression introduced in 3.10-rc1 by
> >b7fa5c2aec5be083eb2719b405089703608e9bc6
> >("usb: phy: return -ENXIO when PHY layer isn't enabled").
> >
> >Tested-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/board-marzen.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> >index 9105285..b9594e9 100644
> >--- a/arch/arm/mach-shmobile/board-marzen.c
> >+++ b/arch/arm/mach-shmobile/board-marzen.c
> >@@ -212,8 +212,8 @@ static struct platform_device *marzen_devices[] __initdata = {
> >  static struct usb_phy *phy;
> >  static int usb_power_on(struct platform_device *pdev)
> >  {
> >-	if (!phy)
> >-		return -EIO;
> >+	if (IS_ERR(phy))
> 
>    And even before the mentioned commit the right check should have
> been IS_ERR_OR_NULL().

Yes, quite true.

> Thanks for finding/fixing this. Too bad I'll have to respin my USB
> patches now... :-)
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
