From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Jul 2015 19:48:43 +0100
Subject: [PATCH] ARM: keystone: allow FORCE_MAX_ZONEORDER to be
 configurable on Keystone
In-Reply-To: <1435773182-23074-1-git-send-email-m-karicheri2@ti.com>
References: <1435773182-23074-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <20150701184842.GM7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 01:53:02PM -0400, Murali Karicheri wrote:
> Currently for Keystone devices, user can't change the
> value of CONFIG_FORCE_MAX_ZONEORDER option in defconfig.
> Users require capability to tune the value of this option on a target
> board. So this patch adds this capability

No they shouldn't.  If we do permit this, it should not be unrestricted -
it's a power-of-2 of the page size, so specifying something like 32768 is
insane.

In any case, it's well known that the Linux MM system fragments memory,
and the higher order allocations will fail soon after boot - and the
larger the order, the greater chance of it failing.

The only case that you want large allocations is for things like DMA, and
we have a separate allocator for that called CMA, which is able to grab
large chunks of memory, provided it's configured with a large enough zone.

Please check whether CMA can be used _before_ considering using this
option.  If you need to increase the order, it should be justified, and
it should be done on a per SoC basis in a static way, not left to the
user to dream up some power-of-2 figure.

Most importantly, please explain in the commit message why CMA doesn't
provide you with what you need.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
