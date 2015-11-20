From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2015 20:12:08 +0000
Subject: [RFC PATCH] restrict /dev/mem to idle io memory ranges
In-Reply-To: <20151120173133.24259.97028.stgit@dwillia2-desk3.jf.intel.com>
References: <20151120173133.24259.97028.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151120201207.GH8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 09:31:33AM -0800, Dan Williams wrote:
> This effectively promotes IORESOURCE_BUSY to IORESOURCE_EXCLUSIVE
> semantics by default.  If userspace really believes it is safe to access
> the memory region it can also perform the extra step of disabling an
> active driver.  This protects device address ranges with read side
> effects and otherwise directs userspace to use the driver.

I'm happy with this as long as we retain the option to disable this
new behaviour.

The reason being, when developing a driver, it is _very_ useful to
be able to poke around in the device's (and system memory) address
spaces with tools like devmem2 to work out what's going on when
things go wrong.

To put it another way, I think it's a good idea to disable access to
these regions on production systems, but for driver development, we
want to retain the ability to poke around in physical address space
in any way we so desire.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
