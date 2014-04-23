From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 13:03:47 +0200
Subject: [RFC PATCH 2/2] PCI: exynos: Add PCIe support for Samsung GH7 SoC
In-Reply-To: <031b01cf5ed5$21d536a0$657fa3e0$@samsung.com>
References: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
 <201404221611.40087.arnd@arndb.de>
 <031b01cf5ed5$21d536a0$657fa3e0$@samsung.com>
Message-ID: <4565008.ZECF3eWqge@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014 18:19:30 Kukjin Kim wrote:
> 

> Basically, ARMv8 based GH7 has same PCIe hardware IP with previous ARMv7
> based exynos5440, several features in PCIe are different though. In other
> words, basic functionalities for PCIe are same. So I think, would be nice if
> we could use one PCIe device driver for both SoCs.

Ok, I see. I was just trying to get a feeling for how much is shared
or SoC specific between your variants. If they are different enough,
it may be easier to have two drivers.

> However, if we need to support the PCIe with each own device driver because
> of difference of 32bit and 64bit, please kindly let us know. Honestly, I'm
> not sure about that right now.

We are working already on ideas to minimize the differences between
arm32 and arm64 PCI support, it will just take more work.

> > Also, if gh7 is expected to run a full firmware, I think you should
> > do all the setup in the firmware before booting Linux, and just
> > do the required run-time operations in the driver itself.
> > 
> Well, we're expecting that all the setup should be done by the device driver
> in kernel not firmware.

Ok, just make sure this hardware never shows up in servers then.

Unfortunately we are in a tricky situation on arm64 because we have
to support both server-type SoCs and embedded-type SoCs. In an
embedded system, you can't trust the boot loader to do a proper
setup of all the hardware, so the kernel needs full control over
all the initialization. In a server, the initialization is the
responsibility of the firmware, and we don't want the kernel to
even know about those registers.

My hope is that all server chips use an SBSA compliant PCIe
implementation, but we already have X-Gene, which is doing server
workloads with a nonstandard PCIe, and it's possible that there
will also be server-like systems with a DesignWare PCIe block
instead of an SBSA compliant one. We can still support those, but
I don't want to see more than one implementation of dw-pcie
on servers. Just like we have the generic PCIe support that Will
is doing for virtual machines and SBSA compliant systems, we
would do one dw-pcie variant for all systems that come with a
host firmware and rely on it being set up already.

	Arnd
