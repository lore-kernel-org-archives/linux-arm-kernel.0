From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Tue, 10 Jan 2017 15:29:08 +0000
Subject: [kvm-unit-tests PATCH v7 04/11] libcflat: add PRI(dux)32 format
 types
In-Reply-To: <87r34b2b3a.fsf@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
 <20161124161033.11456-5-alex.bennee@linaro.org> <87r34b2b3a.fsf@linaro.org>
Message-ID: <87pojv2at7.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Alex Benn?e <alex.bennee@linaro.org> writes:

> Alex Benn?e <alex.bennee@linaro.org> writes:
>
>> So we can have portable formatting of uint32_t types.
>>
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>> ---
>>  lib/libcflat.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/lib/libcflat.h b/lib/libcflat.h
>> index bdcc561..6dab5be 100644
>> --- a/lib/libcflat.h
>> +++ b/lib/libcflat.h
>> @@ -55,12 +55,17 @@ typedef _Bool		bool;
>>  #define true  1
>>
>>  #if __SIZEOF_LONG__ == 8
>> +#  define __PRI32_PREFIX
>>  #  define __PRI64_PREFIX	"l"
>>  #  define __PRIPTR_PREFIX	"l"
>>  #else
>> +#  define __PRI32_PREFIX        "l"
>
> OK this is bogus, but the failure is because of where we get uint32_t
> from (hint using arm32 compiler on a arm64 system) so I got:
>
>   lib/pci.c:71:9: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'uint32_t {aka long unsigned int}' [-Werro\
> r=format=]
>
> Which makes me think we should be more careful about including system
> headers in kvm-unit-tests (done in 75e777a0).

Hmm it turns out my compiler is d.r.t as far as it is concerned:

  # 34 "/usr/lib/gcc/arm-none-eabi/5.4.1/include/stdint-gcc.h" 3 4
  typedef signed char int8_t;


  typedef short int int16_t;


  typedef long int int32_t;


  typedef long long int int64_t;


  typedef unsigned char uint8_t;


  typedef short unsigned int uint16_t;


  typedef long unsigned int uint32_t;


--
Alex Benn?e
