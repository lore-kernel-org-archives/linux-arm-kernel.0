From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Mar 2016 22:21:29 +0700
Subject: [PATCH v2 1/2] arm64: vmemmap: use virtual projection of linear
 region
In-Reply-To: <56DED0F6.8040602@redhat.com>
References: <1456505834-8638-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456505834-8638-2-git-send-email-ard.biesheuvel@linaro.org>
 <56DE25DD.4010401@gmail.com>
 <E540D948-6371-4F71-A8B6-025BC39A0515@linaro.org>
 <CAKv+Gu9mwj0qscQJSH8wEi0zYC0anrr1hBYbdFE83iN+oQLnRQ@mail.gmail.com>
 <56DED0F6.8040602@redhat.com>
Message-ID: <CAKv+Gu85H2ivOQ617xaZnZrpnH3xGTfHtgwSRvTqiKB=UW3Tpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2016 at 20:17, Mark Langsdorf <mlangsdo@redhat.com> wrote:
> On 03/08/2016 04:31 AM, Ard Biesheuvel wrote:
>>
>> On 8 March 2016 at 09:15, Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> wrote:
>>>
>>>
>>>
>>>> On 8 mrt. 2016, at 08:07, David Daney <ddaney.cavm@gmail.com> wrote:
>>>>
>>>>> On 02/26/2016 08:57 AM, Ard Biesheuvel wrote:
>>>>> Commit dd006da21646 ("arm64: mm: increase VA range of identity map")
>>>>> made
>>>>> some changes to the memory mapping code to allow physical memory to
>>>>> reside
>>>>> at an offset that exceeds the size of the virtual mapping.
>>>>>
>>>>> However, since the size of the vmemmap area is proportional to the size
>>>>> of
>>>>> the VA area, but it is populated relative to the physical space, we may
>>>>> end up with the struct page array being mapped outside of the vmemmap
>>>>> region. For instance, on my Seattle A0 box, I can see the following
>>>>> output
>>>>> in the dmesg log.
>>>>>
>>>>>     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB
>>>>> maximum)
>>>>>               0xffffffbfc0000000 - 0xffffffbfd0000000   (   256 MB
>>>>> actual)
>>>>>
>>>>> We can fix this by deciding that the vmemmap region is not a projection
>>>>> of
>>>>> the physical space, but of the virtual space above PAGE_OFFSET, i.e.,
>>>>> the
>>>>> linear region. This way, we are guaranteed that the vmemmap region is
>>>>> of
>>>>> sufficient size, and we can even reduce the size by half.
>>>>>
>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>
>>>>
>>>> I see this commit now in Linus' kernel.org tree in v4.5-rc7.
>>>>
>>>> FYI:  I am seeing a crash that goes away when I revert this.  My kernel
>>>> has some other modifications (our NUMA patches) so I haven't yet fully
>>>> tracked this down on an unmodified kernel, but this is what I am getting:
>>>>
>>>
>>
>> I managed to reproduce and diagnose this. The problem is that vmemmap
>> is no longer zone aligned, which causes trouble in the zone based
>> rounding that occurs in memory_present. The below patch fixes this by
>> rounding down the subtracted offset. Since this implies that the
>> region could stick off the other end, it also reverts the halving of
>> the region size.
>
>
> This fixes the bug on my Seattle B0 system.
>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>


Thanks Mark
