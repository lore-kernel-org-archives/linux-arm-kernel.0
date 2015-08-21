From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 21 Aug 2015 09:53:02 +0300
Subject: [PATCH v1, TRIVIAL] Fix pxafb nonstd field documentation and
 add errata info
In-Reply-To: <55D63391.3080403@tul.cz>
References: <55C64864.6070405@tul.cz> <55D5B232.9090006@ti.com>
 <55D63391.3080403@tul.cz>
Message-ID: <55D6CACE.1080801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/08/15 23:07, Petr Cvek wrote:
> Dne 20.8.2015 v 12:55 Tomi Valkeinen napsal(a):
>>
>>
>> On 08/08/15 21:20, Petr Cvek wrote:
>>
>>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>>> index 2d98de5..8f485ec 100644
>>> --- a/drivers/video/fbdev/Kconfig
>>> +++ b/drivers/video/fbdev/Kconfig
>>> @@ -1893,6 +1893,11 @@ config FB_PXA_OVERLAY
>>>  	bool "Support PXA27x/PXA3xx Overlay(s) as framebuffer"
>>>  	default n
>>>  	depends on FB_PXA && (PXA27x || PXA3xx)
>>> +	---help---
>>> +	  Using the overlay 2 and YUV420 mode on a PXA27x C0 chip revision will
>>> +	  hang the LCD until the next SoC restart (errata E24).
>>
>> Shouldn't the driver handle this? It should not allow the combination to
>> be used.
>>
>>  Tomi
>>
> 
> Probably, but I don't know which revisions are OK and which are not. Errata document:
> 
> 	Marvell? PXA270M Processor Specification Update
> 	MV-S900957-00
> 
> has only 3 revisions, but PXA Manual lists 6 (2.2.5.1 Processor ID Register) and one revision from errata is not shown in my PXA Manual. I can exclude mine revision (from "system_rev" variable), but there should be some warning somewhere in configuration.

No, configuration or kernel docs is not the right place for this. The
user is not going to see that. And a single kernel image is supposed to
run on different soc/board versions, so you can't do selections like
this in the kernel config.

The driver should detect the bad revision, and then apply the
workaround, or if that's not possible, refuse the use of the
configuration that leads to the HW bug. Or if even that's not possible,
the driver should print a warning when starting, so that the user is
able to see it.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150821/16323465/attachment.sig>
