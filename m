From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 May 2015 22:40:44 +0100
Subject: Physical memory start address for ARM cores
In-Reply-To: <CAJWVF-whTD0Nm-cup-qOt-M-PYn-6GojSiE9pS2Db0R35D5aUQ@mail.gmail.com>
References: <CAJWVF-whTD0Nm-cup-qOt-M-PYn-6GojSiE9pS2Db0R35D5aUQ@mail.gmail.com>
Message-ID: <20150511214044.GJ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 08:47:21PM +0530, Bhaskara rao Budiredla wrote:
> Could you please confirm if ARM architecture mandates the physical
> memory start address to align with a MegaBye boundary (something like
> 0xXXX00000)? I am seeing Linux Kernel crash if I relax that
> restriction.

The ARM architecture doesn't, but we (the kernel) does restrict it for
the sake of cross-machine portability.  See this comment in
arch/arm/boot/compressed.S:

                /*
                 * Find the start of physical memory.  As we are executing
                 * without the MMU on, we are in the physical address space.
                 * We just need to get rid of any offset by aligning the
                 * address.
                 *
                 * This alignment is a balance between the requirements of
                 * different platforms - we have chosen 128MB to allow
                 * platforms which align the start of their physical memory
                 * to 128MB to use this feature, while allowing the zImage
                 * to be placed within the first 128MB of memory on other
                 * platforms.  Increasing the alignment means we place
                 * stricter alignment requirements on the start of physical
                 * memory, but relaxing it means that we break people who
                 * are already placing their zImage in (eg) the top 64MB
                 * of this range.
                 */

We will never change this requirement, as changing it breaks existing
platforms, and that's not allowed.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
