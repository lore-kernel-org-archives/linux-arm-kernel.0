From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 14 Feb 2017 15:53:13 +0100
Subject: [PATCHv2 net-next 11/16] net: mvpp2: handle misc PPv2.1/PPv2.2
 differences
In-Reply-To: <20170107093834.GJ14217@n2100.armlinux.org.uk>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-12-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170107093834.GJ14217@n2100.armlinux.org.uk>
Message-ID: <20170214155313.1e9a497b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 7 Jan 2017 09:38:34 +0000, Russell King - ARM Linux wrote:

> This has the side effect that nothing clears the port reset bit in the
> GMAC, which means there's no hope of the interface working - with the
> reset bit set, the port is well and truely held in "link down" state.

Things were working fine here on Armada 7K/8K even without calling
mvpp21_port_power_up(port). But I've looked into more details, and in
fact the whole function makes sense on PPv2.2, except the
mvpp2_port_fc_adv_enable(port) part of it. So I've replaced this with:

	mvpp2_port_mii_set(port);
	mvpp2_port_periodic_xon_disable(port);

	if (priv->hw_version == MVPP21)
		mvpp2_port_fc_adv_enable(port);

	mvpp2_port_reset(port);

This will be in my v3.

> In any case, the GMAC part is much the same as mvneta, and I think
> that code should be shared rather than writing new versions of it.

Possibly, but it's really a separate thing: this is completely
independent from introducing PPv2.2 support, it's something that
already exists. The patch series is already 16 patches long in its v2,
and is going to even a bit longer in its v3, so I would really like to
stick to just PPv2.2 support.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
