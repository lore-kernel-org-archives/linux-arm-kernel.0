From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 14:29:24 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107061442.05182.arnd@arndb.de>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706122501.GU8286@n2100.arm.linux.org.uk>
	<201107061442.05182.arnd@arndb.de>
Message-ID: <20110706132924.GX8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 02:42:04PM +0200, Arnd Bergmann wrote:
> I had the same comment for one of the earlier versions of the patch
> set, but we agreed that I'd come up with a way to remove this at a
> later stage for all platforms that don't have PC-style PIO.
> 
> Right now, the only platforms that use a value other than 0xffffffff
> are ones that actually have PCI and set it to 0xffff.

As I point out, you can't use that as a reason to work out why the macro
is being set.  Various platforms have it set to 0xffffffff, and use the
PCI/ISA IO accessor with virtual memory addresses provided by (eg) the
PCMCIA subsystem - SA11x0 and PXA come to mind on that.

The problem there is that we can't just change the thing because there is
that constant thorn known as cs89x0.c, which also uses these macros, and
that driver has never been properly updated (it contains _lots_ of platform
specific hacks in it.)  Changing the base address for the PCI/ISA IO
accessor on those platforms is likely to completely break at least this
driver.

Plus there are is at least one platform which sets it to 0xffff yet
doesn't appear to have PCI selected (VT8500).  So I don't think we can
even use the 64K-1 value to infer anything about the platform.

This is why we need the reasoning behind the value for this macro
documented.
