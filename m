From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 26 May 2017 09:13:36 -0700
Subject: [PATCH 1/4] ARM: ep93xx: switch to SPARSEMEM
In-Reply-To: <440efa53-dbbf-5600-3441-87c6891c5389@gmail.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
 <20170221181529.6780-2-hsweeten@visionengravers.com>
 <440efa53-dbbf-5600-3441-87c6891c5389@gmail.com>
Message-ID: <c5d6d870-48f8-f6c4-1ec9-6b540d0dca98@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/13/17 ? 11:21, Florian Fainelli a ?crit :
> Le 02/21/17 ? 10:15, H Hartley Sweeten a ?crit :
>> The EP93xx has four chip selects that can be used for the SDRAM memory.
>> These chip selects are decoded to specify an address domain:
>>
>>   SDCS3  0x00000000-0x0fffffff with Boot Option ASDO=1
>>   SDCS0  0xc0000000-0xcfffffff
>>   SDCS1  0xd0000000-0xdfffffff
>>   SDCS2  0xe0000000-x0efffffff
>>   SDCS3  0xf0000000-0xffffffff with Boot Option ASDO=0
>>
>> Because of the row/column/bank architecture of SDRAM, the mapping of
>> these memories into the processor's memory space is discontiguous.
>>
>> Most ep93xx systems only use one of the chip selects. For these systems,
>> ARCH_HAS_HOLES_MEMORYMODEL has worked fine to handle the discontiguous
>> memory.
>>
>> But, some of the TS-72xx boards use multiple chip selects. The TS-7300 in
>> particular uses SDCS3 (with ASDO=1) and SDCS2. On that system with
>> ARCH_HAS_HOLES_MEMORYMODEL the SDCS2 memory does not get handled correctly
>> and results in the system not booting.
>>
>> Change the EP93xx to ARCH_SPARSEMEM_ENABLE. This handles the discontiguous
>> memory for all configurations.
>>
>> This has been tested on the following ep93xx platforms:
>>
>> EDB9307A with 64 MiB on SDCS0
>> Vision EP9307 with 64 MiB on SDCS0
>> TS-7300 with 64 MiB on SDCS3 (with ASDO=1) and 64 MiB on SDCS2
>> sim.one with 64 MiB on SDCS0
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Russell King <linux@armlinux.org.uk>
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> On a TS-3700 with 32MiB of SDRAM, thanks!
> 

OK this is weird, this patch applied against v4.11 works fine on a 32MB
board configuration, but applied against v4.12-rc2 I now get the following:

Uncompressing Linux... done, booting the kernel.
Warning: Neither atags nor dtb found

as if r2 was lost somehow.

I will start a bisection to figure out if/when it started to break.
Russell do you have an idea?
-- 
Florian
