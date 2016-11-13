From: appro@openssl.org (Andy Polyakov)
Date: Sun, 13 Nov 2016 22:47:34 +0100
Subject: [PATCH v3] crypto: arm64/sha2: integrate OpenSSL implementations
 of SHA256/SHA512
In-Reply-To: <c82fd8f0-5c0e-74d9-fbf3-b2a5c0dc3a1c@openssl.org>
References: <1478953953-11523-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161112221520.GD24127@arm.com>
 <CAKv+Gu_Y-ik0L9mh4z-g3fHKjPt780_znCQNU-jAwXifLgAo4A@mail.gmail.com>
 <c8306030-d4eb-fea7-441a-3476cd308496@openssl.org>
 <CAKv+Gu8ouGT31ZqtiX5dFk-QnezjdNHOnP9ErbTDg70tVUU+YA@mail.gmail.com>
 <c82fd8f0-5c0e-74d9-fbf3-b2a5c0dc3a1c@openssl.org>
Message-ID: <75340ad1-0632-b853-c993-5097b98abf77@openssl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> Looking at the generated code, I see references to __ARMEB__ and
>>>> __ILP32__.
>>>>> The former is probably a bug,
>>>
>>> Oh! You mean that it should be __AARCH64EB__/__AARCH64EL__!
>>
>> Indeed:
>>
>> $ aarch64-linux-gnu-gcc -dM -E  - <<<""   |grep AARCH
>> #define __AARCH64_CMODEL_SMALL__ 1
>> #define __AARCH64EL__ 1
>>
>> $ aarch64-linux-gnu-gcc -dM -E -mbig-endian - <<<""   |grep AARCH
>> #define __AARCH64_CMODEL_SMALL__ 1
>> #define __AARCH64EB__ 1
> 
> As it turns out it wasn't really an overlook, at least not in OpenSSL
> context, as I force __ARMEB__/__ARMEL__ in 64-bit build through
> arm_arch.h, which in turn is shared between 32- and 64-bit builds. But
> shared code should be preferred to be self-sufficient. It doesn't mean
> that it won't be fixed, only that it wasn't really a bug in OpenSSL context.
> 

https://github.com/openssl/openssl/pull/1914.
