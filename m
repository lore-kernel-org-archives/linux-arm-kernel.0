From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Tue, 15 Oct 2013 15:21:18 -0500
Subject: [RESEND PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase
 in system manager
In-Reply-To: <201310152147.27569.arnd@arndb.de>
References: <1381780051-1826-1-git-send-email-dinguyen@altera.com>
 <201310152101.44669.arnd@arndb.de> <525D9532.6080503@gmail.com>
 <201310152147.27569.arnd@arndb.de>
Message-ID: <525DA3BE.2030304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/15/13 2:47 PM, Arnd Bergmann wrote:
> On Tuesday 15 October 2013, Dinh Nguyen wrote:
>>> 1 Create a "syscon" backend driver to control your "system manager", which
>>>     lets other drivers hook into it without calling a private API.
>> Yes, if you look at drivers/mmc/host/dw_mmc-socfpga.c that is in the
>> mainline,
>> it is hooking into the "system manager" through "syscon". Is this what you
>> mean here?
> No, because you directly hook into the syscon driver, rather than using
> a clock driver as the middle-man, see steps 2 and 3 below.
>   
Ok, now I understand.
>> The problem is because of the SYSMGR_SDMMCGRP_CTRL_OFFSET define
>> in this file. This means the SD/MMC driver needs information that is
>> outside of its IP.
> Yes, this is not ideal because you don't really want that information
> in the sd/mmc driver. That driver should only know about the fact
> that it talks to a clock controller, not how it's implemented.
>
> 	Arnd
>
>>> 2 Create a trivial clock driver that is independent of your existing
>>>     clock driver and independent of the other drivers using the system
>>>     manager, by using syscon as the low-level interface.
>>> 3 Make the sdmmc driver use the normal clock API and link its clock to the
>>>     driver from step 2 in the device tree.
This makes sense for the SD/MMC driver, but do you think I can use the 
same approach for
other drivers that this system manager touches? i.e. The ethernet IP's 
PHY setting is controlled
by a register that is in the system manager as well.

I have submitted this patch for enabling ethernet. It is making use of 
the driver platform specific
driver calls to touch the system manager.

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/200173.html

Just wondering if that is right approach for the ethernet driver? If 
not, then I think I may have
to come up with a generic system manager driver so that it can be used 
for other IPs.

Thanks,
Dinh

>>>
>>> Is this what you have tried before?
