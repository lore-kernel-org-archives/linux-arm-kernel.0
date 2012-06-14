From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 14 Jun 2012 08:31:20 +0200
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <4FD90352.9090606@wwwdotorg.org>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
Message-ID: <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 03:17:06PM -0600, Stephen Warren wrote:
> On 06/13/2012 04:40 AM, Wei Ni wrote:
> > Hi, all
> > I'm working on the tegra30 wifi upstream issue.
> > 
> > The tegra30 board (Cardhu) use Broadcom 4329 as wifi device, and use brcmfmac as the wifi driver.
> > 
> > In the brcmfmac init routine, it call sdio_register_driver() to register driver, if the wifi device is powered on, then the mmc driver will enumerate it, and call the probe callback routine.
> > 
> > On the Cardhu, the wifi's power is controlled by two gpios (power-gpio and reset-gpio), the default state is power-off. So we need to power on it before calling sdio_register_driver(), if not, the mmc driver can't enumerate it, and will not call the probe routine.
> > This power on sequence is: 
> > set power-gpio to 1 ;
> > mdelay(100) ;
> > set reset-gpio to 1 ;
> > mdelay(200);
> > 
> > My question is where to power on the wifi. We may have three places to power on it:
> > 1. power on it in the brcmfmac driver before calling sdio_register_driver(). But I think this power sequence is special for tegra30 cardhu, it's not good to add it in the generic wifi driver, because different board may use the different way to power on the wifi.
> > 2. power on it in the mmc driver. In our tegra SD driver, it has power-gpios property, which allow the slot to be powered. But this power is for mmc slot, could we add this wifi power sequence in the tegra SD driver?
> > 3. hard-coded into DT. Set these gpios in the DT, something like pinmux settings, but in this way, it's not good to put the mdelay() value in the DT.
> > 
> > I have no good idea for it, does anyone has suggestion?
> 
> The core of the issue is that:
> 
> * Tegra30 support is via device tree.
> * We have an SDIO bus, and the WiFi device attached to that bus is
> enumerable.
> * Since the WiFi device is enumerable, no node exists in the DT to
> represent it.
> * However, the driver for the WiFi device needs certain information,
> such as the reset GPIO ID and perhaps power GPIO.

PCI devices are also enumerable and yet they can be matched up with nodes in
the device tree. Perhaps something similar could be added for the SDIO bus?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/adb86368/attachment.sig>
