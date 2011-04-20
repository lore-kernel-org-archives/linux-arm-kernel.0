From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 21 Apr 2011 09:07:20 +1200
Subject: [RFC PATCH 00/23] at91: Replace duplicate device initialisation
	code	with common code
In-Reply-To: <0D753D10438DA54287A00B027084269764D23AB87B@AUSP01VMBX24.collaborationhost.net>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D23AB87B@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4DAF4B08.3000601@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2011 05:14 AM, H Hartley Sweeten wrote:
> On Tuesday, April 19, 2011 6:10 PM, Ryan Mallon wrote:
>> Each AT91 variant (AT91RM9200, AT91SAM9260, etc) currently has its own
>> devices file, which includes the MMIO address, interrupt
>> configuration, GPIO setup, etc for each device. This results in a large
>> amount of duplicated code.
>>
>> This patch set introduces a framework for adding shared devices for the
>> AT91 platform and replaces the multiple device setup implementations for
>> each device with single implementations in the new framework. This has
>> a net reduction of nearly 5000 lines of code.
>>
>> Each of the arch/arm/mach-at91/*_devices.c files becomes a collection of
>> structures (with some initialisation callbacks where necessary) with a
>> table of devices which are present on the particular AT91 variant. All
>> structures/functions are marked as __init/__initdata so there is little
>> additional memory overhead. This also means that the #ifdefs around each
>> device can be removed from the *_devices.c files (but remain in the new
>> common devices.c file) without overhead.
>>
>> I have build tested the patch series for all of the  AT91 variants 
>> and devices, and have boot tested it on the AT91SAM9260 (Snapper 9260
>> board) and tested basic device functionality.
>>
>> Ryan Mallon (23):
>>   at91: Add common devices framework
>>   at91: Make Ethernet device common
>>   at91: Make USB OHCI/EHCI devices common
>>   at91: Make UDC device common
>>   at91: Make MMC device common
>>   at91: Make NAND device common
>>   at91: Make TWI device common
>>   at91: Make SPI device common
>>   at91: Make TCB device common
>>   at91: Make RTT device common
>>   at91: Make watchdog device common
>>   at91: Make UART devices common
> This patch (12/23) appears to be missing.
>

I got a message saying that it is being held for moderator approval
because it was over the size limit. The diffstat for it is below in the
meantime.

~Ryan

arch/arm/mach-at91/at572d940hf_devices.c  |  267 +++--------------
 arch/arm/mach-at91/at91cap9_devices.c     |  285 ++++---------------
 arch/arm/mach-at91/at91rm9200_devices.c   |  358 +++++------------------
 arch/arm/mach-at91/at91sam9260_devices.c  |  449 ++++++-----------------------
 arch/arm/mach-at91/at91sam9261_devices.c  |  273 ++++--------------
 arch/arm/mach-at91/at91sam9263_devices.c  |  286 ++++---------------
 arch/arm/mach-at91/at91sam9g45_devices.c  |  348 +++++------------------
 arch/arm/mach-at91/at91sam9rl_devices.c   |  360 +++++------------------
 arch/arm/mach-at91/board-1arm.c           |    4 +-
 arch/arm/mach-at91/board-afeb-9260v1.c    |    4 +-
 arch/arm/mach-at91/board-at572d940hf_ek.c |    6 +-
 arch/arm/mach-at91/board-carmeva.c        |    2 +-
 arch/arm/mach-at91/board-cpu9krea.c       |   12 +-
 arch/arm/mach-at91/board-cpuat91.c        |    8 +-
 arch/arm/mach-at91/board-eb9200.c         |    4 +-
 arch/arm/mach-at91/board-ecbat91.c        |    2 +-
 arch/arm/mach-at91/board-foxg20.c         |   12 +-
 arch/arm/mach-at91/board-gsia18s.c        |   10 +-
 arch/arm/mach-at91/board-kafa.c           |    2 +-
 arch/arm/mach-at91/board-kb9202.c         |    6 +-
 arch/arm/mach-at91/board-neocore926.c     |    2 +-
 arch/arm/mach-at91/board-pcontrol-g20.c   |    6 +-
 arch/arm/mach-at91/board-picotux200.c     |    2 +-
 arch/arm/mach-at91/board-qil-a9260.c      |    6 +-
 arch/arm/mach-at91/board-rm9200dk.c       |    2 +-
 arch/arm/mach-at91/board-rm9200ek.c       |    2 +-
 arch/arm/mach-at91/board-sam9-l9260.c     |    4 +-
 arch/arm/mach-at91/board-sam9260ek.c      |    4 +-
 arch/arm/mach-at91/board-sam9263ek.c      |    2 +-
 arch/arm/mach-at91/board-sam9g20ek.c      |    4 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c   |    2 +-
 arch/arm/mach-at91/board-sam9rlek.c       |    2 +-
 arch/arm/mach-at91/board-snapper9260.c    |    6 +-
 arch/arm/mach-at91/board-stamp9g20.c      |   12 +-
 arch/arm/mach-at91/board-yl-9200.c        |    6 +-
 arch/arm/mach-at91/devices.c              |  303 +++++++++++++++++++
 arch/arm/mach-at91/devices.h              |   17 ++
 arch/arm/mach-at91/include/mach/board.h   |   10 +
 38 files changed, 922 insertions(+), 2168 deletions(-)

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751 
Fax:   +64 3 3779135			  USA 1800 261 2934
