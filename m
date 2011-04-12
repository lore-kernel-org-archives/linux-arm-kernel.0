From: balbi@ti.com (Felipe Balbi)
Date: Tue, 12 Apr 2011 16:36:35 +0300
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
Message-ID: <20110412133633.GR15130@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 12, 2011 at 01:57:07AM +0200, Rafa? Mi?ecki wrote:
> Cc: Michael B?sch <mb@bu3sch.de>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: George Kashperko <george@znau.edu.ua>
> Cc: Arend van Spriel <arend@broadcom.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Botting <andy@andybotting.com>
> Cc: linuxdriverproject <devel@linuxdriverproject.org>
> Cc: linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> V2: Rename to axi
>     Use DEFINE_PCI_DEVICE_TABLE in bridge
>     Make use of pr_fmt and pr_*
>     Store core class
>     Rename bridge to not b43 specific
>     Replace magic 0x1000 with BCMAI_CORE_SIZE
>     Remove some old "ssb" names and defines
>     Move BCMAI_ADDR_BASE def
>     Add drvdata field
> V3: Fix reloading (kfree issue)
>     Add 14e4:0x4331
>     Fix non-initialized struct issue
>     Drop useless inline functions wrappers for pci core drv
>     Proper pr_* usage
> V3.1: Include forgotten changes (pr_* and include related)
>     Explain why we dare to implement empty release function

I'm not sure we need this. If you have an IP Core which talks AXI and
you want to put it on a PCI bus, you will have a PCI Bus wrapper around
that IP Core, so you should go and let the kernel know about that. See
[1] for a core IP which talks AXI and [2] for a PCI bus glue layer.

Besides, if you introduce this bus layer, it'll be more difficult for
other licensees of the same core to re-use the same driver, since it's
now talking a PCI emulated on top of AXI. The same can be achieved with
the platform_bus which is more widely used, specially on ARM SoCs.

[1] http://gitorious.org/usb/usb/blobs/dwc3/drivers/usb/dwc3/core.c
[2] http://gitorious.org/usb/usb/blobs/dwc3/drivers/usb/dwc3/dwc3-haps.c

-- 
balbi
