From: pinskia@gmail.com (Andrew Pinski)
Date: Wed, 4 May 2016 23:40:44 -0700
Subject: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal
 return
In-Reply-To: <572AAED2.7050604@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1554541.oDP7Ro5zB2@wuerfel>
 <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
 <3846428.6xx69KGEja@wuerfel> <57288660.9030607@huawei.com>
 <57289C75.50904@huawei.com> <20160504214949.GA28217@yury-N73SV>
 <CA+=Sn1ngpaJWHpGDmU+kXBkz56SO+XDW2qzMMLAbbBWnaB0eqw@mail.gmail.com>
 <572AAED2.7050604@huawei.com>
Message-ID: <CA+=Sn1mNdd+Xy5QL5ScRyZOCWwKkG6o1Pb50sFPuiKX=0Z2B1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2016 at 7:24 PM, Zhangjian (Bamvor)
<bamvor.zhangjian@huawei.com> wrote:
> Hi,
>
>
> On 2016/5/5 7:23, Andrew Pinski wrote:
>>
>> On Wed, May 4, 2016 at 2:49 PM, Yury Norov <ynorov@caviumnetworks.com>
>> wrote:
>>>
>>> On Tue, May 03, 2016 at 08:41:25PM +0800, Zhangjian (Bamvor) wrote:
>>>>
>>>> Hi, all
>>>>
>>>> After apply this patch with my small testcase, the vsyscall of
>>>> gettimeofday in
>>>> ilp32 works in both big endian and small endian. In this patch, I use
>>>> the
>>>> different register and offset for ilp32 and lp64. Actually, the
>>>> COMPAT_TVAL_TV_SEC is same as TVAL_TV_SEC(so as to COMPAT_TSPEC_TV_SEC
>>>> and
>>>> TSPEC_TV_SEC). I add it to keep the logic clear. I also change the
>>>> version
>>>> of vdso to 4.6. It should change to 2.6.39 if glibc is not update.
>>>>
>>>
>>> [...]
>>>
>>> Hi Bamvor,
>>>
>>> It works for me as well. Thank you.
>>> I'll incorporate it in next submission.
>>
>>
>> We should add the following so we are complaint to the ILP32 ABI
>> dealing with pointers don't have to be zero extended for arguments,
>> Note ZERO should most likely be ZERO_PTR or something to do that
>> effect, I am not so good with names.
>> #ifdef __LP64__
>> #define ZERO(n)
>> #else
>> #define ZERO(n)         mov     w##n, w##n
>> #endif
>>
>> ...
>> ENTRY(__kernel_gettimeofday)
>>          .cfi_startproc
>>          ZERO(0)
>>          ZERO(1)
>> ...
>> ENTRY(__kernel_clock_gettime)
>>          .cfi_startproc
>>          ZERO(1)
>> ...
>> ENTRY(__kernel_clock_getres)
>>          .cfi_startproc
>>          ZERO(1)
>
> Thanks. I will test and send a new version.


Note there is one more patch needed to __kernel_clock_getres to store
using 32bit rather than 64bit too.
@@ -213,7 +213,7 @@ ENTRY(__kernel_clock_getres)
        ldr     x2, 6f
 2:
        cbz     w1, 3f
-       stp     xzr, x2, [x1]
+       stp     PTR_REG(zr), PTR_REG(2), [x1]

 3:     /* res == NULL. */
        mov     w0, wzr


Thanks,
Andrew

>
> Thanks.
>
> Bamvor
>>
>> Thanks,
>> Andrew Pinski
>>
>>>
>>> Yury.
>
>
