From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 12 Jan 2017 18:01:49 +0000
Subject: [kvm-unit-tests PATCH 1/6] libcflat: add PRI(dux)32 format types
In-Reply-To: <144fdce4-ddd4-0c93-296b-44aeec57c664@redhat.com>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
 <20170111162841.15569-2-alex.bennee@linaro.org>
 <4286b719-ff75-d2cd-68b5-cb9d9bb89553@redhat.com>
 <20170112165629.nbczamlqlpsqaauh@hawk.localdomain>
 <87fuko2o4e.fsf@linaro.org> <144fdce4-ddd4-0c93-296b-44aeec57c664@redhat.com>
Message-ID: <87eg082m42.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/01/2017 18:18, Alex Benn?e wrote:
>>> Although I feel there should be a compiler macro way to do this without
>>> a need for configure/makefile trickery at all...
>>
>> I did ask our toolchain bods. They started going on about potential
>> solutions using _Generic but I fear that might be worse in this case!
>
> I don't think _Generic can do string concatenation, can it?
>
> inttypes.h is not part of the set of freestanding headers, only stdint.h
> is.  Who is providing stdint.h in your case?

/usr/lib/gcc/arm-none-eabi/5.4.1/include/stdint.h

is part of the compiler package although it can just include the lib
stdint.h if it is there:

  #ifndef _GCC_WRAP_STDINT_H
  #if __STDC_HOSTED__
  # if defined __cplusplus && __cplusplus >= 201103L
  #  undef __STDC_LIMIT_MACROS
  #  define __STDC_LIMIT_MACROS
  #  undef __STDC_CONSTANT_MACROS
  #  define __STDC_CONSTANT_MACROS
  # endif
  # include_next <stdint.h>
  #else
  # include "stdint-gcc.h"
  #endif
  #define _GCC_WRAP_STDINT_H
  #endif

So using inttypes we would get:

>arm-none-eabi-gcc ./test.c -E | grep typedef | grep uint32
typedef long unsigned int __uint32_t;
typedef __uint32_t uint32_t ;


--
Alex Benn?e
