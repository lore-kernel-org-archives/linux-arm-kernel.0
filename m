From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Nov 2018 22:00:09 +0100
Subject: [PATCH v3 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
In-Reply-To: <0257ee07-8b85-5295-1490-72c7aa14943d@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
 <20181031192843.13230-5-f.fainelli@gmail.com>
 <CAKv+Gu85kRVos-z+1WuV5J8bTHpLDDdUu0hVD2NmZ-w-ry5f4g@mail.gmail.com>
 <537b8384-629a-770b-e506-f4d49b92e758@gmail.com>
 <CAKv+Gu88HHe-ZpVS3w+0Eu+Q-zYaN3sKDK4uaG+eecVtr-C9PA@mail.gmail.com>
 <0257ee07-8b85-5295-1490-72c7aa14943d@gmail.com>
Message-ID: <CAKv+Gu8-ZbNx+oQPfHRVbWrBi4K+sa7JA_5KKSMn2QbStc8kNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 November 2018 at 21:51, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 11/5/18 12:44 PM, Ard Biesheuvel wrote:
>> On 5 November 2018 at 21:41, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> On 11/5/18 12:39 PM, Ard Biesheuvel wrote:
>>>> Hi Florian,
>>>>
>>>> On 31 October 2018 at 20:28, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>> ARM64 is the only architecture that re-defines
>>>>> __early_init_dt_declare_initrd() in order for that function to populate
>>>>> initrd_start/initrd_end with physical addresses instead of virtual
>>>>> addresses. Instead of having an override we can leverage
>>>>> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
>>>>> populate those variables for us.
>>>>>
>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>> ---
>>>>>  arch/arm64/mm/init.c | 19 +++++++++----------
>>>>>  1 file changed, 9 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>> index 3cf87341859f..00ef2166bb73 100644
>>>>> --- a/arch/arm64/mm/init.c
>>>>> +++ b/arch/arm64/mm/init.c
>>>>> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>>>>>         if (*endp == ',') {
>>>>>                 size = memparse(endp + 1, NULL);
>>>>>
>>>>> -               initrd_start = start;
>>>>> -               initrd_end = start + size;
>>>>> +               phys_initrd_start = start;
>>>>> +               phys_initrd_size = size;
>>>>>         }
>>>>>         return 0;
>>>>>  }
>>>>> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>>>>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>>>>         }
>>>>>
>>>>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>>>>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>>>>>                 /*
>>>>>                  * Add back the memory we just removed if it results in the
>>>>>                  * initrd to become inaccessible via the linear mapping.
>>>>>                  * Otherwise, this is a no-op
>>>>>                  */
>>>>> -               u64 base = initrd_start & PAGE_MASK;
>>>>> -               u64 size = PAGE_ALIGN(initrd_end) - base;
>>>>> +               u64 base = phys_initrd_start & PAGE_MASK;
>>>>> +               u64 size = PAGE_ALIGN(phys_initrd_size);
>>>>>
>>>>>                 /*
>>>>>                  * We can only add back the initrd memory if we don't end up
>>>>> @@ -460,12 +460,11 @@ void __init arm64_memblock_init(void)
>>>>>          */
>>>>>         memblock_reserve(__pa_symbol(_text), _end - _text);
>>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>>> -       if (initrd_start) {
>>>>> -               memblock_reserve(initrd_start, initrd_end - initrd_start);
>>>>> -
>>>>> +       if (phys_initrd_size) {
>>>>>                 /* the generic initrd code expects virtual addresses */
>>>>> -               initrd_start = __phys_to_virt(initrd_start);
>>>>> -               initrd_end = __phys_to_virt(initrd_end);
>>>>> +               initrd_start = __phys_to_virt(phys_initrd_start);
>>>>> +               initrd_end = initrd_start + phys_initrd_size;
>>>>> +               initrd_below_start_ok = 0;
>>>>
>>>> Where is this assignment coming from?
>>>
>>> __early_init_dt_declare_initrd() sets initrd_below_start_ok to 1 though
>>> after patch #5 this is not necessary any more.
>>
>> Yes, but why? The original arm64 version of
>> __early_init_dt_declare_initrd() does not set it but now you set to 1
>> in the IS_ENABLED(CONFIG_ARM64) section in the generic code and set it
>> back to 0 here.
>
> Humm, it is an if (!IS_ENABLED(CONFIG_ARM64)) condition, so we would not
> be taking that branch on an ARM64 kernel.
>

Right. So now that we are not setting it to 1 on arm64, there is no
longer a reason to set it to 0 again, no?

> If you are saying the assignment is not necessary anymore after patch #5
> , that is true, though this can only be done a part of part #5, not as
> part of patch #4 in order not to break initrd functionality in-between
> patches.
>
>>
>> Or am I missing something?
>>
>
> Not sure, I could be too, it's Monday after all :)

Yeah :-)
