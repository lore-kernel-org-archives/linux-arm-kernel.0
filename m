From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Mon, 19 Mar 2018 13:52:27 +0100
Subject: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
In-Reply-To: <20180319111205.GB2743@n2100.armlinux.org.uk>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
Message-ID: <20180319125227.GI4519@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Mar 19, 2018 at 11:12:05AM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 19, 2018 at 09:52:52AM +0100, Antoine Tenart wrote:
> > 
> > Anyway, the reason to use in-band negotiation was also to avoid using
> > fixed-link. It would work but always report the link is up, which for
> > the user isn't a great experience as we have a way to detect this.
> > 
> > What would you suggest to achieve this in a reasonable way?
> 
> The intention of this test in phylink_of_phy_connect() is to avoid
> failing when there is no requirement for a PHY to be present (such as
> a fixed link, or an 802.3z link.)  However, with 10G PHYs such as the
> 3310, we need the PHY so we can read the speed from it, and so know
> whether to downgrade the MAC to SGMII mode, or having downgraded the
> MAC, upgrade it back to 10G mode when the PHY switches to 10G.
> 
> I'm guessing that you're wanting this for the DB boards, but I don't
> see why.  Do they not have PHYs?

You guessed right, that's exactly my use case. The DB boards (7k and 8k)
have 10G interfaces without PHYs. I could describe them as fixed-link
(it works), but it would be better not to require a PHY in
phylink_of_phy_connect() for such interfaces.

That's why I used in-band AN, which is wrong, but we still probably
need to add a check to allow such setups. I'm all ears for suggestions
as I do not have the full picture of all the supported modes and their
requirements.

Thanks!
Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
