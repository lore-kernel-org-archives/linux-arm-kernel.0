From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 5 Jun 2015 14:23:14 +0200
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply
 regulators
In-Reply-To: <23123577.mOoqGCAPdL@diego>
References: <4184159.j0iXe39dFB@phil> <2619686.csNBBFyt8W@phil>
 <20150605110159.GA16254@ulmo.nvidia.com>
 <23123577.mOoqGCAPdL@diego>
Message-ID: <20150605122311.GA759@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 02:16:40PM +0200, Heiko St?bner wrote:
> Hi Thierry
> 
> Am Freitag, 5. Juni 2015, 13:02:01 schrieb Thierry Reding:
> > On Mon, Mar 23, 2015 at 07:17:49PM +0100, Heiko Stuebner wrote:
> > > Hi Philipp,
> > > 
> > > Am Donnerstag, 12. M?rz 2015, 21:45:19 schrieb Heiko Stuebner:
> > > > At least the Rockchip variant of the dw_hdmi can have controllable power
> > > > supplies providing 1.0 and 1.8V. Therefore add the possibility for the
> > > > generic bridge driver to enable supplies provided by the hw-specific
> > > > drivers.
> > > > 
> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > 
> > > does this look ok now?
> > > 
> > > And as we talked about in Chemnitz, who will be taking such bridge-related
> > > changes, as you mentioned some last bridge-patches going through Thierry.
> > 
> > Sorry, I had completely missed this.
> > 
> > > > ---
> > > > changes since v2:
> > > > - rename supplies to the names found in the hdmi IP databook
> > > > changes since v1:
> > > > - follow suggestion from Russell King to keep regulator handling local
> > > > 
> > > >   to the rockchip implementation for the time being and only generalize
> > > >   when a real second implementation needs regulator handling
> > > >  
> > > >  .../devicetree/bindings/drm/bridge/dw_hdmi.txt     |  5 ++++
> > > >  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 32
> > > > 
> > > > +++++++++++++++++++++- 2 files changed, 36 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> > > > b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt index
> > > > a905c14..bb74640 100644
> > > > --- a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> > > > +++ b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
> > > > @@ -22,6 +22,11 @@ Optional properties
> > > > 
> > > >  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
> > > >  - clocks, clock-names: phandle to the HDMI CEC clock, name should be
> > > >  "cec"
> > > > 
> > > > +Optional supplies:
> > > > +rockchip,rk3288-dw-hdmi handles two optional power supplies:
> > > > +- vp-supply: 1.0V power supply
> > > > +- vph-supply: 1.8V power supply
> > 
> > If this is specific to the Rockchip implementation, shouldn't this go
> > into Documentation/devicetree/bindings/video/dw_hdmi-rockchip.txt? It
> > could then simply go into the Rockchip DRM tree.
> 
> actually, we determined that the supply names are universal to the IP (both in 
> imx and rockchip and probably more if there are more users out there). Just 
> Russell requested that we don't pollute the generic code until necessary, as 
> it looks like the supply of those is somehow handled internally on the imx.

If it's universal then there should be no need to mention the Rockchip
compatible specifically. Also, it might be better to submit this as two
separate patches, one for the binding and another for the driver.

I could extract the DT binding piece myself and apply only that, then
somebody else can apply the Rockchip change to that driver separately.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150605/67ff55f7/attachment.sig>
