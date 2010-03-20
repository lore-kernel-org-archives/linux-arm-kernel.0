From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Sat, 20 Mar 2010 13:20:50 +0200
Subject: [PATCH] MTD: Fix Orion NAND driver compilation with ARM OABI
In-Reply-To: <1269078083.4028.5586.camel@macbook.infradead.org>
References: <20100320085507.4038.96426.stgit@pauliusz>
	<1269078083.4028.5586.camel@macbook.infradead.org>
Message-ID: <badfd5ba1003200420xc0680c1h8b4cccd02a8fdaba@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 11:41 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sat, 2010-03-20 at 10:55 +0200, Paulius Zaleckas wrote:
>> We must tell GCC to use even register for variable passed
>> to ldrd instruction. Without this patch GCC 4.2.1 puts this
>> variable to r2/r3 on EABI and r3/r4 on OABI, so force it to
>> r2/r3. This does not change anything when EABI and OABI
>> compilation works OK.
>>
>> Without this patch and with OABI I get:
>> /tmp/ccMkwOCs.s:63: Error: first destination register must be even -- `ldrd r3,[ip]'
>> make[5]: *** [drivers/mtd/nand/orion_nand.o] Error 1
>
> ?...
>> - ? ? ? ? ? ? uint64_t x;
>> + ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ?* force x variable to r2/r3 registers since ldrd instruction
>> + ? ? ? ? ? ? ?* requires first register to be even.
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? register uint64_t x asm ("r2");
>> +
>> ? ? ? ? ? ? ? asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
>
> Hm, isn't there an asm constraint which will force it into an
> appropriate register pair?

Not that I know of...

> Failing that, "=&2,4,6,8" ought to work.

No, fails with error: matching constraint not valid in output operand

> (Um, and why the earlyclobber? Why can't io_base be passed in in one of
> the same registers?)
>
> We should try to avoid making our constraints more restrictive than they
> need to be.
>
> --
> David Woodhouse ? ? ? ? ? ? ? ? ? ? ? ? ? ?Open Source Technology Centre
> David.Woodhouse at intel.com ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Intel Corporation
