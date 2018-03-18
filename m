From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Mar 2018 13:21:27 +0000
Subject: [PATCH 1/7] 2 1-byte checks more safer for memory_is_poisoned_16
In-Reply-To: <20180318125342.4278-2-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
 <20180318125342.4278-2-liuwenliang@huawei.com>
Message-ID: <20180318132126.GA565@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2018 at 08:53:36PM +0800, Abbott Liu wrote:
> Because in some architecture(eg. arm) instruction set, non-aligned
> access support is not very well, so 2 1-byte checks is more
> safer than 1 2-byte check. The impact on performance is small
> because 16-byte accesses are not too common.

This is unnecessary:

1. a load of a 16-bit quantity will work as desired on modern ARMs.
2. Networking already relies on unaligned loads to work as per x86
   (iow, an unaligned 32-bit load loads the 32-bits at the address
   even if it's not naturally aligned, and that also goes for 16-bit
   accesses.)

If these are rare (which you say above - "not too common") then it's
much better to leave the code as-is, because it will most likely be
faster on modern CPUs, and the impact for older generation CPUs is
likely to be low.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
