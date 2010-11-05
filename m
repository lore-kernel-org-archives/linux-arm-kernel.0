From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Nov 2010 14:01:17 +0000
Subject: CONFIG_FORCE_MAX_ZONEORDER settable for all ARM architectures
In-Reply-To: <4CD40976.1080009@gmail.com>
References: <4CD40976.1080009@gmail.com>
Message-ID: <20101105140117.GB23828@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 09:41:10AM -0400, Daniel Mack wrote:
> on a PXA3xx based platform, we want to allocate 8MByte of physically
> contiguous memory for the framebuffer device.
> 
> However, alloc_pages() fails because MAX_ORDER is hard-coded to 11 for
> this architecture.

Wrong.  If there's an SA1111, it defaults to 9 rather than 11.

> Is there any reason why CONFIG_FORCE_MAX_ZONEORDER is constrained to
> ARCH_SHMOBILE in arch/arm/Kconfig?

It's not.

        int "Maximum zone order" if ARCH_SHMOBILE

means "present the user with this option if ARCH_SHMOBILE != n, otherwise
don't present it to the user but set it anyway".

        range 11 64 if ARCH_SHMOBILE

defines the range when ARCH_SHMOBILE is set.  When it isn't set, there
is no range limitation.

        default "9" if SA1111
        default "11"

So, if SA1111 is set, then it's 9, otherwise it's 11.
