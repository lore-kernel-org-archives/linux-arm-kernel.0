From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 10 Feb 2015 20:50:41 +0100
Subject: [PATCH 5/9] mtd: pxa3xx_nand: add support for the Marvell Berlin
 nand controller
In-Reply-To: <20150209005503.3fad39c7@bbrezillon> (Boris Brezillon's message
 of "Mon, 9 Feb 2015 00:55:03 +0100")
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
 <1422367816-4257-6-git-send-email-antoine.tenart@free-electrons.com>
 <20150209005503.3fad39c7@bbrezillon>
Message-ID: <871tlx7dgu.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> On Tue, 27 Jan 2015 15:10:12 +0100
> Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
>
>> The nand controller on Marvell Berlin SoC reuse the pxa3xx nand driver
>> as it quite close. The process of sending commands can be compared to
>> the one of the Marvell armada 370: read and write commands are done in
>> chunks.
>> 
>> But the Berlin nand controller has some other specificities which
>> require some modifications of the pxa3xx nand driver:
>> - there are no IRQ available so we need to poll the status register: we
>>   have to use our own cmdfunc Berlin function, and early on the probing
>>   function.
>> - PAGEPROG are very different from the one used in the pxa3xx driver,
>>   so we're using a specific process for this one
>> - the SEQIN command is equivalent to a READ0 command
>> - the RNDOUT command must be used to perform a read operation, and the
>>   command is not NAND_CMD_RNDOUT
>> - the ERASE1 command is specific (0xd060)
>> 
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Given all the differences, the PIO mode instead of the current interrupt model,
and the berlin specific functions (nand_start, ...), wouldn't it be an idea to :
 - extract the common functions to mrvl-nand-lib.c
 - the remaining would be in pxa3xx_nand.c
 - the new code will be in berlin_nand.c

All these ifs per variant will add complexity to the current driver, won't they
?

Cheers.

--
Robert
