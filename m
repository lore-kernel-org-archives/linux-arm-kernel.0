From: yury.norov@gmail.com (Yury)
Date: Sat, 29 Aug 2015 18:15:15 +0300
Subject: [PATCH] lib: Make _find_next_bit helper function inline
In-Reply-To: <CALW4P+LU2iLkT7d=BiaC_=oSJ6K_g152VsVSjfcQGUKx_5q4tQ@mail.gmail.com>
References: <1438110564-19932-1-git-send-email-cburden@codeaurora.org>
 <55B7F2C6.9010000@gmail.com>
 <20150728144537.67d46b5714c99d25f0bb33fb@linux-foundation.org>
 <1438176656.18723.8.camel@ceres> <55B93A47.90107@codeaurora.org>
 <CALW4P+LU2iLkT7d=BiaC_=oSJ6K_g152VsVSjfcQGUKx_5q4tQ@mail.gmail.com>
Message-ID: <55E1CC83.1010007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 24.08.2015 01:53, Alexey Klimov wrote:
> Hi Cassidy,
>
>
> On Wed, Jul 29, 2015 at 11:40 PM, Cassidy Burden <cburden@codeaurora.org> wrote:
>> I changed the test module to now set the entire array to all 0/1s and
>> only flip a few bits. There appears to be a performance benefit, but
>> it's only 2-3% better (if that). If the main benefit of the original
>> patch was to save space then inlining definitely doesn't seem worth the
>> small gains in real use cases.
>>
>> find_next_zero_bit (us)
>> old      new     inline
>> 14440    17080   17086
>> 4779     5181    5069
>> 10844    12720   12746
>> 9642     11312   11253
>> 3858     3818    3668
>> 10540    12349   12307
>> 12470    14716   14697
>> 5403     6002    5942
>> 2282     1820    1418
>> 13632    16056   15998
>> 11048    13019   13030
>> 6025     6790    6706
>> 13255    15586   15605
>> 3038     2744    2539
>> 10353    12219   12239
>> 10498    12251   12322
>> 14767    17452   17454
>> 12785    15048   15052
>> 1655     1034    691
>> 9924     11611   11558
>>
>> find_next_bit (us)
>> old      new     inline
>> 8535     9936    9667
>> 14666    17372   16880
>> 2315     1799    1355
>> 6578     9092    8806
>> 6548     7558    7274
>> 9448     11213   10821
>> 3467     3497    3449
>> 2719     3079    2911
>> 6115     7989    7796
>> 13582    16113   15643
>> 4643     4946    4766
>> 3406     3728    3536
>> 7118     9045    8805
>> 3174     3011    2701
>> 13300    16780   16252
>> 14285    16848   16330
>> 11583    13669   13207
>> 13063    15455   14989
>> 12661    14955   14500
>> 12068    14166   13790
>>
>> On 7/29/2015 6:30 AM, Alexey Klimov wrote:
>>>
>>> I will re-check on another machine. It's really interesting if
>>> __always_inline makes things better for aarch64 and worse for x86_64. It
>>> will be nice if someone will check it on x86_64 too.
>>
>>
>> Very odd, this may be related to the other compiler optimizations Yuri
>> mentioned?
>
> It's better to ask Yury, i hope he can answer some day.
>
> Do you need to re-check this (with more iterations or on another machine(s))?
>

Hi, Alexey, Cassidy,

(restoring Rasmus, George)

I found no difference between original and inline versions for x86_64:
(Intel(R) Core(TM) i7-2630QM CPU @ 2.00GHz)

find_next_bit		find_next_zero_bit
old	new	inline	old	new	inline
24	27	28	22	28	28
24	27	28      23	27	28
24	27	28      23	27	28
           	
Inspecting assembler code, I found that GCC wants to see helper separated,
even if you provide '__always_inline':

inline <find_next_bit_new>:			current <find_next_bit_new>:			
280:	cmp    %rdx,%rsi                        210:	cmp    %rdx,%rsi
283:	jbe    295 <find_next_bit_new+0x15>     213:	jbe    227 <find_next_bit_new+0x17>
285:	test   %rsi,%rsi                        215:	test   %rsi,%rsi
288:	je     295 <find_next_bit_new+0x15>     218:	je     227 <find_next_bit_new+0x17>
28a:	push   %rbp                             21a:	push   %rbp
28b:	mov    %rsp,%rbp                        21b:	xor    %ecx,%ecx
28e:	callq  0 <find_next_bit_new.part.0>     21d:	mov    %rsp,%rbp
293:	pop    %rbp                             220:	callq  0 <_find_next_bit.part.0>
294:	retq                                    225:	pop    %rbp
295:	mov    %rsi,%rax                        226:	retq
298:	retq                                    227:	mov    %rsi,%rax
299:	nopl   0x0(%rax)                        22a:	retq
       				                22b:	nopl   0x0(%rax,%rax,1)

So things are looking like x86_64 gcc (at least 4.9.2 build for Ubuntu)
ignores '__always_inline' hint as well as 'inline'. But in case of
__always_inline compiler does something not really smart: it introduces
<find_next_bit_new.part.0> and <find_next_zero_bit_new.part.1> helpers
and so increases text size from 0x250 to 0x2b9 bytes, but doesn't really
inline to optimize push/pop and call/ret. I don't like inline, as I
already told, but I believe that complete disabling is bad idea.
Maybe someone knows another trick to make inline work?
