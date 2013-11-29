From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Fri, 29 Nov 2013 11:36:31 +0200
Subject: [PATCH v2] ARM: davinci: aemif: get rid of davinci-nand driver
 dependency on aemif
In-Reply-To: <52981A4B.70703@ti.com>
References: <1385562694-24618-1-git-send-email-ivan.khoronzhuk@ti.com>
 <52981A4B.70703@ti.com>
Message-ID: <5298601F.4090200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 06:38 AM, Sekhar Nori wrote:
> On Wednesday 27 November 2013 08:01 PM, Ivan Khoronzhuk wrote:
>> The problem that the set timings code contains the call of Davinci
>> platform function davinci_aemif_setup_timing() which is not
>> accessible if kernel is built for another platform like Keystone.
>>
>> The Keysone platform is going to use TI AEMIF driver.
>> If TI AEMIF is used we don't need to set timings and bus width.
>> It is done by AEMIF driver.
>>
>> To get rid of davinci-nand driver dependency on aemif platform code
>> we moved aemif code to davinci platform.
>>
>> The platform AEMIF code (aemif.c) has to be removed once Davinci
>> will be converted to DT and use ti-aemif.c driver.
>>
>> The long device name "davinci_ntosd2_nandflash_device" was renamed
>> to "ntosd2_nandflash" as requested by Sekhar Nori, because after
>> adding changes the line is so broken that its almost unreadable.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> 
> This patch can be simplified in some places.
> 
>> ---
>> v2..v1:
>> - enabled AEMIF clock
>> - removed EXPORT_SYMBOL(davinci_aemif_setup)
>> - renamed ugly name davinci_ntosd2_nandflash_device
>>
>> CC:
>> Sekhar Nori <nsekhar@ti.com>
>>
>>   arch/arm/mach-davinci/aemif.c                   |   89 ++++++++++++++++++++++-
>>   arch/arm/mach-davinci/board-da830-evm.c         |    3 +
>>   arch/arm/mach-davinci/board-da850-evm.c         |    3 +
>>   arch/arm/mach-davinci/board-dm355-evm.c         |    5 ++
>>   arch/arm/mach-davinci/board-dm355-leopard.c     |    5 ++
>>   arch/arm/mach-davinci/board-dm365-evm.c         |    4 +
>>   arch/arm/mach-davinci/board-dm644x-evm.c        |    5 ++
>>   arch/arm/mach-davinci/board-dm646x-evm.c        |    3 +
>>   arch/arm/mach-davinci/board-mityomapl138.c      |    3 +
>>   arch/arm/mach-davinci/board-neuros-osd2.c       |   13 +++-
>>   arch/arm/mach-davinci/devices-tnetv107x.c       |    3 +
>>   drivers/mtd/nand/davinci_nand.c                 |   23 ------
>>   include/linux/platform_data/mtd-davinci-aemif.h |    5 +-
> 
> Most of these boards dont really have a timing structure defined.
> Instead of blindly calling AEMIF setup on all boards, it can be
> done only on boards that actually need it.
> 

Yes, but in such case we should add AEMIF setup to
arch/arm/mach-davinci/board-mityomapl138.c also,
because it has: .options = NAND_BUSWIDTH_16

-- 
Regards,
Ivan Khoronzhuk
