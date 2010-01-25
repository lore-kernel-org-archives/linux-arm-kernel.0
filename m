From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 26 Jan 2010 08:32:25 +1300
Subject: change boot requirements [Was: make PHYS_OFFSET determined at
	run time (unfinished)]
In-Reply-To: <20100125173201.GA14834@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
	<20100122115831.GA8377@pengutronix.de>
	<20100125173201.GA14834@pengutronix.de>
Message-ID: <4B5DF1C9.6090102@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Jan 22, 2010 at 12:58:31PM +0100, Uwe Kleine-K?nig wrote:
>> just a short status report:  The code seems to work OK if PHYS_OFFSET is
>> determined correctly.
>>
>> The problem is when it does not.  Currently I place arch/arm/boot/Image
>> at 0xa1008000[1] with PHYS_OFFSET being 0xa0000000.  Then
>> arch/arm/boot/head.S guesses PHYS_OFFSET to be 0xa1000000 resulting
>> __va(bank->start) of my only bank to be 0xbf000000.  And so this bank is
>> discarded by sanity_check_meminfo as 0xbf000000 overlaps the vmalloc
>> region.
>>
>> So how to proceed?  These possiblities come to (my) mind:
>>
>>  - parse the atag list to better guess phys_offset
>>    (both zImage and Image would need to do that)
>>  - require that zImage and Image are placed such that the guess is done
>>    right (which is stupid for zImage as then the decompressor needs to
>>    move the decompressed image)
>>  - require the bootloader to pass phys_offset (r3?)
>>  - make the ram mapping non-linear
>>  - don't discard the whole bank, only the addresses overlaping the
>>    vmalloc region
>>
>> Anything else?  Preferences?  Thoughts?
> I'd like to go forward here and if I don't hear anything here I'll start
> requiring that the bootloader sets r3=PHYS_OFFSET as this seems the most
> robust solution to me.

As long as you can still build images the old way. There will be some
people who cannot modify their bootloaders to support this.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
