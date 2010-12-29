From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 29 Dec 2010 18:30:15 +0800
Subject: [PATCH 03/10] net/fec: add mac field into platform data and
	consolidate fec_get_mac
In-Reply-To: <20101229065329.GB31010@jasper.tkos.co.il>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-4-git-send-email-shawn.guo@freescale.com>
	<20101229065329.GB31010@jasper.tkos.co.il>
Message-ID: <20101229103014.GD19347@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, Baruch.  I missed two comments in the last reply.

On Wed, Dec 29, 2010 at 08:53:30AM +0200, Baruch Siach wrote:
> Hi Shawn,
> 
> Please add netdev at vger.kernel.org to the Cc of all your fec driver patches.
> 
I was aware of this after I sent out the patch set last night.
Can I just resend all the patches in v2 and get netdev at vger.kernel.org
included?

> On Tue, Dec 28, 2010 at 10:55:48PM +0800, Shawn Guo wrote:
[...]
> > +	/*
> > +	 * try to get mac address in following order:
> > +	 *
> > +	 * 1) kernel command line fec_mac=xx:xx:xx...
> > +	 */
> > +	iap = fec_mac_default;
> > +
> > +	/*
> > +	 * 2) from flash or fuse (via platform data)
> > +	 */
> 
> Again, how do you handle the dual MAC case?
> 
For the platform data case, the following patch reads both mac
addresses.

[PATCH 09/10] ARM: mx28: read fec mac address from ocotp

+static int __init mx28evk_fec_get_mac(void)
+{
+       int i, ret;
+       u32 val;
+
+       /*
+        * OCOTP only stores the last 4 octets for each mac address,
+        * so hard-coding the first two octets as Freescale OUI (00:04:9f)
+        * is needed.
+        */
+       for (i = 0; i < 2; i++) {
+               ret = mxs_read_ocotp(0x20 + i * 0x10, 1, &val);
+               if (ret)
+                       goto error;
+
+               mx28_fec_pdata[i].mac[0] = 0x00;
+               mx28_fec_pdata[i].mac[1] = 0x04;
+               mx28_fec_pdata[i].mac[2] = (val >> 24) & 0xff;
+               mx28_fec_pdata[i].mac[3] = (val >> 16) & 0xff;
+               mx28_fec_pdata[i].mac[4] = (val >> 8) & 0xff;
+               mx28_fec_pdata[i].mac[5] = (val >> 0) & 0xff;
+       }
+
+       return 0;
+
+error:
+       pr_err("%s: timeout when reading fec mac from OCOTP\n", __func__);
+       return -ETIMEDOUT;
+}
+

-- 
Regards,
Shawn
