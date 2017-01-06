From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jan 2017 15:05:35 +0000
Subject: [PATCH net-next v4 0/4] Fix OdroidC2 Gigabit Tx link issue
In-Reply-To: <1483710621.28003.74.camel@baylibre.com>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
 <049b1efc-3bad-92e0-45ef-0563dc5d81de@gmail.com>
 <20170105232508.GU14217@n2100.armlinux.org.uk>
 <1483697496.28003.40.camel@baylibre.com>
 <20170106114226.GX14217@n2100.armlinux.org.uk>
 <1483710621.28003.74.camel@baylibre.com>
Message-ID: <20170106150534.GF14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(quick reply...)

On Fri, Jan 06, 2017 at 02:50:21PM +0100, Jerome Brunet wrote:
> So I'm not sure I understand, are you against EEE integration in phylib
> entirely, or specifically against the test I added in set_eee to filter
> out broken modes ?

I'm happy to see EEE integrated into phylib, but I think the current
implementation is very buggy and needs a rewrite.

> > BTW, one of the problems (not caused by your patch) is that changing
> > the EEE advertisment does not (on all PHY drivers) cause the link to
> > be renegotiated - there's no call to phy_start_aneg() when the advert
> > changes, and even if there was, there's no guarantee that
> > phy_start_aneg() will even set the AN restart bit in the control
> > register.
> > 
> > However, given that you're hooking into the set_eee function, I'm not
> > sure why you placed your EEE advertisment thing into config_aneg() -
> > isn't it more an initialisation thing (so should be in
> > config_init()?)
> 
> What I change is what the PHY advertise, so it seems logical to do it
> where "genphy_config_advert" was called. Just taking the existing code
> as an example

You need to adjust the adverisment in two places:

1. On initialisation, when you need to change the default value.
2. Whenever the user requests a different EEE advertisment.

You don't need to do it each time config_aneg() is called - nothing's
going to change the EEE advertisment in that path.  Hence, to check
it each and every time seems like a waste of CPU cycles.

However, there's another path that needs to be considered, which the
current EEE code fails to do, and that is the resume path.  Nothing
at present saves and restores the EEE settings, they are completely
lost if the PHY is powered down.  This is just another symptom of the
current poor quality EEE implementation in phylib, and another reason
why I say above that the EEE code is in need of a rewrite... which is
something I will be looking at.

If the EEE settings are properly saved and restored over suspend/
resume, then the previously programmed EEE advertisment would also
be restored.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
