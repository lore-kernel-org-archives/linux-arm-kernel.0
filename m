From: marcus.folkesson@gmail.com (Marcus Folkesson)
Date: Sat, 10 Feb 2018 21:12:07 +0100
Subject: [PATCH v2 5/7] watchdog: mtk: allow setting timeout in devicetree
In-Reply-To: <20180210124328.GB744@gmail.com>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
 <20180210091911.3644-5-marcus.folkesson@gmail.com>
 <1518261002.9025.36.camel@mtkswgap22>
 <20180210124328.GB744@gmail.com>
Message-ID: <20180210201207.GC744@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sean,

On Sat, Feb 10, 2018 at 01:43:28PM +0100, Marcus Folkesson wrote:
> Hello Sean,
> 
> On Sat, Feb 10, 2018 at 07:10:02PM +0800, Sean Wang wrote:
> > 
> > Hi, Marcus
> > 
> > The changes you made for dt-bindings and driver should be put into
> > separate patches.
> 
> I actually thought about it but chose to have it in the same patch because I
> did not see any direct advantage to separating them.
> 
> But I can do that.
> I will come up with a v3 with this change if no one thinks differently.
> 

When looking at the git log, I'm not that convinced it should be
separate patches.

For example, I found a4f741e3e157c3a5c8aea5f2ea62b692fbf17338 that is
doing the exact same thing as this patch.

There is plenty of patches that mixes the code change and dt bindings
updates.
Could it not be useful to overview both the implementation and
dt-mapping change in one view?

If you or anyone else still think it should be separated, please let me know and I will
come up with a v3.


> > 
> > And the property timeout-sec seems to be generic enough to all devices,
> > so why not add a common document to describe it and allow those devices
> > to refer to, like other dt-bindings for other kinds of devices usually
> > did.
> 
> It should be, but it requires that the driver is using
> watchdog_init_timeout() to set timeout, most of the drivers does not.
> Most drivers does not even use the watchdog API but register itself as
> misc devices.
> 
> When we have all wdt drivers using the watchdog API, we should probably
> move the dt-binding to a common document.
> 
> > 
> > 	Sean
> > 
> 
> Thanks,
> 
> Best regards
> Marcus Folkesson
> 
> > On Sat, 2018-02-10 at 10:19 +0100, Marcus Folkesson wrote:
> > > watchdog_init_timeout() will allways pick timeout_param since it
> > > defaults to a valid timeout.
> > > 
> > > By following best practice described in
> > > Documentation/watchdog/watchdog-kernel-api.txt, it also
> > > let us to set timout-sec property in devicetree.
> > > 
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
> > >  drivers/watchdog/mtk_wdt.c                             | 2 +-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > > index 5b38a30e608c..859dee167b91 100644
> > > --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > > +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > > @@ -11,9 +11,13 @@ Required properties:
> > >  
> > >  - reg : Specifies base physical address and size of the registers.
> > >  
> > > +Optional properties:
> > > +- timeout-sec: contains the watchdog timeout in seconds.
> > > +
> > >  Example:
> > >  
> > >  wdt: watchdog at 10000000 {
> > >  	compatible = "mediatek,mt6589-wdt";
> > >  	reg = <0x10000000 0x18>;
> > > +	timeout-sec = <10>;
> > >  };
> > > diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> > > index 7ed417a765c7..fcdc10ec28a3 100644
> > > --- a/drivers/watchdog/mtk_wdt.c
> > > +++ b/drivers/watchdog/mtk_wdt.c
> > > @@ -57,7 +57,7 @@
> > >  #define DRV_VERSION		"1.0"
> > >  
> > >  static bool nowayout = WATCHDOG_NOWAYOUT;
> > > -static unsigned int timeout = WDT_MAX_TIMEOUT;
> > > +static unsigned int timeout;
> > >  
> > >  struct mtk_wdt_dev {
> > >  	struct watchdog_device wdt_dev;
> > 
> > 

Best regards
Marcus Folkesson


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180210/cb6c907b/attachment-0001.sig>
