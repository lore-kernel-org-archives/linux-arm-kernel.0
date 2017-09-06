From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Sep 2017 01:18:03 +0200
Subject: HAVE_EFFICIENT_UNALIGNED_ACCESS on ARM32 (was: Alignment issues
 in zImage with Linux 4.12, LZ4 and GCC5.3)
In-Reply-To: <CAKv+Gu_UO_Td2kkN-2k1LzTWJGXO8vZaZdQkN-xnqsK=K5T20g@mail.gmail.com>
References: <CAGkQfmOKqFWisiRjkCHBHDwgY5A0HA_+hcLYSeDYaoGQ6CVu6Q@mail.gmail.com>
 <CAK8P3a3AQ43t2q1MVN9PoqQXZiuXQo1uDcGnRAPCiT66_oDyLg@mail.gmail.com>
 <CAKv+Gu_6kxidH-4YwuCorJx25WSZDsOdtbZ6MZCv+R4ufzUjrw@mail.gmail.com>
 <CAK8P3a1xX5RfM1kao7WZBmS=0J=MgNZTH2_c-nSOY+GNmjNsUA@mail.gmail.com>
 <CAKv+Gu_UO_Td2kkN-2k1LzTWJGXO8vZaZdQkN-xnqsK=K5T20g@mail.gmail.com>
Message-ID: <CAK8P3a0ECzB5ahbdmgM7=1NGkOaEc+wzr_EHbuQJij0+nygbLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 7, 2017 at 12:48 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 6 September 2017 at 23:38, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Sep 7, 2017 at 12:23 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 6 September 2017 at 21:57, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Mon, Sep 4, 2017 at 6:19 PM, Romain Izard <romain.izard.pro@gmail.com> wrote:
>>>
>>> HAVE_EFFICIENT_UNALIGNED_ACCESS only affects explicit unaligned
>>> accesses, and selects between fixups in hardware or in software.
>>> AFAICT the issue here is implicit unaligned accesses, where char
>>> pointers are passed as u32 * arguments.
>>
>> The problem with include/linux/unaligned/access_ok.h is that it
>> converts pointers
>> that are known by the caller to be potentially unaligned and accesses them as if
>> they were aligned. This means we require a software fixup through the
>> trap handler
>> on ARM in cases that the compiler already knows how to handle correctly when
>> using linux/unaligned/le_struct.h. On ARMv7 this means it ends up using normal
>> load/store instructures but not the ldm/stm or ldrd/stdr instructions
>> that are not
>> allowed on unaligned pointers.
>>
>
> Ah ok, I missed that part. The distinction between ldr/str and
> ldm/stm/ldrd is a bit fiddly, but if we can solve this using C code, I
> am all for it.
>
>> Doing that solves the problem that Romain ran into and also makes other
>> code much more efficient on ARMv7.
>>
>
> It is not entirely clear to me why casting to a pointer-to-struct type
> makes any difference here. Is it simply because of the __packed
> attribute?

The problem is code like

struct twoint {
   int a; int b;
};
void __noinline access_unaligned_8bytes(struct twoint *s, int a, int b)
{
       put_unaligned(a, &s->a);
       put_unaligned(b, &s->b);
}
int caller(char *c, int offset, int a, int b)
{
       access_unaligned_8bytes((void *)c + offset, a, b);
}

With include/linux/unaligned/access_ok.h, this turns into two stores
that gcc can combine into a single 'strd' or 'stm'. With the
linux/unaligned/le_struct.h version, gcc knows that the pointer
may be unaligned, so it will use instructions that it knows are
safe, either byte accesses (on armv5 and earlier) or normal
str (on armv6+).

> Anyway, the issue I spotted in the LZ4 code did not use unaligned
> accessors at all, so we must be talking about different things here.

I see lots of unaligned helpers in the lz4 code, is this not what
we hit?

$ git grep unaligned lib/
lib/lz4/lz4_compress.c:#include <asm/unaligned.h>
lib/lz4/lz4_decompress.c:#include <asm/unaligned.h>
lib/lz4/lz4defs.h:#include <asm/unaligned.h>
lib/lz4/lz4defs.h:      return get_unaligned((const U16 *)ptr);
lib/lz4/lz4defs.h:      return get_unaligned((const U32 *)ptr);
lib/lz4/lz4defs.h:      return get_unaligned((const size_t *)ptr);
lib/lz4/lz4defs.h:      put_unaligned(value, (U16 *)memPtr);

       Arnd
