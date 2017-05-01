From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 01 May 2017 16:07:38 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: Move cros-ec-sbs to
 rk3288-veyron-chromebook-sbs
In-Reply-To: <1493585812.6493.4.camel@paulk.fr>
References: <20170430183054.24563-1-contact@paulk.fr>
 <2369975.a4dWayqU5d@phil> <1493585812.6493.4.camel@paulk.fr>
Message-ID: <2337202.q9Cdx8Nyxy@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 30. April 2017, 22:56:52 CEST schrieb Paul Kocialkowski:
> Le dimanche 30 avril 2017 ? 22:37 +0200, Heiko Stuebner a ?crit :
> > Hi Paul,
> > 
> > Am Sonntag, 30. April 2017, 20:30:52 CEST schrieb Paul Kocialkowski:
> > > This moves the cros-ec-sbs dtsi to a new rk3288-veyron-chromebook-sbs
> > > dtsi since it only concerns rk3288 veyron Chromebooks.
> > > 
> > > Other Chromebooks (such as the tegra124 nyans) also have sbs batteries
> > > and don't use this dtsi, that only makes sense when used with
> > > rk3288-veyron-chromebook anyway.
> > 
> > That isn't true. The gru series (rk3399-based) also uses the
> > sbs-battery [0]. And while it is currently limited to Rockchip-based
> > Chromebooks it is nevertheless used on more than one platform, so
> > the probability is high that it will be used in future series as well.
> 
> That's good to know, but as pointed out, other cros devices are using a sbs
> battery without this header, so such a generic name isn't really a good fit.
> 
> Note that &charger has to be defined (after my subsequent patches), which it is
> for devices that also include rk3288-veyron-chromebook, but not necessarily
> others.
> 
> Overall, I think having one -sbs dtsi file makes sense here because there is
> already a rk3288-veyron-chromebook dtsi that veyron chromebooks use. That file
> cannot contain the battery bindings because minnie has a different one and it
> would be a bit silly to copy it over all devices. That definitely makes sense.
> 
> As for other devices, I don't see why we should have a separate include file for
> the battery instead of having it in the device's dts. I think this should be the
> case on gru/kevin.
> 
> Also maybe not *all* gru-based devices will turn out to use a SBS battery, so it
> seems early to include this header in the gru dtsi. One last point, gru/kevin
> currently don't define a charger, which will break my subsequent patch (that is
> however needed for the veyrons that use this file).
> 
> To me, it seems that there's little advantage and major drawbacks in keeping
> this file the way it is.

I don't have any set opinion right now but after looking through the
other uses of the sbs-battery the cros-ec-sbs.dtsi snippet really seems
somewhat veyron/gru-specific - especially wrt. the retry-count values.

What I'm not sure about is whether it is actually better to keep the include
around under a new name or just move the (rather tiny) sbs-battery node
into the relevant devicetrees directly, when there aren't that many users
anyway.


Heiko

> 
> > Also, it might be nice to also include some Chromeos people (there should
> > be some in the git logs, like Brian who submitted the Gru patches), as they
> > might be able to provide more detailed input.
> 
> That's a good point, thanks for including them.
> 
> > 
> > Heiko
> > 
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/a
> > rch/arm64/boot/dts/rockchip/rk3399-gru.dtsi#n886
> > 
> > > 
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > ---
> > >  .../boot/dts/{cros-ec-sbs.dtsi => rk3288-veyron-chromebook-sbs.dtsi}    | 0
> > >  arch/arm/boot/dts/rk3288-veyron-jaq.dts                                 | 2
> > > +-
> > >  arch/arm/boot/dts/rk3288-veyron-jerry.dts                               | 2
> > > +-
> > >  arch/arm/boot/dts/rk3288-veyron-pinky.dts                               | 2
> > > +-
> > >  arch/arm/boot/dts/rk3288-veyron-speedy.dts                              | 2
> > > +-
> > >  5 files changed, 4 insertions(+), 4 deletions(-)
> > >  rename arch/arm/boot/dts/{cros-ec-sbs.dtsi => rk3288-veyron-chromebook-
> > > sbs.dtsi} (100%)
> > > 
> > > diff --git a/arch/arm/boot/dts/cros-ec-sbs.dtsi b/arch/arm/boot/dts/rk3288-
> > > veyron-chromebook-sbs.dtsi
> > > similarity index 100%
> > > rename from arch/arm/boot/dts/cros-ec-sbs.dtsi
> > > rename to arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi
> > > diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> > > b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> > > index d33f5763c39c..f217a978e47a 100644
> > > --- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> > > +++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> > > @@ -45,7 +45,7 @@
> > >  /dts-v1/;
> > >  
> > >  #include "rk3288-veyron-chromebook.dtsi"
> > > -#include "cros-ec-sbs.dtsi"
> > > +#include "rk3288-veyron-chromebook-sbs.dtsi"
> > >  
> > >  / {
> > >  	model = "Google Jaq";
> > > diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
> > > b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
> > > index cdea751f2a8c..bec607574165 100644
> > > --- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
> > > +++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
> > > @@ -44,7 +44,7 @@
> > >  
> > >  /dts-v1/;
> > >  #include "rk3288-veyron-chromebook.dtsi"
> > > -#include "cros-ec-sbs.dtsi"
> > > +#include "rk3288-veyron-chromebook-sbs.dtsi"
> > >  
> > >  / {
> > >  	model = "Google Jerry";
> > > diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
> > > b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
> > > index 995cff42fa43..c81ad5bf1121 100644
> > > --- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
> > > +++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
> > > @@ -44,7 +44,7 @@
> > >  
> > >  /dts-v1/;
> > >  #include "rk3288-veyron-chromebook.dtsi"
> > > -#include "cros-ec-sbs.dtsi"
> > > +#include "rk3288-veyron-chromebook-sbs.dtsi"
> > >  
> > >  / {
> > >  	model = "Google Pinky";
> > > diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> > > b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> > > index cc0b78cefe34..8aea9c3ff6e2 100644
> > > --- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> > > +++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> > > @@ -44,7 +44,7 @@
> > >  
> > >  /dts-v1/;
> > >  #include "rk3288-veyron-chromebook.dtsi"
> > > -#include "cros-ec-sbs.dtsi"
> > > +#include "rk3288-veyron-chromebook-sbs.dtsi"
> > >  
> > >  / {
> > >  	model = "Google Speedy";
> > > 
> > 
> > 
> 
