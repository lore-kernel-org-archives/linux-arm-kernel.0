From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Sep 2016 10:56:18 +0100
Subject: [PATCH] arm: mm: export set_memory_x and set_meory_nx
In-Reply-To: <20160901094525.8296-1-js07.lee@samsung.com>
References: <20160901094525.8296-1-js07.lee@samsung.com>
Message-ID: <20160901095618.GV1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 06:45:25PM +0900, Jungseung Lee wrote:
> This patch exports set_memory_x and set_memory_nx functions.
> It is still allowed for modules to use these functions in other
> architectures. In a similar manner to arm, export these functions.

They don't work on general kernel memory, so I'd much prefer that these
weren't exported.

I see no users of set_memory_nx() in modules.  There's one module that
uses set_memory_x(), which is drivers/watchdog/hpwdt.c.  The three users
of that are ifdef'd for x86 cases, and it's used on the result of
ioremapping, which will fail on ARMs implementation (which only allows
modules memory.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
