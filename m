From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Aug 2016 13:33:14 +0100
Subject: [PATCH] arm: add an option for erratum 657417
In-Reply-To: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
Message-ID: <20160812123314.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 06:19:17PM +1000, Nicholas Piggin wrote:
> This patch adds an option which defaults to "y" in cases where we
> could possibly be running Cortex A8 and using Thumb2 instructions.
> In reality the workaround might not be required at all for the kernel
> if virtual instruction memory is linear in physical memory.

Hmm.

The main kernel image is guaranteed to be contiguous in physical memory
for all sorts of reasons, so this really isn't a concern for the kernel
itself.

Modules, however, are a different matter, as they are mapped in using
individual pages, and are most likely to be non-contiguous in physical
memory.  The kernel's module linker knows nothing about this errata,
so it'll generally just fix up the relocations in the most basic of
ways.

So, I think we should always use this --no-fix-cortex-a8 option where
the linker supports it irrespective of whether we're running on a core
needing this workaround, but we probably need to fix the kernel module
linker to know about this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
