From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Thu, 12 Aug 2010 08:27:33 +0300
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board 	data
In-Reply-To: <AANLkTikLbiJ8PsUbSnmYrfY6oNW4okejf-UdyQyfYbUz@mail.gmail.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
	<AANLkTikLbiJ8PsUbSnmYrfY6oNW4okejf-UdyQyfYbUz@mail.gmail.com>
Message-ID: <20100812052733.GB23362@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 11, 2010 at 10:10:38PM +0200, ext Ohad Ben-Cohen wrote:
>Think of several wl1271 devices, each of which is represented by two
>devices; an SDIO function, and a platform device. The SDIO function
>stands for a specific MMC controller the device is hardwired to, and
>the platform device stands for the external irq line that the device
>is hardwired to.
>
>We must couple the SDIO function with the correct platform device,
>otherwise it will start getting the wrong interrupts. So after the
>SDIO function is probed, it registers a platform driver with the
>unique name that represents the platform device that it is coupled
>with. When the platform device is probed, it needs to deliver its
>platform data info to the specific SDIO function that it is bound
>with.
>
>To avoid using some global data structure in that driver, we allocate
>a unique platform driver per each device, which makes it possible for
>the platform driver probe to find the SDIO function context by means
>of container_of.
>
>Alternatively, we can also use some global structure in that file,
>most probably idr, which would also make it possible to reach the SDIO
>function contexts without going through the driver structure. The idr
>indexes would then be the MMC controller index, which should match
>the platform device id.
>
>I'll try this out, it might actually look nicer.

you need no globals and you don't need to fiddle with driver structures 
either.

Just make an sdio driver that platform_device_alloc() and pass in a 
platform_data, builds struct resources etc for each device found on the 
sdio bus. Similarly for the SPI-connected wifi chip.

You should never fiddle with internal structures. If you want to look at 
an example implementation, take a look at drivers/mfd/twl-core.c, there 
we use an i2c driver to instantiate several platform_devices. Nobody 
fiddles with driver structures and all the drivers are logically 
separated into their own source files.

-- 
balbi

DefectiveByDesign.org
