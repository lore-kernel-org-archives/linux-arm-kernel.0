From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 09 Mar 2010 15:00:28 +0200
Subject: Compile problem due to compressor changes, UART referenced in
	section .txt
In-Reply-To: <4B963EA8.3090109@cam.ac.uk>
References: <Prayer.1.3.2.1003071719080.2280@hermes-2.csi.cam.ac.uk>
	<20100308101445.GA12363@n2100.arm.linux.org.uk>
	<4B95F85F.5090108@compulab.co.il> <4B963EA8.3090109@cam.ac.uk>
Message-ID: <4B96466C.5060409@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jonathan Cameron wrote:
> On 03/09/10 07:27, Mike Rapoport wrote:
>> Russell King - ARM Linux wrote:
>>> On Sun, Mar 07, 2010 at 05:19:08PM +0000, J.I. Cameron wrote:
>>>> Dear  All,
>>>>
>>>> Ran into the following problem on a pxa stargate2 platform (I think
>>>> it will
>>>> effect a number of others).
>>>>
>>>> `UART' referenced in section `.text' of
>>>> arch/arm/boot/compressed/misc.o:  defined in discarded section
>>>> `.data' of arch/arm/boot/compressed/misc.o  `UART' referenced in
>>>> section `.text' of arch/arm/boot/compressed/misc.o:  defined in
>>>> discarded section `.data' of arch/arm/boot/compressed/misc.o
>>>>
>>>> There is a hack in mach-pxa/include/mach/uncompress.h
>>>> that changes the primary uart for some platforms:
>>>>
>>>> static inline void arch_decomp_setup(void)
>>>> {
>>>>     if (machine_is_littleton() || machine_is_intelmote2()
>>>>         || machine_is_csb726() || machine_is_stargate2()
>>>>       || machine_is_cm_x300() || machine_is_balloon3())
>>>>     UART = STUART;
>>>     else
>>>         UART = FFUART;
>>>
>>> and remove the initializer from UART.
>> Something like that:
>>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>>  arch/arm/mach-pxa/include/mach/uncompress.h |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h
>> b/arch/arm/mach-pxa/include/mach/uncompress.h
>> index 237734b..b009299 100644
>> --- a/arch/arm/mach-pxa/include/mach/uncompress.h
>> +++ b/arch/arm/mach-pxa/include/mach/uncompress.h
>> @@ -15,7 +15,7 @@
>>
>>  #define __REG(x)       ((volatile unsigned long *)x)
>>
>> -static volatile unsigned long *UART = FFUART;
>> +static volatile unsigned long *UART;
>>
>>  static inline void putc(char c)
>>  {
>> @@ -39,6 +39,8 @@ static inline void arch_decomp_setup(void)
>>          || machine_is_csb726() || machine_is_stargate2()
>>          || machine_is_cm_x300() || machine_is_balloon3())
>>          UART = STUART;
>> +    else
>> +        UART = FFUART;
>>  }
> Hi Mike,
> 
> Sorry my email client was messing about yesterday so I ended up
> creating a new thread.

Yeah, I've missed that one...

>.  As Eric pointed out there, this is a little
> more complex due to some changes in the pxa devel tree.  Patch that 
> effectively did the same thing (but adapted for the devel
> tree was in the thread:
> 
>  [PATCH] pxa: fix for UART reference in section text for a number of platforms.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011010.html
> 
> Thanks and sorry again for wasting your time.

Welcome :)

> Jonathan


-- 
Sincerely yours,
Mike.
