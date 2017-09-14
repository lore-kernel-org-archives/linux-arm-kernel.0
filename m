From: ludovic.barre@st.com (Ludovic BARRE)
Date: Thu, 14 Sep 2017 18:55:55 +0200
Subject: [PATCH] mtd: spi-nor: stm32-quadspi: avoid unintialized return
 code
In-Reply-To: <CAMuHMdV6G8WeWgjPcYrMYiSiu=atOSkFZHxwvSsvcwmsv9J+oA@mail.gmail.com>
References: <20170914110709.3591691-1-arnd@arndb.de>
 <CAMuHMdU3AqGkvwDQ+hE2=3PhgCKUh1HvBx8Hkvba6XsLHAuBbg@mail.gmail.com>
 <feb9b51e-7b77-d184-2ed6-f0d33a06bbcf@st.com>
 <CAMuHMdV6G8WeWgjPcYrMYiSiu=atOSkFZHxwvSsvcwmsv9J+oA@mail.gmail.com>
Message-ID: <f372a1cb-e255-b5de-510d-77ca944903b3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/14/2017 05:24 PM, Geert Uytterhoeven wrote:
> Hi Ludovic,
> 
> On Thu, Sep 14, 2017 at 5:13 PM, Ludovic BARRE <ludovic.barre@st.com> wrote:
>> On 09/14/2017 03:38 PM, Geert Uytterhoeven wrote:
>>> On Thu, Sep 14, 2017 at 1:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> If we send zero-length data to stm32_qspi_tx_poll() on older
>>>> compiler versions such as gcc-4.6, we get warned that the
>>>> return code is uninitialized:
>>>>
>>>> drivers/mtd/spi-nor/stm32-quadspi.c:248:2: error: ?ret? may be used
>>>> uninitialized in this function [-Werror=uninitialized]
>>>>
>>>> On newer compiler versions, the return code is always zero
>>>> in this case, as the local variable gets optimized away and
>>>> is assumed to be zero after the loop completes without error.
>>>>
>>>> This changes the function to instead return -EINVAL if it
>>>> ever gets called with a zero length buffer.
>>>>
>>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82203
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> ---
>>>>    drivers/mtd/spi-nor/stm32-quadspi.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c
>>>> b/drivers/mtd/spi-nor/stm32-quadspi.c
>>>> index 86c0931543c5..711cfe7aa4bf 100644
>>>> --- a/drivers/mtd/spi-nor/stm32-quadspi.c
>>>> +++ b/drivers/mtd/spi-nor/stm32-quadspi.c
>>>> @@ -227,7 +227,7 @@ static int stm32_qspi_tx_poll(struct stm32_qspi
>>>> *qspi,
>>>>           void (*tx_fifo)(u8 *, void __iomem *);
>>>>           u32 len = cmd->len, sr;
>>>>           u8 *buf = cmd->buf;
>>>> -       int ret;
>>>> +       int ret = -EINVAL;
>>>>
>>>>           if (cmd->qspimode == CCR_FMODE_INDW)
>>>>                   tx_fifo = stm32_qspi_write_fifo;
>>>
>>>
>>> See also "[PATCH] mtd: spi-nor: stm32-quadspi: Fix uninitialized error
>>> return code"
>>> (https://patchwork.kernel.org/patch/9842173/)
>>
>> hi Arnd, Geert
>>
>> sorry, I was forgot this thread while my holidays
>>
>> Geert: what do you mean like "similar bugs in the future" in "If you
>> initialized ret at the beginning, you lose the ability to catch newly
>> introduced similar bugs in the future."
> 
> If you pre-initialize ret at the top, you loose the ability of the compiler
> to detect at compile-time if ret is never written to later. It will just return
> -EINVAL at runtime.
> 
> With my version, if the code is modified later and another "return ret" is
> added, the compiler will detect if there's a code path that forgets
> to assign a value to ret.
Ok, it's clear for me.
I favor geert's solution.
Arnd what do you think ?

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 
