From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Sep 2015 21:32:42 +0100
Subject: [PATCH v5 07/23] regulator: core: Remove regulator_list
In-Reply-To: <20150919150129.GR12027@sirena.org.uk>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442494637-3674-8-git-send-email-tomeu.vizoso@collabora.com>
 <20150919150129.GR12027@sirena.org.uk>
Message-ID: <20150920203242.GM21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 19, 2015 at 08:01:29AM -0700, Mark Brown wrote:
> On Thu, Sep 17, 2015 at 02:57:01PM +0200, Tomeu Vizoso wrote:
> > As we are already registering a device with regulator_class for each
> > regulator device, regulator_list is redundant and can be replaced with
> > calls to class_find_device() and class_for_each_device().
> 
> This appears to leak references to the struct devices returned by
> class_find_device() - it takes a reference before it returns so any
> device found using class_find_device() needs to be released with
> put_device() and I don't see any new put_device() calls in here.

When I've been fiding exactly that kind of bug in the PHY code, I've
been adding comments to the docbook function header detailing the
requirement to balance the reference.  IMHO, this is a good idea,
because the more places that get it with these APIs, the more likely
people are to potentially read it.

The comment I've been putting in the phy code is:

 * If successful, returns a pointer to the phy_device with the embedded
 * struct device refcount incremented by one, or NULL on failure. The
 * refcount must be dropped by calling phy_disconnect() or phy_detach().

which even goes as far as telling people how they should be dropping
the reference.  So there should be no excuse (ignorance is not an
excuse for this!)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
