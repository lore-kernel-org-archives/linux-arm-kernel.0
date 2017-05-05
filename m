From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 5 May 2017 17:25:07 +0100
Subject: [PATCH] arm64: Add translation functions for /dev/mem read/write
In-Reply-To: <20170505145505.GF14111@arm.com>
References: <1493756885-29704-1-git-send-email-sgoel@codeaurora.org>
 <20170503112639.GG8233@arm.com>
 <bda22142-6b46-0e11-9d13-4bed0dcfd713@codeaurora.org>
 <20170503201814.GP1657@bivouac.eciton.net>
 <345a59fb-085f-a776-2d7e-4889a0f86d7f@codeaurora.org>
 <CAKv+Gu-z8_OeTEp-4DSLtfvirKHct8sD+uThz4wseuZgHBxyoA@mail.gmail.com>
 <20170505145505.GF14111@arm.com>
Message-ID: <A63D01B9-450E-4AB5-BC4A-3B87AA8DA834@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 5 May 2017, at 15:55, Will Deacon <will.deacon@arm.com> wrote:
> 
>> On Thu, May 04, 2017 at 07:40:50AM +0100, Ard Biesheuvel wrote:
>>> On 3 May 2017 at 22:47, Goel, Sameer <sgoel@codeaurora.org> wrote:
>>> 
>>> 
>>>> On 5/3/2017 2:18 PM, Leif Lindholm wrote:
>>>>> On Wed, May 03, 2017 at 11:07:45AM -0600, Goel, Sameer wrote:
>>>>>> On 5/3/2017 5:26 AM, Will Deacon wrote:
>>>>>> [adding some /dev/mem fans to cc]
>>>>>> 
>>>>>>> On Tue, May 02, 2017 at 02:28:05PM -0600, Sameer Goel wrote:
>>>>>>> Port architecture specific xlate and unxlate functions for /dev/mem
>>>>>>> read/write. This sets up the mapping for a valid physical address if a
>>>>>>> kernel direct mapping is not already present.
>>>>>>> 
>>>>>>> This is a generic issue as a user space app should not be allowed to crash
>>>>>>> the kernel.
>>>>>> 
>>>>>>> This issue was observed when systemd tried to access performance
>>>>>>> pointer record from the FPDT table.
>>>>>> 
>>>>>> Why is it doing that? Is there not a way to get this via /sys?
>>>>> 
>>>>> There is no ACPI FPDT implementation in the kernel, so the userspace
>>>>> systemd code is getting the FPDT table contents from /sys
>>>>> and parsing the entries. The performance pointer record is a
>>>>> reserved address populated by UEFI and the userspace code tries to
>>>>> access it using /dev/mem. The physical address is valid, so cannot
>>>>> push back on the user space code.
>>>> 
>>>> OK, so then we need to add support for parsing this table in the
>>>> kernel and exposing the referred-to regions in a controllable fashion.
>>>> Maybe something that belongs under /sys/firmware/efi (adding Matt), or
>>>> maybe something that deserves its own driver.
>>>> 
>>>> The only two use-cases for /dev/mem on arm64 are:
>>>> - Implementing interfaces in the kernel takes up-front effort.
>>>> - Being able to accidentally panic the kernel from userland.
>>>> 
>>> We will see this issue with any access using /dev/mem to a MEMBLOCK_NOMAP marked
>>> memblock. The kernel crash issue has to be fixed irrespective of ACPI FPDT support.
>>> 
>> 
>> I reported the same issue a couple of weeks ago [0]. So while we all
>> agree that such accesses shouldn't oops the kernel, I think we may
>> disagree on whether such accesses should be allowed in the first
>> place, especially when using read/write on /dev/mem (as opposed to
>> mmap())
> 
> Did you plan to respin those patches to address Alex's comments? I agree
> that it would be good to close the oops, regardless of the rest of the
> discussion here.

Agreed. I will look into this after my vacation (back on May 15th)
