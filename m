From: armlinux@emagii.com (ARM Linux)
Date: Sun, 26 Feb 2012 21:52:31 +0100
Subject: AT91: How copy kernel code to SRAM and execute?
In-Reply-To: <20120226184409.GA3318@game.jcrosoft.org>
References: <4F4A6DD5.5040606@emagii.com>
 <20120226184409.GA3318@game.jcrosoft.org>
Message-ID: <4F4A9B8F.9070803@emagii.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-02-26 19:44, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:37 Sun 26 Feb     , ARM Linux wrote:
>> I am looking for some examples on how to copy a small piece of kernel code
>> to internal SRAM and then execute it.
>>
>> Why?
>> If you want to restart, you execute the "/sbin/reboot" command
>> which will eventually call the "arch_reset" function, which in the AT91
>> case will write to a "user reset" register.
>>
>> The problem is that the chip may reset in the middle of an SDRAM
>> read transfer.
>> The SDRAM will see it's clock stopped and will continue to drive the bus.
>>
>> When the ROM bootloader tries to access any boot memory (Parallel
>> flash or NAND flash)
>> on the parallel bus, there will be a bus conflict between the boot
>> memory and the SDRAM,
>> and the bootROM will not properly detect the boot program, and will enter
>> an In System Programming mode.
>>
>> This is described in the SAM9G20 datasheet, but is probably valid
>> for all older generation AT91 devices as well.
>>
>> The workaround seems to be to turn off the SDRAM and then do the reset.
>> Obviously you cannot read instructions from SDRAM after it has been
>> turned off.
>>
> 	Which version of the kernel do you use?
>
On 2012-02-26 19:44, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:37 Sun 26 Feb     , ARM Linux wrote:
>> I am looking for some examples on how to copy a small piece of kernel code
>> to internal SRAM and then execute it.
>>
>> Why?
>> If you want to restart, you execute the "/sbin/reboot" command
>> which will eventually call the "arch_reset" function, which in the AT91
>> case will write to a "user reset" register.
>>
>> The problem is that the chip may reset in the middle of an SDRAM
>> read transfer.
>> The SDRAM will see it's clock stopped and will continue to drive the bus.
>>
>> When the ROM bootloader tries to access any boot memory (Parallel
>> flash or NAND flash)
>> on the parallel bus, there will be a bus conflict between the boot
>> memory and the SDRAM,
>> and the bootROM will not properly detect the boot program, and will enter
>> an In System Programming mode.
>>
>> This is described in the SAM9G20 datasheet, but is probably valid
>> for all older generation AT91 devices as well.
>>
>> The workaround seems to be to turn off the SDRAM and then do the reset.
>> Obviously you cannot read instructions from SDRAM after it has been
>> turned off.
>>
> 	Which version of the kernel do you use?
>
> 	There is no need to put the code in the sram, you just need to put the
> 	code in cached before shutdown the SDRAM/DDR
>

The vanilla 2.6.30 from linux4sam, but it is using a patchset from a 
customer.
I don't think it is an option to change kernel version right now.
Cache is turned off in this version.

> Best Regards,
> J.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


> 	There is no need to put the code in the sram, you just need to put the
> 	code in cached before shutdown the SDRAM/DDR
>
> Best Regards,
> J.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Best Regards
Ulf Samuelsson
ulf at emagii.com
+46 722 427437
