From: bill4carson@gmail.com (bill4carson)
Date: Thu, 31 May 2012 13:06:00 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <CAHkRjk4suj4x-mJwvLeOYCNga_YvudNmnz7YxTSzFZ4Jj0iJ+w@mail.gmail.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
 <4FC45E6B.2070202@gmail.com>
 <20120530063858.GB6484@mudshark.cambridge.arm.com>
 <4FC5F017.4050202@gmail.com> <20120531030016.GB29372@mbp>
 <4FC6E172.4080601@gmail.com> <20120531031941.GA29906@mbp>
 <4FC6E7CE.9090004@gmail.com>
 <CAHkRjk4suj4x-mJwvLeOYCNga_YvudNmnz7YxTSzFZ4Jj0iJ+w@mail.gmail.com>
Message-ID: <4FC6FC38.8090904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?05?31? 11:58, Catalin Marinas wrote:
> On 31 May 2012 11:38, bill4carson<bill4carson@gmail.com>  wrote:
>> On 2012?05?31? 11:19, Catalin Marinas wrote:
>>> BTW, see this as a starting point (and a hack):
>>>
>>> http://article.gmane.org/gmane.linux.ports.arm.kernel/51556
>>
>> I think we has some mis-understanding here :(
>>
>> As for:v6_flush_kern_dcache_area/v6_flush_kern_dcache_all
>> these two hooks is supposed to be globally effective, *not*
>> locally!
>>
>> Hence, there should below fix to make it as globally effective.
>>
>>
>> +#ifdef CONFIG_SMP
>> +       ldr     r2, [r0]                        @ read for ownership
>> +       str     r2, [r0]                        @ write for ownership
>> +#endif /* CONFIG_SMP */
>>
>> Or there maybe some other better solution for this issue.
>
> I still didn't fully understand what the problem is. So, to make sure,
> if you run some applications from flash using a yaffs filesystem, you
> get random crashes. Is this correct? If yes, a solution is to actually
> call flush_dcache_page() on the CPU that does the page copying from
> flash into RAM, which could be the yaffs filesystem.
>

The story goes like this:
function "flush_dcache_page" should be global effective
but in ARMv6 MPCore, it was not, it was just local effective due
to hardware design. This may cause error in some cases for example:

1) Task running on Core-0 loading text section into memory.
    It was preempted and then migrate into Core-1;
2) On Core-1, this task continue loading it and then
    "flush_dcache_page" to make sure the loaded text section write
    into main memory.
3) Task tend to the loaded text section and running it.

If the "flush_dcache_page" was not global effective,
there maybe data still in Core-0's data cache, not write
into main memory. Thus in step 3, error instruction maybe
fetched thus cause strange error.

If I'm missing something here, please let me know.

thanks

-- 
Love each day!

--bill
