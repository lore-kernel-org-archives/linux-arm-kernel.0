From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 May 2017 15:36:29 +0100
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <20170530140320.GA22758@lunn.ch>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170530121907.GO22219@n2100.armlinux.org.uk>
 <20170530143350.6f8563c1@free-electrons.com>
 <20170530125643.GQ22219@n2100.armlinux.org.uk>
 <20170530132735.GA21646@lunn.ch>
 <20170530134226.GR22219@n2100.armlinux.org.uk>
 <20170530140320.GA22758@lunn.ch>
Message-ID: <20170530143629.GT22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 04:03:20PM +0200, Andrew Lunn wrote:
> Linux has a long history of reworking stuff in tree, when it has been
> shown to be inadequate in its first version. So long as the device
> tree binding does not need incompatible changes, this reworking is not
> an issue. My guess is, a lot of people have SFP sockets, not
> SFP+. Lets get SFP merged, and then rework it in tree to add SFP+.

Unfortunately, it _does_ require an incompatible DT change, and an
incompatible change with the MAC drivers.

The DT change is needed because the current DT model (modelled from
DSA) connects the SFP cage to the MAC device using (eg):

	sfp {
		...
		sfp,ethernet = <&eth2>;
	};

This completely breaks when you have SFP connected to a PHY, as is
the case with SFP+.  So the current binding is unusable for this
case.

Instead, what I have (and what I will propose) is to get rid of that
property entirely, replacing it with a property in the upstream device
(being a MAC or PHY), eg:

&eth2 {
	sfp = <&sfp>;
};

        p1_phy: ethernet-phy at 8 {
                sfp = <&sfp_eth1>;
        };

The code changes behind this would make maintaining support for the
previous binding rather difficult, as the way the SFP code finds the
netdevice changes completely - I now have a separate "sfp-bus", which
both phylink and SFP sockets register into, and which is responsible
for connecting the two together.

This change would not be possible had SFP support already been merged.
The old binding was just wrong.

I pushed out some updates to the SFP support last week, and now that
I have dw-hdmi out of the way, I'm about to merge these incompatible
changes into the SFP branch, and as the branch is currently at 24
patches, I'm probably going to squash a lot of the patches in there
together at the same time - which'll make me feel a bit sorry for
anyone who's making use of the existing code, because they won't be
able to see what the changes have been.  However, that's the only way
to stop the patch set going over 30...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
