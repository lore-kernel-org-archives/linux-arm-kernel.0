From: keescook@chromium.org (Kees Cook)
Date: Fri, 26 Sep 2014 09:43:12 -0700
Subject: [PATCH v6 7/8] ARM: mm: allow non-text sections to be
 non-executable
In-Reply-To: <20140926114239.GM5182@n2100.arm.linux.org.uk>
References: <1411067949-10913-1-git-send-email-keescook@chromium.org>
 <1411067949-10913-8-git-send-email-keescook@chromium.org>
 <20140926114239.GM5182@n2100.arm.linux.org.uk>
Message-ID: <CAGXu5jL+ksQ4nq4pxOk7gM0POmwtTQ7DgmugpVK45arpMLGzvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 4:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 18, 2014 at 12:19:08PM -0700, Kees Cook wrote:
>> @@ -1373,13 +1373,24 @@ static void __init map_lowmem(void)
>>               if (start >= end)
>>                       break;
>>
>> -             if (end < kernel_x_start || start >= kernel_x_end) {
>> +             if (end < kernel_x_start) {
>>                       map.pfn = __phys_to_pfn(start);
>>                       map.virtual = __phys_to_virt(start);
>>                       map.length = end - start;
>>                       map.type = MT_MEMORY_RWX;
>>
>>                       create_mapping(&map);
>> +             } else if (start >= kernel_x_end) {
>> +                     map.pfn = __phys_to_pfn(start);
>> +                     map.virtual = __phys_to_virt(start);
>> +                     map.length = end - start;
>> +#ifdef CONFIG_ARM_KERNMEM_PERMS
>> +                     map.type = MT_MEMORY_RW;
>> +#else
>> +                     map.type = MT_MEMORY_RWX;
>> +#endif
>> +
>> +                     create_mapping(&map);
>
>
> I'm looking at this, and wondering two things.  Firstly, why isn't it
> MT_MEMORY_RW in the first place.  Secondly, why do you need to make
> this depend on CONFIG_ARM_KERNMEM_PERMS at all?
>
> I think the first is an oversight by me (and is a case which never came
> up in my testing, because most of my platforms don't have segmented
> memory layouts.)
>
> The second I think is not necessary - the memory region being considered
> is not part of the kernel at all, and so should not be executable in any
> shape or form.

I'm happy to change this. My original intent was to make layout for
builds without CONFIG_ARM_KERNMEM_PERMS identical to what was there
before, so I took this step to make sure.

I will drop the #ifdef and respin. Does the rest look ok? Shall I send
a pull request?

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
