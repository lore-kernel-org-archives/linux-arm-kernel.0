From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Aug 2018 13:22:35 +0200
Subject: [PATCH 2/4] dt-bindings: phy-rockchip-inno-usb2: add
 documentation for extcon and utmi-avalid properties.
In-Reply-To: <37512ec9-8d9a-6c0c-8808-6351b8501002@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <2023816.cqyDmH3see@phil>
 <37512ec9-8d9a-6c0c-8808-6351b8501002@collabora.com>
Message-ID: <4665926.GcjFtTh8TS@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

Am Mittwoch, 15. August 2018, 13:08:00 CEST schrieb Enric Balletbo i Serra:
> On 15/08/18 12:29, Heiko Stuebner wrote:
> > Am Mittwoch, 15. August 2018, 11:59:32 CEST schrieb Enric Balletbo i Serra:
> >> Commit 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for
> >> rk3399") introduces two new properties. The extcon property is used to
> >> detect the cable-state, and the rockchip,utmi-avalid is used to indicate
> >> which register should be used to detect the vbus state.
> >>
> >> Document these properties in the documentation binding.
> >>
> >> Fixes: 98898f3bc83c8 ("phy: rockchip-inno-usb2: support otg-port for rk3399")
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[...]

> >> @@ -45,6 +46,8 @@ Required properties (port (child) node):
> >>  Optional properties:
> >>   - phy-supply : phandle to a regulator that provides power to VBUS.
> >>  		See ./phy-bindings.txt for details.
> >> + - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
> >> +			  Otherwise, use the bvalid register.
> > 
> > Not having looked to deeply into the usb2 phy, this might raise questions
> > on why this is a hardware-description? Is this needed when something is not
> > connected on the board?
> 
> I asked myself the same question and even I thought in just remove that code.
> 
> After some investigation, though, I saw that the UTMI+ specification [1] has two
> signals similar to ID signal (page 11), the AValid signal is used to indicate if
> the session for an A-peripheral is valid and the BValid signal that is used to
> indicate if the session for a B-peripheral is valid. I suppose that use of one
> or the other matters in some cases, but AFAICT this is not used and I didn't see
> any binding using it.
> 
> Maybe someone else can give us more clues on the importance or not of this property?

so I've looked in mainline, chromeos-4.4 and the Rockchip vendor-kernel
and the only board using that property at all is the rk3399-evb-rev1
and -rev2 in the vendor kernel.

The existence of a further -rev3 (which also looks way better cared for
compared rev1+2) indicates that the older ones are probably some sort
of preproduction models, where some wiring (on the soc or board) may
have gone wrong.

So while I would keep all the avalid settings in the driver, we could just
drop reading that property quietly - as Rob wrote some days ago
"it's only an incompatible change if someone notices" [0] and from the
above it doesn't look like it ;-) .

Heiko

[0] https://www.spinics.net/lists/devicetree/msg243978.html
