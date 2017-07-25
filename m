From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 25 Jul 2017 14:21:37 +0100
Subject: No Ethernet on Raspberry Pi 3 in v4.13-rc1
In-Reply-To: <1435162494.87709.1500959996834@email.1und1.de>
References: <5650979e-ea55-0337-2edd-d2c3e8ad0e37@suse.de>
 <b849a4dc-a095-6bb4-caf1-a1f7470bed91@arm.com>
 <1435162494.87709.1500959996834@email.1und1.de>
Message-ID: <38cfb4d7-c356-d2b2-0367-69ef3417d941@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 25/07/17 06:19, Stefan Wahren wrote:
>>> With arm64 4.13-rc1 I get no eth0 device on Pi3 (openSUSE Tumbleweed).
>>> The v4.13-rc1 DT works okay with a 4.12 kernel.
>>>
>>> Possibly related:
>>>
>>> [   15.916350] OF: /soc/usb at 7e980000: could not get #phy-cells for /phy
>>>
>>> [   16.496662] usb 1-1: new high-speed USB device number 2 using dwc2
>>> [   16.502988] dwc2 3f980000.usb: Cannot do DMA to address
>>> 0x00000000335da400
>>
>> This is from SWIOTLB's map_single(), which means whatever device was
>> passed into dma_map_single() when mapping the URB had a DMA mask smaller
>> than 30 bits (or none at all), which sounds wrong and is almost
>> certainly the root of the problem (i.e. it probably wasn't the actual
>> HCD device described in DT and set up by of_dma_configure()). 
> 
> how can i figure out what's cause this issue (bcm283x or dwc2 specific)?
> 
> The dwc2 hcd already check the DMA mask on probe [1] and i never saw a warning in error case.

I'll admit I'm a little stumped, since the two commits to dwc2 since
4.12 seem entirely inconsequential.

The only way I can see this happening is if the first dma_capable()
check in swiotlb_map_page() fails, and since swiotlb_force must be set
to SWIOTLB_NOFORCE in order to print the error later, and the address
and size look reasonable, that only leaves dev->dma_mask as the culprit.

>From the subsequent fallout (which on closer inspection looks more to do
with calling into uninitialised SWIOTLB state than the arm64 DMA code
actually doing anything wrong), I'd guess dev->dma_pfn_offset is
probably 0 as well, which further points to the wrong device. Maybe
something's changed lower down in the USB core? Turning on tracing and
booting with "tp_printk trace_event=swiotlb_bounced" on the command line
should shed a bit more light on what's going on.

Robin.
