From: balbi@ti.com (Felipe Balbi)
Date: Fri, 24 Oct 2014 15:25:10 -0500
Subject: [PATCH v2 1/5] phy: berlin-sata: Move PHY_BASE into private data
 struct
In-Reply-To: <544AB33F.9030701@gmail.com>
References: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1413882477-27922-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <54462865.6000205@ti.com> <544629F0.3090505@gmail.com>
 <544AB33F.9030701@gmail.com>
Message-ID: <20141024202510.GK11455@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 24, 2014 at 10:14:55PM +0200, Sebastian Hesselbarth wrote:
> On 21.10.2014 11:40, Sebastian Hesselbarth wrote:
> >On 10/21/2014 11:33 AM, Kishon Vijay Abraham I wrote:
> >>On Tuesday 21 October 2014 02:37 PM, Sebastian Hesselbarth wrote:
> >>>Currently, Berlin SATA PHY driver assumes PHY_BASE address being
> >>>constant. While this PHY_BASE is correct for BG2Q, older BG2 PHY_BASE
> >>>is different. Prepare the driver for BG2 support by moving the phy_base
> >>>into private driver data.
> >>>
> >>>Acked-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> >>>Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >...
> >>>---
> >>>  drivers/phy/phy-berlin-sata.c | 42
> >>>++++++++++++++++++++++++++++--------------
> >>>  1 file changed, 28 insertions(+), 14 deletions(-)
> >>>
> >>>diff --git a/drivers/phy/phy-berlin-sata.c
> >>>b/drivers/phy/phy-berlin-sata.c
> >>>index 69ced52d72aa..9682b0f66177 100644
> >>>--- a/drivers/phy/phy-berlin-sata.c
> >>>+++ b/drivers/phy/phy-berlin-sata.c
> >>>@@ -30,7 +30,7 @@
> >>>  #define MBUS_WRITE_REQUEST_SIZE_128    (BIT(2) << 16)
> >>>  #define MBUS_READ_REQUEST_SIZE_128    (BIT(2) << 19)
> >>>
> >>>-#define PHY_BASE        0x200
> >>>+#define BG2Q_PHY_BASE        0x200
> >[...]
> >>>+static u32 bg2q_sata_phy_base = BG2Q_PHY_BASE;
> >>>+
> >>>+static const struct of_device_id phy_berlin_sata_of_match[] = {
> >>>+    {
> >>>+        .compatible = "marvell,berlin2q-sata-phy",
> >>>+        .data = &bg2q_sata_phy_base,
> >>
> >>Can't the base directly come from dt?
> >
> >You are suggesting a "marvell,phy-base-address" property, right?
> >I have no strong opinion about it, I accept your call (or DT maintainer
> >ones).
> 
> Kishon,
> 
> I still have the DT patches for BG2Q queued up for v3.19 (I missed the
> arm-soc merge window for v3.18). That means, there has been no release
> with the phy binding used and I can rework a little more.
> 
> Can you please confirm that you want a DT property for the phy base address,
> e.g. marvell,phy-base-address = <{0x200,0x80}> ?
> 
> If so, I'd also rename the compatible from berlin2q-sata-phy to more
> generic berlin-sata-phy.

I think what Kishon is asking, is why this 0x200 offset isn't already on
reg. so that instead of, e.g.:

	reg = <0x40000000 0x1000>;

you would have:

	reg = <0x40000200 0x1000>;

then everybody's happy. It's unfortunate, however, that we already
shipped DT sources with the bogus (?) reg property and now we have to
support that broken binding. My suggestion would be to add a new
compatible which comes with proper reg property and still add that weird
phy_base for the old compatible, so that:

	if (of_device_is_compatible(node, "marvell,berlin2q-sata-phy"))
		phy->phy_base = PHY_BASE;

then, if new compatible comes with proper 'reg', phy->phy_base would be
zero and everything should still work. How does this sound ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141024/bb1c1c64/attachment.sig>
