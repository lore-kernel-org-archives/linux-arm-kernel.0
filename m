From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Nov 2016 21:08:27 +0100
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <2a8dc40f-be75-b010-3ec7-6912f02e3c90@huawei.com>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <2127881.qmAR1XgW9F@wuerfel>
 <2a8dc40f-be75-b010-3ec7-6912f02e3c90@huawei.com>
Message-ID: <2467231.EbVekJun1R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 7, 2016 2:15:10 PM CET John Garry wrote:
> 
> Hi Arnd,
> 
> The new bus type tries to model the djtag in a similar way to I2C/USB 
> driver arch, where we have a host bus adapter and child devices attached 
> to the bus. The child devices are bus driver devices and have bus 
> addresses. We think of the djtag as a separate bus, so we are modelling 
> it as such.
> 
> The bus driver offers a simple host interface for clients to read/write 
> to the djtag bus: bus accesses are hidden from the client, the host 
> drives the bus.

Ok, in that case we should probably start out by having a bus specific
DT binding, and separating the description from that of the bus master
device.

I'd suggest requiring #address-cells=<1> and #size-cells=<0> in the master
node, and listing the children by reg property. If the address is not
easily expressed as a single integer, use a larger #address-cells value.

Another option that we have previously used was to actually pretend that
a vendor specific bus is an i2c bus and use the i2c probing infrastructure,
but that only makes sense if the software side closely resembles i2c
(this was the case for Allwinner I think, but I have not looked at
your driver in enough detail to know if it is true here as well).

	Arnd
