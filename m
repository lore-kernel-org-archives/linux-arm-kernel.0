From: dianders@chromium.org (Doug Anderson)
Date: Mon, 1 May 2017 08:49:02 -0700
Subject: [PATCH 1/3] ARM: dts: rockchip: Move cros-ec-sbs to
 rk3288-veyron-chromebook-sbs
In-Reply-To: <2337202.q9Cdx8Nyxy@phil>
References: <20170430183054.24563-1-contact@paulk.fr> <2369975.a4dWayqU5d@phil>
 <1493585812.6493.4.camel@paulk.fr> <2337202.q9Cdx8Nyxy@phil>
Message-ID: <CAD=FV=V_s0TE_2vUvDBYfmbt2VS0nk5gmSPLi+mh2sqGauj6dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 1, 2017 at 7:07 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Sonntag, 30. April 2017, 22:56:52 CEST schrieb Paul Kocialkowski:
>> Le dimanche 30 avril 2017 ? 22:37 +0200, Heiko Stuebner a ?crit :
>> > Hi Paul,
>> >
>> > Am Sonntag, 30. April 2017, 20:30:52 CEST schrieb Paul Kocialkowski:
>> > > This moves the cros-ec-sbs dtsi to a new rk3288-veyron-chromebook-sbs
>> > > dtsi since it only concerns rk3288 veyron Chromebooks.
>> > >
>> > > Other Chromebooks (such as the tegra124 nyans) also have sbs batteries
>> > > and don't use this dtsi, that only makes sense when used with
>> > > rk3288-veyron-chromebook anyway.
>> >
>> > That isn't true. The gru series (rk3399-based) also uses the
>> > sbs-battery [0]. And while it is currently limited to Rockchip-based
>> > Chromebooks it is nevertheless used on more than one platform, so
>> > the probability is high that it will be used in future series as well.
>>
>> That's good to know, but as pointed out, other cros devices are using a sbs
>> battery without this header, so such a generic name isn't really a good fit.

It would be interesting to know if the "retry-count" ought to be the
same across all Chromebooks.  I guess you could argue that maybe
someone found it needed to be 10 in all "nyan" variants and needed to
be 1 in all "veyron" variants, but it seems more likely that the
difference is arbitrary, or that one of the two values would work for
everyone.  It sure looks like we've just been copying values from
device to device.  Given that all the "veyron" devices have vastly
different batteries (and probably all the nyan ones too), it seems
likely there ought to be one value.

In terms of setting the "charger", that also could potentially be
something that could be for all Chromebooks, or at least older ones
that don't have their charger implemented by the type C driver.  ...or
nyan devices could simply have a line in their dts like:

&battery {
  power-supplies = <&charger>;
};


>> Note that &charger has to be defined (after my subsequent patches), which it is
>> for devices that also include rk3288-veyron-chromebook, but not necessarily
>> others.
>>
>> Overall, I think having one -sbs dtsi file makes sense here because there is
>> already a rk3288-veyron-chromebook dtsi that veyron chromebooks use. That file
>> cannot contain the battery bindings because minnie has a different one and it
>> would be a bit silly to copy it over all devices. That definitely makes sense.
>>
>> As for other devices, I don't see why we should have a separate include file for
>> the battery instead of having it in the device's dts. I think this should be the
>> case on gru/kevin.
>>
>> Also maybe not *all* gru-based devices will turn out to use a SBS battery, so it
>> seems early to include this header in the gru dtsi.

For gru devices, we've moved to a "virtual sbs battery" provided by
the EC.  I'm not 100% positive that everything will just magically
work and be converted in the EC if we put a non-sbs battery on a board
with this EC feature, but I would hope we'd convert everything
properly.


>> One last point, gru/kevin
>> currently don't define a charger, which will break my subsequent patch (that is
>> however needed for the veyrons that use this file).

Arguably this should be fixed.  On veyron-chromebook we just use
"gpio-charger".  We didn't add a special charger driver w/ a property
like "ti,external-control" since the only piece of information that
Linux really needed from the charger was whether or not AC was
connected.


>> To me, it seems that there's little advantage and major drawbacks in keeping
>> this file the way it is.
>
> I don't have any set opinion right now but after looking through the
> other uses of the sbs-battery the cros-ec-sbs.dtsi snippet really seems
> somewhat veyron/gru-specific - especially wrt. the retry-count values.
>
> What I'm not sure about is whether it is actually better to keep the include
> around under a new name or just move the (rather tiny) sbs-battery node
> into the relevant devicetrees directly, when there aren't that many users
> anyway.

I'm fine with whatever you guys choose to do here.  It's nice not to
have copied "code", but with device tree sometimes copies are cleaner
than trying to share something.

-Doug
