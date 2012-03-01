From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 1 Mar 2012 12:29:43 -0800
Subject: [PATCH 8/8] ARM: tegra: HACK: remove set_irq_flags() from driver
In-Reply-To: <1330630010-11241-9-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-9-git-send-email-alan@signal11.us>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE86173C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Ott wrote at Thursday, March 01, 2012 12:27 PM:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver should not call set_irq_flags itself, and

Probably true in this case.

> cannot do this from a loadable module.

I hope that's not true; grep'ing the entire of drivers/ shows a bunch
of drivers calling this function, and many look like they'd be reasonable
as module.

>From what little I understand of this, any irq_chip is going to call
that function after setting up any child/cascaded IRQs, and I assume
that irq_chips can be in modules.

> Remove the call for now, which might break the driver
> but at least lets the kernel link again.

The driver appears to work fine with this removed. At least, on Tegra20
Harmony, I was able to modprobe ehci-hcd and then use the USB Ethernet
controller for DHCP and SSH.

So,

Tested-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
