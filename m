From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 1 Feb 2017 18:19:52 +0000
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <CAKv+Gu9G+r7eH0mhniH1+ucrHNiGBMFQdKfMOi=OmekapoBtUg@mail.gmail.com>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
 <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
 <20161019155658.GB4411@x4>
 <CA+55aFx=ZX=7u07R6zJ7fSw=zSQNaYqVX7R3LQs4riiEf+uA=A@mail.gmail.com>
 <20161019162222.GT9193@arm.com>
 <c578d5ac-ab8a-974a-bdd9-597b8c545583@redhat.com>
 <CAKv+Gu9G+r7eH0mhniH1+ucrHNiGBMFQdKfMOi=OmekapoBtUg@mail.gmail.com>
Message-ID: <CAKv+Gu_kifdUOwKgGv1xqboPMjyYRhHwFXDye1HpBo9hQY+_Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2017 at 17:36, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 1 February 2017 at 16:58, Laura Abbott <labbott@redhat.com> wrote:
>> On 10/19/2016 09:22 AM, Will Deacon wrote:
>>> On Wed, Oct 19, 2016 at 09:01:33AM -0700, Linus Torvalds wrote:
>>>> On Wed, Oct 19, 2016 at 8:56 AM, Markus Trippelsdorf
>>>> <markus@trippelsdorf.de> wrote:
>>>>> On 2016.10.19 at 08:55 -0700, Linus Torvalds wrote:
>>>>>>
>>>>>> Well, in the meantime we apparently have to live with it. Unless Will
>>>>>> is using some unreleased gcc version that nobody else is using and we
>>>>>> can just ignore it?
>>>>>
>>>>> Yes, he is using gcc-7 that is unreleased. (It will be released April
>>>>> next year.)
>>>>
>>>> Ahh, self-built? So it's not part of some experimental ARM distro
>>>> setup and this will be annoying lots of people?
>>>
>>> Our friendly compiler guys built it, but it's just a snapshot of trunk,
>>> so it's all heading towards GCC 7.0. AFAIU, the problematic optimisation
>>> is also a mid-end pass, so it would affect other architectures too.
>>>
>>>> If so, still think that we could just get rid of the ____ilog2_NaN()
>>>> thing as it's not _that_ important, but it's certainly not very
>>>> high-priority. Will can do it in his tree too for testing, and it can
>>>> remind people to get the gcc problem fixed.
>>>
>>> I'm carrying the diff below, which fixes arm64 defconfig, but I'm worried
>>> that we might be relying on this trick elsewhere. The arm __bad_cmpxchg
>>> function, for example.
>>>
>>> Will
>>>
>>> --->8
>>>
>>> diff --git a/include/linux/log2.h b/include/linux/log2.h
>>> index fd7ff3d91e6a..9cf5ad69065d 100644
>>> --- a/include/linux/log2.h
>>> +++ b/include/linux/log2.h
>>> @@ -16,12 +16,6 @@
>>>  #include <linux/bitops.h>
>>>
>>>  /*
>>> - * deal with unrepresentable constant logarithms
>>> - */
>>> -extern __attribute__((const, noreturn))
>>> -int ____ilog2_NaN(void);
>>> -
>>> -/*
>>>   * non-constant log of base 2 calculators
>>>   * - the arch may override these in asm/bitops.h if they can be implemented
>>>   *   more efficiently than using fls() and fls64()
>>> @@ -85,7 +79,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>>>  #define ilog2(n)                             \
>>>  (                                            \
>>>       __builtin_constant_p(n) ? (             \
>>> -             (n) < 1 ? ____ilog2_NaN() :     \
>>> +             (n) < 1 ? 0 :                   \
>>>               (n) & (1ULL << 63) ? 63 :       \
>>>               (n) & (1ULL << 62) ? 62 :       \
>>>               (n) & (1ULL << 61) ? 61 :       \
>>> @@ -149,9 +143,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>>>               (n) & (1ULL <<  3) ?  3 :       \
>>>               (n) & (1ULL <<  2) ?  2 :       \
>>>               (n) & (1ULL <<  1) ?  1 :       \
>>> -             (n) & (1ULL <<  0) ?  0 :       \
>>> -             ____ilog2_NaN()                 \
>>> -                                ) :          \
>>> +             0) :                            \
>>>       (sizeof(n) <= 4) ?                      \
>>>       __ilog2_u32(n) :                        \
>>>       __ilog2_u64(n)                          \
>>> @@ -194,7 +186,6 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>>>   * @n: parameter
>>>   *
>>>   * The first few values calculated by this routine:
>>> - *  ob2(0) = 0
>>>   *  ob2(1) = 0
>>>   *  ob2(2) = 1
>>>   *  ob2(3) = 2
>>>
>>
>> Reviving this thread as gcc 7 has now hit Fedora rawhide and has this
>> same issue. I pulled in the above patch from Will as a temporary work
>> around for building. It didn't look like there was consensus on a
>> permanent solution though from the thread.
>>
>
> I still think order_base_2() is broken, since it may invoke
> roundup_pow_of_two() with an input value that is documented as
> producing undefined output. I would argue that the below is the
> correct fix.
>
> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index fd7ff3d91e6a..46523731bec0 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
> @@ -203,6 +203,18 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
>   *  ... and so on.
>   */
>
> -#define order_base_2(n) ilog2(roundup_pow_of_two(n))
> +static inline __attribute__((__const__))
> +unsigned long __order_base_2(unsigned long n)
> +{
> +       return n ? 1UL << fls_long(n - 1) : 1;
> +}
> +
> +#define order_base_2(n)                                \
> +(                                              \
> +       __builtin_constant_p(n) ? (             \
> +               ((n) < 2) ? (n) :               \
> +               ilog2((n) - 1) + 1) :           \
> +       ilog2(__order_base_2(n))                \
> + )
>
>  #endif /* _LINUX_LOG2_H */

Actually, there is a still a redundant shift/fls() in there, this is
even simpler:

diff --git a/include/linux/log2.h b/include/linux/log2.h
index fd7ff3d91e6a..4741534bd7af 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -203,6 +203,18 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  *  ... and so on.
  */

-#define order_base_2(n) ilog2(roundup_pow_of_two(n))
+static inline __attribute__((__const__))
+unsigned long __order_base_2(unsigned long n)
+{
+       return n > 1 ? ilog2(n - 1) + 1 : 0;
+}
+
+#define order_base_2(n)                                \
+(                                              \
+       __builtin_constant_p(n) ? (             \
+               ((n) < 2) ? (n) :               \
+               ilog2((n) - 1) + 1) :           \
+       __order_base_2(n)                       \
+ )

 #endif /* _LINUX_LOG2_H */
