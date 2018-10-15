From: keescook@chromium.org (Kees Cook)
Date: Mon, 15 Oct 2018 15:38:53 -0700
Subject: [RFC 17/17] arm64: compile the kernel with ptrauth
 -msign-return-address
In-Reply-To: <d0e36e1f-fa1a-f4ab-5a83-11e095801fef@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-18-kristina.martsenko@arm.com>
 <d0e36e1f-fa1a-f4ab-5a83-11e095801fef@arm.com>
Message-ID: <CAGXu5jL5v_Db9RnLYEJtFcGHYf3j023Kxd5eWvtpBjYYQorYMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 7:23 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> Hi Kristina,
>
> On 05/10/18 09:47, Kristina Martsenko wrote:
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 106039d25e2f..dbcd43ea99d8 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -56,6 +56,10 @@ KBUILD_AFLAGS      += $(lseinstr) $(brokengasinst)
>>  KBUILD_CFLAGS        += $(call cc-option,-mabi=lp64)
>>  KBUILD_AFLAGS        += $(call cc-option,-mabi=lp64)
>>
>> +ifeq ($(CONFIG_ARM64_PTR_AUTH),y)
>> +KBUILD_CFLAGS        += -msign-return-address=all
>> +endif
>
> Should not it be done via cc-option so old toolchains keep working [1]?
>
> [1]
> $ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Linaro GCC 2014.11) 4.9.3 20141031 (prerelease)
> Copyright (C) 2014 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> $ aarch64-linux-gnu-gcc -msign-return-address=all
> aarch64-linux-gnu-gcc: error: unrecognized command line option '-msign-return-address=all'
> ...

I would like to see CONFIG_ARM64_PTR_AUTH testing for compiler support
via Kconfig (as stack-protector does). This would allow developers to
only see the option if it was available (i.e. no "downgrade" happens
if the compiler is missing support). Using cc-option runs the risk of
building a kernel with CONFIG_ARM64_PTR_AUTH set, but _not_ actually
using ptr auth.

-Kees

-- 
Kees Cook
Pixel Security
