From: marex@denx.de (Marek Vasut)
Date: Sun, 30 Mar 2014 19:36:49 +0200
Subject: [PATCH 2/8] PCI: designware: split Exynos and i.MX bindings
In-Reply-To: <1396025579-14344-3-git-send-email-l.stach@pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <1396025579-14344-3-git-send-email-l.stach@pengutronix.de>
Message-ID: <201403301936.49692.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 28, 2014 at 05:52:53 PM, Lucas Stach wrote:
> The glue around the core designware IP is significantly
> different between the Exynos and i.MX implementation,
> which is reflected in the DT bindings.
> 
> This changes the i.MX6 binding to reuse as much as
> possible from the common designware binding and
> removes old cruft.
> 
> I removed the optional GPIOs with the following reasoning:
> - disable-gpio: endpoint specific GPIO, not currently
>   wired up in any code. Should be handled by the PCI device
>   driver, not the host controller driver.
> - wake-up-gpio: same as above.
> - power-on-gpio: No user in any upstream DT. This should
>   be handled by a regulator which shouldn't be controlled
>   by the host driver, but rather by the PCI device driver.

This power-on-gpio should indeed be handled by the regulator, but the regulator 
cannot be handled by the PCIe device driver. This power-on-gpio must be operated 
on per-slot basis if I understand it correctly, so it cannot be controlled by 
the host controller driver either.

The reason why this cannot be controlled by the device driver is that if the 
device is powered down, it won't be detected on the PCIe bus, thus it cannot 
enable the regulator which will power up the slot the device is sitting in.

[...]

btw. am I blind or do I just not see devicetree-discuss on CC ?

Best regards,
Marek Vasut
