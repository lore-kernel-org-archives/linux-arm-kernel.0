From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 10 May 2012 10:15:58 -0600
Subject: Handling of modular boards
In-Reply-To: <4FABB758.7000702@compulab.co.il>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205041934.08830.arnd@arndb.de>
 <20120504203357.6B79B206451@gemini.denx.de>
 <20120504220944.GT14230@opensource.wolfsonmicro.com>
 <4FABB758.7000702@compulab.co.il>
Message-ID: <4FABE9BE.2010108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2012 06:40 AM, Igor Grinberg wrote:
> On 05/05/12 01:09, Mark Brown wrote:
>> On Fri, May 04, 2012 at 10:33:57PM +0200, Wolfgang Denk wrote:
> 
>>> On the other hand, some of the issues we're trying to solve
>>> here for the kernel are also present in the boot loader, so
>>> this needs to do this anyway - whether by inserting new or
>>> modifying (enabling or disabling) existing properties in the DT
>>> is not really relevant here.
> 
>> FWIW if the bootloader can usefully handle this stuff I think
>> that's a good approach but there is substantial variation in
>> quality of implementation between bootloaders and even when the
>> bootloader is a good one it's not always practical to update it
>> or the data it relies on.
> 
> I agree on this (and also with Ben), all our boards/extensions/base
> boards/etc can be discovered in the boot loader and we will use the
> DT to pass the relevant information on the attached extensions and
> used base board.
> 
> Also, most (if not all) of our boards/extensions have I2C EEPROM
> which describes the devices on that board/extension which is useful
> for building/extending the DT in the bootloader.

I believe that's true for all/many NVIDIA boards too.

But, duplicating all this in every bootloader might not make sense.
Sure there are some cases where the bootloader needs this information
(e.g. to load the kernel from an SD card that's on 1 of N plugin
boards), but there may be much information the bootloader doesn't care
about.

Would it make sense to write a DT-identifying-and-merging shim that
can be executed by the bootloader, create the final DT, and then jump
to the kernel?

Hmmm. That's probably a bad idea, since then it means needing e.g. I2C
drivers to read the ID EEPROMs, pinmux drivers, ... in the shim.

Perhaps the common shim idea makes sense, but we need a standardized
API it can use that all bootloaders provide for it to operate.

This is beginning to sound a lot like a UEFI byte code module (I
assume; I know little about them)
