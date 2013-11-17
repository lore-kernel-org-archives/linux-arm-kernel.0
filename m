From: sre@ring0.de (Sebastian Reichel)
Date: Sun, 17 Nov 2013 00:26:00 +0000
Subject: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
In-Reply-To: <5287AB20.9070407@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk>
 <20131116141853.GF10317@atomide.com>
 <5287908C.3040602@collabora.co.uk>
 <20131116154507.GL10317@atomide.com>
 <20131116160234.GB5104@earth.universe>
 <5287AB20.9070407@collabora.co.uk>
Message-ID: <20131117002600.GA14253@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Sat, Nov 16, 2013 at 06:28:00PM +0100, Javier Martinez Canillas wrote:
> > The hack, as being sent by Javier, will result in the wrong
> > regulator being used on the Nokia N900, which is using vaux1.
> > It must depend on the machine.
> 
> I see, so this hack is not generic enough to be usable for all OMAP3 boards so I
> think is better to just add the hack on the DTS.
>
> I was more found about adding a hack on dpi.c since the DTB is an stable ABI
> while the dpi.c implementation is not.

I agree with this. My suggestion would be to get the vdds_dsi regulator name
from platform data. This way each board can setup its own quirk until omapdss
supports DT.

> But I guess is not that bad to change the DTS later once DSS DT
> bindings are added to mainline.

As far as I know DT bindings are supposed to be as stable as
possible.

> > At the same time the N900 device tree file uses V28 as
> > regulator-name for vaux1 (which is the same one as legacy boot
> > used). Nothing depends on this, but I don't think it's a
> > good idea to use this property. Apparently it does not work
> > if multiple drivers need the same regulator under different
> > names.
> > 
> > -- Sebastian
> > 
> 
> So, what do you think about the following patch instead?
> 
> [PATCH]

For Nokia N900 vaux1 is also used for si4713 radio chip, lis3lv02d
accelerometer and battery cover sensor, so I don't like this hack.

If vppl2 is only used for omapdss.dsi on IGEP boards it might be
sensible to label it, though? So it might be ok there.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131117/26845e61/attachment.sig>
