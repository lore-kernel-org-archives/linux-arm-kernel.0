From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 23:10:38 +0300
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get board
	data
In-Reply-To: <20100811184742.GA21778@nokia.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
Message-ID: <AANLkTikLbiJ8PsUbSnmYrfY6oNW4okejf-UdyQyfYbUz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Wed, Aug 11, 2010 at 9:47 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
>>> + ? ? ? pdata = pdev->dev.platform_data;
>>> + ? ? ? if (!pdata) {
>>> + ? ? ? ? ? ? ? wl1271_error("no platform data");
>>> + ? ? ? ? ? ? ? return -ENODEV;
>>> + ? ? ? }
>>> +
>>> + ? ? ? pdriver = container_of(pdev->dev.driver, struct platform_driver,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? driver);
>
> but you shouldn't fiddle with the driver structure here. What are you
> actually trying to achieve here ? What's pinstance supposed to do ? are you
> trying to handle cases where you might have several wl12xx chips on the same
> board ?

Yes.

Think of several wl1271 devices, each of which is represented by two
devices; an SDIO function, and a platform device. The SDIO function
stands for a specific MMC controller the device is hardwired to, and
the platform device stands for the external irq line that the device
is hardwired to.

We must couple the SDIO function with the correct platform device,
otherwise it will start getting the wrong interrupts. So after the
SDIO function is probed, it registers a platform driver with the
unique name that represents the platform device that it is coupled
with. When the platform device is probed, it needs to deliver its
platform data info to the specific SDIO function that it is bound
with.

To avoid using some global data structure in that driver, we allocate
a unique platform driver per each device, which makes it possible for
the platform driver probe to find the SDIO function context by means
of container_of.

Alternatively, we can also use some global structure in that file,
most probably idr, which would also make it possible to reach the SDIO
function contexts without going through the driver structure. The idr
indexes would then be the MMC controller index, which should match
the platform device id.

I'll try this out, it might actually look nicer.

Thanks,
Ohad.

> If that's the case you should have several platform devices, one for
> each chip. They'll only have different ids.
>
> --
> balbi
>
> DefectiveByDesign.org
>
