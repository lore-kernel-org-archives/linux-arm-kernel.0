From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Nov 2011 19:06:47 -0500 (EST)
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers and
 into platform.
In-Reply-To: <1321128007-3520-4-git-send-email-andrew@lunn.ch>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
 <1321128007-3520-4-git-send-email-andrew@lunn.ch>
Message-ID: <alpine.LFD.2.02.1111141855340.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Nov 2011, Andrew Lunn wrote:

> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-dove/pcie.c                   |    3 +-
>  arch/arm/mach-kirkwood/mpp.c                |    1 -
>  arch/arm/mach-kirkwood/pcie.c               |    3 +-
>  arch/arm/mach-mv78xx0/mpp.c                 |    1 -
>  arch/arm/mach-mv78xx0/pcie.c                |    3 +-
>  arch/arm/mach-orion5x/mpp.c                 |    1 -
>  arch/arm/mach-orion5x/pci.c                 |    2 +-
>  arch/arm/plat-orion/addr-map.c              |  182 +++++++++++++++++++++++++++
>  arch/arm/plat-orion/include/plat/addr-map.h |    8 ++
>  arch/arm/plat-orion/include/plat/pcie.h     |    3 +-
>  arch/arm/plat-orion/pcie.c                  |    6 +-
>  drivers/ata/sata_mv.c                       |   36 +-----
>  drivers/dma/mv_xor.c                        |   37 +-----
>  drivers/dma/mv_xor.h                        |    5 -
>  drivers/mmc/host/mvsdio.c                   |   28 +----
>  drivers/mmc/host/mvsdio.h                   |    4 -
>  drivers/net/mv643xx_eth.c                   |   45 +------
>  drivers/usb/host/ehci-orion.c               |   30 +----
>  sound/soc/kirkwood/kirkwood-dma.c           |   30 +----
>  sound/soc/kirkwood/kirkwood.h               |    4 -
>  20 files changed, 218 insertions(+), 214 deletions(-)

I have a conceptual concern with this patch.  Initially, we moved all 
the device specific mbus initializations from the core SOC code into 
their respective drivers before submitting this code to mainline, simply 
because that was the right thing to do.  Because the corresponding 
registers are highly device/peripheral specific, it makes sense to put 
that info in the drivers.

Now you are moving it all back into a centralized place, meaning that a 
lot of different peripheral knowledge has to be gathered up into that 
single place.  And if a new driver is ever added for a new peripheral, 
then that central place will have to learn about it too.  This doesn't 
look that pretty to me.

Furthermore, this is not providing any sort of code saving either.

I understand that you might want to get rid of the annoying platform 
data pointer for the mbus values.  But I think that this could be done 
some other way though.  IMHO the mbus initialization code for 
peripherals should remain in the drivers, and a different way to query 
the needed information be elaborated instead.  Otherwise this is like 
throwing out the baby with the bath water.


Nicolas
