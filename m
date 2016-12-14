From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Dec 2016 23:58:27 +0000
Subject: [PATCH] arm: Adjust memory boundaries after reservations
In-Reply-To: <1481681501-13788-1-git-send-email-labbott@redhat.com>
References: <1481681501-13788-1-git-send-email-labbott@redhat.com>
Message-ID: <20161214235827.GI14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 06:11:41PM -0800, Laura Abbott wrote:
> The poorly named sanity_check_meminfo is responsible for setting up the
> boundary for lowmem/highmem. This needs to be set up before memblock
> reservations can occur. At the time memblock reservations can occur,
> memory can also be removed from the system. This can throw off the
> calculation of the lowmem/highmem boundary. On some systems this may be
> harmless, on others this may result in incorrect ranges being passed to
> the main memory allocator. Correct this by recalcuating the
> lowmem/highmem boundary after all reservations have been made.
> As part of this, rename sanity_check_meminfo to actually refect what the
> function is doing.

I think this needs more explanation - after reading that, I'm left
wondering wtf is going on...

Let's say that the memory boundary was at 0x30000000.  Memory from
0x2f000000 to 0x30000000 is stolen, which reserves it and removes
it from the available memory.

Since the memory is no longer available, why would the stolen range
end up being passed to the main memory allocator?

How is this any different from the boot loader omitting the memory
range in the first place?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
