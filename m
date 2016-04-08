From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 8 Apr 2016 19:46:55 +0100
Subject: Nouveau crashes in 4.6-rc on arm64
In-Reply-To: <570737F5.30105@nvidia.com>
References: <57064992.1060509@arm.com> <570737F5.30105@nvidia.com>
Message-ID: <5707FC9F.50905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On 08/04/16 05:47, Alexandre Courbot wrote:
> Hi Robin,
>
> On 04/07/2016 08:50 PM, Robin Murphy wrote:
>> Hello,
>>
>> With 4.6-rc2 (and -rc1) I'm seeing Nouveau blowing up at boot, from the
>> look of it by dereferencing some offset from NULL inside
>> nouveau_fbcon_imageblit(). My setup is an old XFX 7600GT card plugged
>> into an ARM Juno r1 board, which works fine with 4.5 and earlier.
>>
>> Attached are a couple of logs from booting arm64 defconfig plus DRM and
>> Nouveau enabled - the second also has framebuffer console rotation
>> turned on, which interestingly seems to move the point of failure, and
>> the display does eventually come up to show the tail end of the panic in
>> that case.
>>
>> I might be able to find time for a full bisection next week if isn't
>> something sufficiently obvious to anyone who knows this driver.
>
> Looking at the log it is not clear to me what could be causing this. I
> can boot 4.6-rc2 with a GM206 card without any issue. A bisect would
> indeed be useful here.

OK, turns out the lure of writing something to remotely drive a Juno and 
parse kernel bootlogs through an automatic bisection was too great to 
resist on a Friday afternoon :D

Bisection came down to 1733a2ad3674("drm/nouveau/device/pci: set as 
non-CPU-coherent on ARM64"), and sure enough reverting that removes the 
crash. I have to say, that commit looks pretty bogus anyway - since 
de335bb49269("PCI: Update DMA configuration from DT") in 4.1, PCI 
devices should correctly inherit the coherency property from their host 
controller's DT node and get the appropriate DMA ops assigned. From a 
brief look at the Nouveau code, I guess it could possibly be the 
assumptions the TTM stuff going awry in the presence of coherent DMA 
ops. Regardless of how the code goes wrong, though, it's trivially 
incorrect to have a blanket statement that PCI devices are non-coherent 
on arm64, so whatever the original issue was this isn't the right way to 
fix it.

Robin.

>
> Thanks,
> Alex.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
