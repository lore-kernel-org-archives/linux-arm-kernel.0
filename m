From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 16 Mar 2018 09:53:02 +0100
Subject: [PATCH 1/3] driver core: check notifier_call_chain return value
In-Reply-To: <20180315171059.GA10254@kroah.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227140926.22996-2-benjamin.gaignard@st.com>
 <20180315171059.GA10254@kroah.com>
Message-ID: <CA+M3ks5DHQNoEZQ9AM_g2fSGafFbMtpP=D7hfL9EXLvc-GH65w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-15 18:10 GMT+01:00 Greg KH <gregkh@linuxfoundation.org>:
> On Tue, Feb 27, 2018 at 03:09:24PM +0100, Benjamin Gaignard wrote:
>> When being notified that a driver is about to be bind a listener
>> could return NOTIFY_BAD.
>> Check the return to be sure that the driver could be bind.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  drivers/base/dd.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index de6fd092bf2f..9275f2c0fed2 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -304,9 +304,12 @@ static int driver_sysfs_add(struct device *dev)
>>  {
>>       int ret;
>>
>> -     if (dev->bus)
>> -             blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> -                                          BUS_NOTIFY_BIND_DRIVER, dev);
>> +     if (dev->bus) {
>> +             if (blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> +                                              BUS_NOTIFY_BIND_DRIVER, dev) ==
>> +                                              NOTIFY_BAD)
>> +                     return -EINVAL;
>
> checkpatch does not complain about this?

No (even with --strict), it should be indented with tabs

>
> And what is going to break when we enable this, as we have never checked
> this before?

I could have miss some occurences but when greping with BUS_NOTIFY_*
patern I haven't any problematic cases.
When notifiers don't care of the message they almost all return
NOTIFY_DONE, some return NOTIFY_OK but none
return NOTIFY_BAD. That I wrote the test like "== NOTIFY_BAD" and not
"!= NOTIFY_OK".

I have checked this list of files (I hope I haven't forgot any occurence)
arch/powerpc/kernel/isa-bridge.c
arch/powerpc/kernel/iommu.c
arch/powerpc/kernel/dma-swiotlb.c
arch/powerpc/platforms/pasemi/setup.c
arch/powerpc/platforms/512x/pdm360ng.c
arch/powerpc/platforms/cell/iommu.c
arch/arm/mach-mvebu/coherency.c
arch/arm/common/sa1111.c
arch/arm/mach-keystone/keystone.c -> this one return NOTIFY_BAD if dev
is NULL which is never the case.
arch/arm/mach-highbank/highbank.c
arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
arch/arm/mach-omap2/omap_device.c
drivers/base/power/clock_ops.c
drivers/platform/x86/silead_dmi.c
drivers/input/serio/i8042.c
drivers/input/mouse/psmouse-smbus.c
drivers/w1/w1.c
drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
drivers/i2c/i2c-dev.c drivers/acpi/acpi_lpss.c
drivers/gpu/vga/vgaarb.c
drivers/xen/pci.c drivers/xen/xen-pciback/pci_stub.c
drivers/xen/arm-device.c
drivers/iommu/s390-iommu.c
drivers/iommu/iommu.c
drivers/iommu/dmar.c
drivers/iommu/intel-iommu.c
drivers/usb/core/usb.c
drivers/s390/cio/ccwgroup.c
drivers/net/ethernet/ibm/emac/core.c

Benjamin

>
> thanks,
>
> greg k-h
