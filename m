From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Sep 2017 23:38:19 +0200
Subject: [PATCH] mtd: spi-nor: stm32-quadspi: avoid unintialized return
 code
In-Reply-To: <f372a1cb-e255-b5de-510d-77ca944903b3@st.com>
References: <20170914110709.3591691-1-arnd@arndb.de>
 <CAMuHMdU3AqGkvwDQ+hE2=3PhgCKUh1HvBx8Hkvba6XsLHAuBbg@mail.gmail.com>
 <feb9b51e-7b77-d184-2ed6-f0d33a06bbcf@st.com>
 <CAMuHMdV6G8WeWgjPcYrMYiSiu=atOSkFZHxwvSsvcwmsv9J+oA@mail.gmail.com>
 <f372a1cb-e255-b5de-510d-77ca944903b3@st.com>
Message-ID: <CAK8P3a3WoUdxpaXAiMsC3MTWSyxyUK793R+igaQjTxdO7t+a6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 6:55 PM, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
>
> On 09/14/2017 05:24 PM, Geert Uytterhoeven wrote:
>>
>> Hi Ludovic,
>>
>> On Thu, Sep 14, 2017 at 5:13 PM, Ludovic BARRE <ludovic.barre@st.com>
>> wrote:
>>>
>>> On 09/14/2017 03:38 PM, Geert Uytterhoeven wrote:
>>>
>>> hi Arnd, Geert
>>>
>>> sorry, I was forgot this thread while my holidays
>>>
>>> Geert: what do you mean like "similar bugs in the future" in "If you
>>> initialized ret at the beginning, you lose the ability to catch newly
>>> introduced similar bugs in the future."
>>
>>
>> If you pre-initialize ret at the top, you loose the ability of the
>> compiler
>> to detect at compile-time if ret is never written to later. It will just
>> return
>> -EINVAL at runtime.
>>
>> With my version, if the code is modified later and another "return ret" is
>> added, the compiler will detect if there's a code path that forgets
>> to assign a value to ret.
>
> Ok, it's clear for me.
> I favor geert's solution.
> Arnd what do you think ?

I usually follow the same rule that Geert explained (and quote
https://rusty.ozlabs.org/?p=232 when I do so). In this case, there
did not seem to be much value as the variable is not used
afterwards, and I kept the 'single return statement' guideline.

In the end, either version seems totally fine to me here, so
please use Geert's if you prefer that.

        Arnd
