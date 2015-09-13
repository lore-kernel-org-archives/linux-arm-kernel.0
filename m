From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 13 Sep 2015 17:22:24 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Add dts file for the
 pov protab2-ips9 tablet
In-Reply-To: <55EE9230.70209@redhat.com>
References: <1441441319-10658-1-git-send-email-hdegoede@redhat.com>
 <20150906163023.GR31584@lukather> <55ED3739.609@redhat.com>
 <20150907205603.GX31584@lukather> <55EE9230.70209@redhat.com>
Message-ID: <20150913152224.GU9885@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 09:45:52AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07-09-15 22:56, Maxime Ripard wrote:
> >On Mon, Sep 07, 2015 at 09:05:29AM +0200, Hans de Goede wrote:
> >>>>+&reg_ldo3 {
> >>>>+	/*
> >>>>+	 * We need to always power the camera sensor, otherwhise all access
> >>>>+	 * to i2c1 is blocked.
> >>>>+	 */
> >>>>+	regulator-always-on;
> >>>>+	regulator-min-microvolt = <2800000>;
> >>>>+	regulator-max-microvolt = <2800000>;
> >>>>+	regulator-name = "vdd-csi";
> >>>>+};
> >>>
> >>>What is connected on i2c1 ? Just the camera sensor? or it has some
> >>>other devices there?
> >>
> >>The bma250 accelerometer sits there, and the kernel already has a driver
> >>for it. That driver needs to have devicetree binding support added, and
> >>then we should be able to use the accelerometer.
> >
> >Ok, so if this regulator is disable, you can't access the other
> >devices as well, right?
> 
> Right, the controller reports the bus as being stuck.

Which is pretty bad... :/

> >Do you know why? Is it the regulator providing
> >the pull-up voltage?
> 
> I've tried enabling the pull ups on the SoC i2c pins, so I do not think
> that it is that, it seems that somehow when not powered the camera sensor is
> actively keeping the lines low. Either it has multiple power planes, or
> it is using normally-on fet-s between ground and its i2c lines.

Well, if a regulator is powered down, it's also tied to the ground,
which means you would actually have pull-down. Maybe the in-SoC
pullups simply aren't strong enough in such a case.

Anyway. In both cases, the regulator really shouldn't be drifting
along like this. If the i2c bus needs a regulator to be operationaly,
then we can just add an optional bus-supply property or something to
give that to the i2c driver so that it can enable it when needed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150913/99e67cef/attachment.sig>
