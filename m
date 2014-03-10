From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Mon, 10 Mar 2014 11:32:17 -0700
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <20140307044251.GD9985@codeaurora.org>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
 <20140307044251.GD9985@codeaurora.org>
Message-ID: <CADHgK6s4K+K+OZuUZVbHKNzbFiHzm82Ss0WpSfkUdQgP+E3j=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2014 20:42, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 03/05, Sebastian Capella wrote:
>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
>> index 8756e4b..d32adbb 100644
>> --- a/arch/arm/include/asm/memory.h
>> +++ b/arch/arm/include/asm/memory.h
>> @@ -291,6 +291,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>>   */
>>  #define __pa(x)                      __virt_to_phys((unsigned long)(x))
>>  #define __va(x)                      ((void *)__phys_to_virt((phys_addr_t)(x)))
>> +#define __pa_symbol(x)               __pa((unsigned long)(x))
> Looking at this definition now it doesn't look right. Isn't
> &__nosave_begin a virtual address? Casting it to an unsigned long
> isn't going to give you a physical address. Why can't we use
> __pa()?

You're correct, sorry, I missed removing the cast, it's not needed.
I've removed the __pa_symbol define as I'm switching to the __pa
implementation you suggested below.

>> +extern const void __nosave_begin, __nosave_end;
>> +
>> +int pfn_is_nosave(unsigned long pfn)
>> +{
>> +     unsigned long nosave_begin_pfn =
>> +                     __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
>> +     unsigned long nosave_end_pfn =
>> +                     PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
>> +
>> +     return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
>> +}
>
> Perhaps this code could be:
>
>         unsigned long nosave_begin_pfn = virt_to_pfn(&__nosave_begin);
>         unsigned long nosave_end_pfn = virt_to_pfn(&__nosave_end);
>
>         return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);
>
> or if virt_to_pfn() doesn't exist on ARM and we can't add it for
> some reason:
>
>         unsigned long nosave_begin_pfn = __phys_to_pfn(__pa(&__nosave_begin));
>         unsigned long nosave_end_pfn = __phys_to_pfn(__pa(&__nosave_end));
>
>         return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);
I've moved to this second implementation.  I don't think I understand
the ramifications enough to add the virt_to_pfn call for arm.

I've changed one thing.  __nosave_end is pointing@the first byte
not included in the nosave region.  I subtracted one from it so that
we make sure we're referring to the last pfn, and left the pfn
comparison as you'd suggested.

int pfn_is_nosave(unsigned long pfn)
{
        unsigned long nosave_begin_pfn = __phys_to_pfn(__pa(&__nosave_begin));
        unsigned long nosave_end_pfn = __phys_to_pfn(__pa(&__nosave_end - 1));

        return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);
}

I'll test this and post it if everyone's ok with it.

Thanks for your review and comments Stephen!

Sebastian
