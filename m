From: andreyknvl@google.com (Andrey Konovalov)
Date: Wed, 14 Nov 2018 20:52:29 +0100
Subject: [PATCH v10 08/22] kasan, arm64: untag address in __kimg_to_phys
 and _virt_addr_is_linear
In-Reply-To: <20181107181054.GC255021@arrakis.emea.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <b2aa056b65b8f1a410379bf2f6ef439d5d99e8eb.1541525354.git.andreyknvl@google.com>
 <20181107181054.GC255021@arrakis.emea.arm.com>
Message-ID: <CAAeHK+zSEUq-bBide_kqwY831vQpxYUpjUNhPKSD0aC4OyewKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 7:10 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Nov 06, 2018 at 06:30:23PM +0100, Andrey Konovalov wrote:
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -92,6 +92,15 @@
>>  #define KASAN_THREAD_SHIFT   0
>>  #endif
>>
>> +#ifdef CONFIG_KASAN_SW_TAGS
>> +#define KASAN_TAG_SHIFTED(tag)               ((unsigned long)(tag) << 56)
>> +#define KASAN_SET_TAG(addr, tag)     (((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
>> +                                             KASAN_TAG_SHIFTED(tag))
>> +#define KASAN_RESET_TAG(addr)                KASAN_SET_TAG(addr, 0xff)
>> +#else
>> +#define KASAN_RESET_TAG(addr)                addr
>> +#endif
>
> I think we should reuse the untagged_addr() macro we have in uaccess.h
> (make it more general and move to another header file).

Will do in v11, thanks!
