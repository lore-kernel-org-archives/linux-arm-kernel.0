From: zhichang.yuan@linaro.org (zhichang.yuan)
Date: Wed, 13 Aug 2014 11:13:12 +0800
Subject: [PATCH V2] arm64: optimized copy_to_user and copy_from_user
 assembly code
In-Reply-To: <CAL85gmChQCM3iw-xqy-bkGRWH0jDvGf7v-GnxynS4HoOkL-cwQ@mail.gmail.com>
References: <1407538940-9167-1-git-send-email-fkan@apm.com>	<CAC8NTUXb1JmHwMLjmJtEKXjb+xYtuO4qKnSqMRWwACs35P8_HA@mail.gmail.com>
 <CAL85gmChQCM3iw-xqy-bkGRWH0jDvGf7v-GnxynS4HoOkL-cwQ@mail.gmail.com>
Message-ID: <53EAD7C8.7070001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Feng,

On 2014?08?12? 02:05, Feng Kan wrote:
> On Sun, Aug 10, 2014 at 8:01 PM, Radha Mohan <mohun106@gmail.com> wrote:
>> Hi Feng,
>>
>>
>>> +
>>> +.Lcpy_not_short:
>>> +       /*
>>> +        * We don't much care about the alignment of DST, but we want SRC
>>> +        * to be 128-bit (16 byte) aligned so that we don't cross cache line
>>> +        * boundaries on both loads and stores.
>>> +        */
>> Could you please tell why is destination alignment not an issue? Is
>> this a generic implementation that you are referring to or specific to
>> your platform?
> This is per Linaro Cortext String optimization routines.
>
> https://launchpad.net/cortex-strings
>
> Zhichang submitted something similar for the memcpy from the
> same optimization.
>
> Sorry resend in text mode.

If the both dst and src are not aligned and their alignment offset are not equal, i haven't found better way
to handle.
But it is lucky ARMv8 support the non-align memory access.
At the beginning of my patch work, i also think maybe it is more better that all load or store are aligned. I
wrote the code just like the ARMv7 memcpy, firstly loaded the data from SRC and buffered them in several
registers and combined as a new word( 16 bytes), then stored it to the aligned DST. But the performance is a
bit worst.

~Zhichang

>>> --
>>> 1.9.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
