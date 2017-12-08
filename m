From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Dec 2017 09:11:17 +0000
Subject: [PATCH net-next v2 3/8] net: phy: meson-gxl: add read and write
 helpers for bank registers
In-Reply-To: <20171207160235.GL24750@lunn.ch>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-4-jbrunet@baylibre.com>
 <20171207154610.GG24750@lunn.ch>
 <1512661873.7042.9.camel@baylibre.com>
 <20171207160235.GL24750@lunn.ch>
Message-ID: <20171208091116.GZ10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 05:02:35PM +0100, Andrew Lunn wrote:
> > Banks actually comes from the datasheet, Yes.
> > I don't mind renaming it but I would be making things up. As you wish ?
> 
> Keep it as is for the moment.
>  
> > Does the usual pages comes with this weird toggle thing to open the access ?
> > Would we able to use these generic helpers with our this kind of quirks ?
> 
> I don't think the API has been defined yet. But what has been
> discussed is adding functions to struct phy_driver. The driver can
> then implement whatever is needed to select a given page. There will
> then be helpers which take the lock, select the page, do the
> read/write, select page 0, and unlock.

I'm not sure adding generic helpers really works, because the indirection
through phy_driver just makes the code more complex.  For Marvell, I
ended up with:

http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=phy&id=9ca46084228bb1b8851e7d24276d85c4ec6e13ae

and the preceding three commits.

The "generic" versions I came up with were basically lifting
marvell_read_paged(), marvell_write_paged() and marvell_modify_paged()
to phylib, along with the lower leve marvell_save_page(),
marvell_select_page() and marvell_restore_page().  The result is a
fair amount of out-of-line code and an assumption that it's a single
register.  As soon as a PHY has other requirements, these generic
implementations don't work.

Also, unfortunately, we can't get help from sparse for statically
checking the locking - the __acquire()/__release() annotations don't
work for mutexes.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
