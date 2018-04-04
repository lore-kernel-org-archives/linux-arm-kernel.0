From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 4 Apr 2018 11:57:34 -0400
Subject: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
In-Reply-To: <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
References: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4>
 <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
 <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
Message-ID: <1a66f95c-47f1-1017-3834-c20ed67e6de4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2018 11:55 AM, Arnd Bergmann wrote:
> On Wed, Apr 4, 2018 at 5:52 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 4/3/2018 6:29 PM, Palmer Dabbelt wrote:
>>>
>>
>> Are we looking for something like this?
> 
> Yes, exactly, plus the same for write and in/out of course.
> 

OK. I just wanted to double check first.

>> diff --git a/inc
>>  #ifndef readb
>>  #define readb readb
>> -static inline u8 readb(const volatile void __iomem *addr)
>> -{
>> -       return __raw_readb(addr);
>> -}
>> +#define readb(c)                               \
>> +       ({ u8  __v;                             \
>> +        __io_br();                             \
>> +        __v = __raw_readb(c);                  \
>> +        __io_ar();                             \
>> +        __v; })
>>  #endif
> 
> I would prefer leaving these as inline functions, but that's only
> a cosmetic difference.

sure, I'll leave these as inline functions.

> 
>        Arnd
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
