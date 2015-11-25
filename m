From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Nov 2015 09:04:19 -0800
Subject: [PATCH v3 4/8] phy: rockchip-usb: add compatible values for
 rk3066a and rk3188
In-Reply-To: <1586601.dy8rrhuEYg@phil>
References: <1447968149-10979-1-git-send-email-heiko@sntech.de>
 <1447968149-10979-5-git-send-email-heiko@sntech.de>
 <CAD=FV=V=5vP4a32Gonkv+vw7E+B=tP1VoWSfLA6YTh8knJZcfg@mail.gmail.com>
 <1586601.dy8rrhuEYg@phil>
Message-ID: <CAD=FV=VsidpT1K8ZXQf_2WONVdYFjM5_7V-ENHkSTdB3BoETEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 22, 2015 at 11:49 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Donnerstag, 19. November 2015, 16:32:23 schrieb Doug Anderson:
>> Heiko,
>>
>> On Thu, Nov 19, 2015 at 1:22 PM, Heiko Stuebner <heiko@sntech.de> wrote:
>> > We need custom handling for these two socs in the driver shortly,
>> > so add the necessary compatible values to binding and driver.
>> >
>> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> > ---
>> >  Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt | 5 ++++-
>> >  drivers/phy/phy-rockchip-usb.c                             | 2 ++
>> >  2 files changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
> b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
>> > index 826454a..9b37242 100644
>> > --- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
>> > +++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
>> > @@ -1,7 +1,10 @@
>> >  ROCKCHIP USB2 PHY
>> >
>> >  Required properties:
>> > - - compatible: rockchip,rk3288-usb-phy
>> > + - compatible: matching the soc type, one of
>> > +     "rockchip,rk3066a-usb-phy"
>> > +     "rockchip,rk3188-usb-phy"
>> > +     "rockchip,rk3288-usb-phy"
>>
>> I can never quite keep it straight how this is supposed to work, but
>> since previously only "rockchip,rk3288-usb-phy" was supported and now
>> we have these new compatible strings, I would have expected the new
>> strings to specify the old ones as fallback.  That would mean your
>> choices would be:
>>
>> - "rockchip,rk3288-usb-phy" - A real rk3288
>> - "rockchip,rk3188-usb-phy", "rockchip,rk3288-usb-phy" - A rk3188 with
>> fallback to 3288 driver.
>> - "rockchip,rk3066a-usb-phy", "rockchip,rk3288-usb-phy" - A rk3066a
>> with fallback to 3288 driver.
>
> How this is supposed to be done also is sometimes confusing for me :-)
>
> But I don't think that specifying the "fallbacks" is part of the binding at
> all, when the binding really is done in a soc-specific way.  For example
> following the suggestion of the dt-maintainers at the time we're specifying
> the uarts as
>
>         compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart"
>
> as a measure to use a more-special driver if there is ever the need for it.
> But here the "snps,dw-apb-uart" actually is a superset (a more generic
> implementation), while in the usb-uart-case

Hrm, this gets into the whole issue of coming up with generic names.
It's not always easy, especially when marketing gets involved.  If
Synopsis comes up with a new APB UART that's not compatible, I guess
you call it a v2 and people just need to figure out which one they
have?  I remember it being terribly confusing with exynos since
Samsung called things "exynos" that were very different, and I think
even "exynos5" devices were pretty different form each other.  Anyway,
that's getting pretty far afield.

The general way of doing things in Linux is that the first driver
there becomes the generic, right?  So if the first supported SoC using
this PHY was rk3288 then it gets the name and becomes the generic.  If
rk3066a and 3188 are 90% the same and initially can actually use the
same driver, then they specify the specific "3188" and the generic
"3288" as a fallback.  It sounds like that was what was actually done
in the DTS files anyway, which is right as far as I'm concerned.

...but personally I'd love to see it documented.  ...someone reading
the binding should be able to create a DTS and it's not obvious from
the DTS that "rk3288" is the generic as far as this binding is
concerned.

Quite honestly, though, it's not terribly important to me and
definitely not something I feel like I can make a call on.  If you
feel strongly about keeping it the way you have it and nobody else has
any objections, I won't yell.

-Doug
