From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 10:55:35 +0200
Subject: [PATCH] crypto: arm: workaround for building with old binutils
In-Reply-To: <CAKv+Gu_n0-sMZZjWOmQ5koEfJRX6jqme5WOOP1zrF_zMnB7=nA@mail.gmail.com>
References: <3461827.FYLMCAIQyv@wuerfel>
 <CAKv+Gu_n0-sMZZjWOmQ5koEfJRX6jqme5WOOP1zrF_zMnB7=nA@mail.gmail.com>
Message-ID: <2148670.W34n3asXfA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 April 2015 09:41:08 Ard Biesheuvel wrote:
> Could you perhaps put the rules that build these modules inside a
> 
> ifneq ($(armv8-ce-flags),-DARMV8_CE_DISABLED)
> ...
> endif
> 

How about something like this:

ifeq ($(call as-option,-Wa$(comma)-mfpu=crypto-neon-fp-armv8),)
$(warning ARMv8 Crypto Extensions need binutils 2.23 or higher)
else
...
endif

That would basically be a reimplementation of the missing "as-option-yn"
macro though, so we could also add that instead and do

ifeq ($(call as-option-yn,-Wa$(comma)-mfpu=crypto-neon-fp-armv8),y)
$(warning ARMv8 Crypto Extensions need binutils 2.23 or higher)
else
...
endif

	Arnd
