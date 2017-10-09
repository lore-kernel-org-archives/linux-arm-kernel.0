From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 9 Oct 2017 11:25:54 +0800
Subject: [PATCH 12/12] dt-bindings: usb: mtu3: remove optional pinctrls
In-Reply-To: <20171005223325.ryvu6ifjgcj5scf4@rob-hp-laptop>
References: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
 <ec8e65205c6e0a83850e11c030ed440d7b9be2e8.1506509659.git.chunfeng.yun@mediatek.com>
 <20171005223325.ryvu6ifjgcj5scf4@rob-hp-laptop>
Message-ID: <1507519554.17567.65.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-10-05 at 17:33 -0500, Rob Herring wrote:
> On Thu, Sep 28, 2017 at 08:17:20AM +0800, Chunfeng Yun wrote:
> > Remove optional pinctrls due to using FORCE/RG_IDDIG to implement
> > manual switch function.
> 
> Another not backwards compatible change. Please explain why that is 
> okay.
The old way of manual switch function uses the IDDIG pin (IDPIN) to
switch mode between device and host indirectly by pulling up or pulling
down it by driver. But there is a limitation, when the IDDIG pin is
connected to the ground, the driver can't pull it up anymore, so it will
fail when the receptacle is micro type.
And there is no such limitation through FORCE/RG_IDDIG, because when the
FORCE_IDDIG is set, the staus of RG_IDDIG is given higher priority than
IDDIG pin. So it is okay no matter whether id_float and id_ground pins
are provided or not.
 
> 
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mediatek,mtu3.txt      |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > index 49c982b..b2271d8 100644
> > --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > @@ -30,9 +30,10 @@ Optional properties:
> >  	when supports dual-role mode.
> >   - vbus-supply : reference to the VBUS regulator, needed when supports
> >  	dual-role mode.
> > - - pinctl-names : a pinctrl state named "default" must be defined,
> > -	"id_float" and "id_ground" are optinal which depends on
> > -	"mediatek,enable-manual-drd"
> > + - pinctrl-names : a pinctrl state named "default" is optional, and need be
> > +	defined if auto drd switch is enabled, that means the property dr_mode
> > +	is set as "otg", and meanwhile the property "mediatek,enable-manual-drd"
> > +	is not set.
> >   - pinctrl-0 : pin control group
> >  	See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> >  
> > -- 
> > 1.7.9.5
> > 
