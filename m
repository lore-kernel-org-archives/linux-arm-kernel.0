From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 24 Oct 2014 15:41:48 +0200
Subject: gcc 4.9 build warnings (was: Re: arm-soc build: 2917 warnings 0
 failures (arm-soc/v3.18-rc1-20-g06c0773))
In-Reply-To: <2567100.Zj7YMcXpZG@wuerfel>
References: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
 <1847682.hInUtg9rQz@wuerfel>
 <CAKv+Gu_4X0RNbgJ+BCb9+ccgTKBjcwb9L4aDUY6fFMa0R3PX-w@mail.gmail.com>
 <2567100.Zj7YMcXpZG@wuerfel>
Message-ID: <CAKv+Gu-0jenous5sLPp+QJa3qRk-RiBgG1vVYP_RmVw0uXaysw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 October 2014 15:27, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 24 October 2014 13:50:05 Ard Biesheuvel wrote:
>> On 24 October 2014 13:37, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 24 October 2014 12:59:40 Ard Biesheuvel wrote:
>> >> On 24 October 2014 12:52, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >> > On Fri, Oct 24, 2014 at 12:49:50PM +0200, Arnd Bergmann wrote:
>> >> >> >       1 drivers/video/fbdev/sm501fb.c:245:2: warning: format '%zd' expects argument of type 'signed size_t', but argument 8 has type 'size_t' [-Wformat=]
>> >> >> >       1 mm/percpu.c:895:3: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'unsigned int' [-Wformat=]
>> >> >> >       1 mm/percpu.c:895:3: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]
>> >> >>
>> >> >> The warnings are completely unchanged, still 249 unique warnings involving size_t,
>> >> >> using this patch:
>> >> >
>> >> > That's probably because the compiler is expecting size_t to be typedef'd
>> >> > to __SIZE_TYPE__ and isn't expecting anyone to change it.
>> >> >
>> >>
>> >> Indeed, I wouldn't expect the printf format validation code inside GCC
>> >> to care about the actual values of macros and typedefs.
>> >> Could someone dump the builtin #define's of that compiler? For
>> >> instance, my bare metal 4.9 BE GCC gives me
>> >>
>> >> $ /usr/local/gcc-linaro-armeb-none-eabi-4.9-2014.06_linux/bin/armeb-none-eabi-gcc
>> >> -E -dM - <<<"" |grep _TYPE__
>> >> #define __UINT_LEAST8_TYPE__ unsigned char
>> >> #define __SIG_ATOMIC_TYPE__ int
>> >> #define __UINTMAX_TYPE__ long long unsigned int
>> >> #define __INT_FAST16_TYPE__ int
>> >> #define __INT_FAST64_TYPE__ long long int
>> >> #define __UINT8_TYPE__ unsigned char
>> >> #define __INT_FAST32_TYPE__ int
>> >> #define __UINT_LEAST16_TYPE__ short unsigned int
>> >> #define __SIZE_TYPE__ unsigned int
>> >> #define __INT8_TYPE__ signed char
>> >> #define __INT_LEAST16_TYPE__ short int
>> >> #define __UINT_LEAST64_TYPE__ long long unsigned int
>> >> #define __UINT_FAST16_TYPE__ unsigned int
>> >> #define __CHAR16_TYPE__ short unsigned int
>> >> #define __INT_LEAST64_TYPE__ long long int
>> >> #define __INT16_TYPE__ short int
>> >> #define __INT_LEAST8_TYPE__ signed char
>> >> #define __INTPTR_TYPE__ int
>> >> #define __UINT16_TYPE__ short unsigned int
>> >> #define __WCHAR_TYPE__ unsigned int
>> >> #define __UINT_FAST64_TYPE__ long long unsigned int
>> >> #define __INT64_TYPE__ long long int
>> >> #define __WINT_TYPE__ unsigned int
>> >> #define __UINT_LEAST32_TYPE__ long unsigned int
>> >> #define __INT_LEAST32_TYPE__ long int
>> >> #define __UINT64_TYPE__ long long unsigned int
>> >> #define __INT_FAST8_TYPE__ int
>> >> #define __UINT_FAST32_TYPE__ unsigned int
>> >> #define __CHAR32_TYPE__ long unsigned int
>> >> #define __INT32_TYPE__ long int
>> >> #define __INTMAX_TYPE__ long long int
>> >> #define __PTRDIFF_TYPE__ int
>> >> #define __UINT32_TYPE__ long unsigned int
>> >> #define __UINTPTR_TYPE__ unsigned int
>> >> #define __UINT_FAST8_TYPE__ unsigned int
>> >>
>> >> What is surprising here is that __SIZE_TYPE__ is int not long. Could
>> >> we in fact be dealing with a 4.9 bare metal GCC bug here?
>> >
>> > This is what I get on every arm gcc version on my system,
>> > all glibc or uClibc targetted, compared to yours:
>> >
>> >  #define __UINT_FAST64_TYPE__ long long unsigned int
>> >  #define __INT64_TYPE__ long long int
>> >  #define __WINT_TYPE__ unsigned int
>> > -#define __UINT_LEAST32_TYPE__ long unsigned int
>> > -#define __INT_LEAST32_TYPE__ long int
>> > +#define __UINT_LEAST32_TYPE__ unsigned int
>> > +#define __INT_LEAST32_TYPE__ int
>> >  #define __UINT64_TYPE__ long long unsigned int
>> > -#define __INT_FAST8_TYPE__ int
>> > +#define __INT_FAST8_TYPE__ signed char
>> >  #define __UINT_FAST32_TYPE__ unsigned int
>> > -#define __CHAR32_TYPE__ long unsigned int
>> > -#define __INT32_TYPE__ long int
>> > +#define __CHAR32_TYPE__ unsigned int
>> > +#define __INT32_TYPE__ int
>> >  #define __INTMAX_TYPE__ long long int
>> >  #define __PTRDIFF_TYPE__ int
>> > -#define __UINT32_TYPE__ long unsigned int
>> > +#define __UINT32_TYPE__ unsigned int
>> >  #define __UINTPTR_TYPE__ unsigned int
>> > -#define __UINT_FAST8_TYPE__ unsigned int
>> > +#define __UINT_FAST8_TYPE__ unsigned char
>> >
>>
>> So no __SiZE_TYPE__ then? That's surprising ...
>>
>
> Sorry for being unclear here: this is only the diff between my version and
> yours, so everything that is not listed above __UINT_FAST64_TYPE__ is the
> same on both compilers.
>

Ah, ok. So apparently, size_t is not ambiguous between bare metal and
glibc GCC, so we are looking at something else here.

-- 
Ard.
