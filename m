From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 27 Aug 2018 09:11:37 +0200
Subject: [PATCH v4 1/2] devicetree/bindings: display: Add document for
 rockchip RGB output
In-Reply-To: <725cc93f-a441-22bc-ef58-b4b38ec34e17@rock-chips.com>
References: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
 <20180703182559.GA12809@rob-hp-laptop>
 <725cc93f-a441-22bc-ef58-b4b38ec34e17@rock-chips.com>
Message-ID: <7915686.3ERLj9EHQN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sandy,

trying to move this forward a bit :-)

Am Mittwoch, 4. Juli 2018, 14:09:56 CEST schrieb Sandy Huang:
> Hi Rob Herring,
> Thanks for your review.
> 
> ? 2018/7/4 2:25, Rob Herring ??:
> > On Tue, Jun 26, 2018 at 03:15:39PM +0800, Sandy Huang wrote:
> >> This path add support rv1108 and px30 rgb output interface driver.
> > 
> > Bindings are for h/w, not drivers.
> > 
> I will update at next version as following:
> This patch add support rv1108 and px30 rgb output interface
> >>
> >> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> >> Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc at rock-chips.com
> >> ---
> >>
> >> Changes in v4: Add support px30
> >> Changes in v3: None
> >> Changes in v2: None
> >>
> >> .../bindings/display/rockchip/rockchip-rgb.txt     | 73 ++++++++++++++++++++++
> >>   1 file changed, 73 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >> new file mode 100644
> >> index 0000000..077b9ad
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >> @@ -0,0 +1,73 @@
> >> +Rockchip RV1108 RGB interface
> >> +================================
> >> +
> >> +Required properties:
> >> +- compatible: matching the soc type:
> >> +	- "rockchip,px30-rgb";
> >> +	- "rockchip,rv1108-rgb";
> > 
> > This doesn't look right? What (and how) is getting programmed here
> > because you don't have any register interface.
> > 
> This is register for DRM encoder and connecter or bridge for some RGB 
> convert chips driver.
> so far we don't have any register for rgb interface, but it's most 
> probable need to config some register for rgb interface in feauture for 
> rockchip platform.

I think the basic-issue Rob was pointing out is that the devicetree
describes hardware blocks and not the software representation.

And the rgb output is not a separate block, but instead just a property
of the vop itself, hence should possibly not have a separate "device".

As I'm currently tinkering with rk3188 display support [0] - which only has
rgb output at all - I modified your patch a bit to to showcase how that
could look [1], where the soc vop struct simply has a feature flag
indicating indicating a raw rgb output and the rgb driver then
looks for bridges in the vop endpoints to distinguish them from
soc-internals output encoders.

Let me know what you think :-)
Heiko

[0] https://github.com/mmind/linux-rockchip/commits/wip/rk3188-lcdc
[1] https://github.com/mmind/linux-rockchip/commit/fe74d2c4d76bcb6035b7207753e6afb85335b6cd
needs also https://github.com/mmind/linux-rockchip/commit/c5a48c772f3564211dcd1ec71004de1d6dbb0307
