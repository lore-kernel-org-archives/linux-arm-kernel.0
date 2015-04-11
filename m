From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 11 Apr 2015 12:35:19 +0200
Subject: [PATCH] crypto: arm: workaround for building with old binutils
In-Reply-To: <2148670.W34n3asXfA@wuerfel>
References: <3461827.FYLMCAIQyv@wuerfel>
 <CAKv+Gu_n0-sMZZjWOmQ5koEfJRX6jqme5WOOP1zrF_zMnB7=nA@mail.gmail.com>
 <2148670.W34n3asXfA@wuerfel>
Message-ID: <51652361-AEE7-4C88-920A-5F0ED60EE275@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 11 apr. 2015, at 10:55, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> On Saturday 11 April 2015 09:41:08 Ard Biesheuvel wrote:
>> Could you perhaps put the rules that build these modules inside a
>> 
>> ifneq ($(armv8-ce-flags),-DARMV8_CE_DISABLED)
>> ...
>> endif
> 
> How about something like this:
> 
> ifeq ($(call as-option,-Wa$(comma)-mfpu=crypto-neon-fp-armv8),)
> $(warning ARMv8 Crypto Extensions need binutils 2.23 or higher)
> else
> ...
> endif
> 
> That would basically be a reimplementation of the missing "as-option-yn"
> macro though, so we could also add that instead and do
> 
> ifeq ($(call as-option-yn,-Wa$(comma)-mfpu=crypto-neon-fp-armv8),y)
> $(warning ARMv8 Crypto Extensions need binutils 2.23 or higher)
> else
> ...
> endif
> 

Yes, that should work. Could we also move the CE objs to ce-obj-$() and put

ifneq ($(ce-obj-y)$(ce-obj-m),)
if <as check>
obj-y += $(ce-obj-y)
obj-m += $(ce-obj-m)
else
$(warning ...)
endif
endif

around it so you only get the warning if you have selected any of these modules?

In any case, I strongly prefer to leave the .S files themselves alone if at all possible

Ard.
