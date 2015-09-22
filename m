From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Sep 2015 17:02:42 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Add dts file for the
 pov protab2-ips9 tablet
In-Reply-To: <55F5B370.7040203@redhat.com>
References: <1441441319-10658-1-git-send-email-hdegoede@redhat.com>
 <20150906163023.GR31584@lukather> <55ED3739.609@redhat.com>
 <20150907205603.GX31584@lukather> <55EE9230.70209@redhat.com>
 <20150913152224.GU9885@lukather> <55F5B370.7040203@redhat.com>
Message-ID: <20150922150242.GF4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 07:33:36PM +0200, Hans de Goede wrote:
> >Anyway. In both cases, the regulator really shouldn't be drifting
> >along like this.
> 
> Right which is why I've added the always-on property.

Which is exactly what I meant by drifting along: that regulator will
never be associated to the i2c bus, and will always be enabled even
though the i2c bus might not even be accessible in the first place
(driver not selected, compiled as a module and not loaded yet), which
is just as bad.

> >If the i2c bus needs a regulator to be operationaly,
> >then we can just add an optional bus-supply property or something to
> >give that to the i2c driver so that it can enable it when needed.
> 
> I agree that that would be sensible if this regulator were tied to
> the pull-ups, but I've my doubts that it is. We've not seen anything
> similar on any other allwinner tablet, other then ChenYu-s Ippo-q8-v5
> tablet.
> 
> This tablet is sort of a high-end tablet (with a nice ips screen) and
> such it also uses a different (better) sensor for its frontcam, a
> gc2015 rather then the usual gc0308. I believe that this is the
> culprit.
> 
> Which would make modelling this as some sort of i2c-bus power-supply
> wrong, and I've checked and none of the existing i2c bindings under
> Documentation/devicetree/bindings/i2c contain such a thing, so we
> would be the first and we will likely have a hard time selling a
> binding for this upstream, esp. since we do not know what exactly
> is going on.

Well, strictly speaking, it is a supply needed to get the bus to
work. We should really try to avoid having always-on for regulators,
especially for devices that are already represented in the DT.

> So all in all I strongly believe that just setting always-on
> on the regulator in question is the best solution.

It's a hack we can avoid.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/23831324/attachment.sig>
