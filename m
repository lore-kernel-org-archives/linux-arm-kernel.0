From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Oct 2017 17:13:25 +0200
Subject: [PATCH] dmaengine: stm32-mdma: avoid 64-bit division
In-Reply-To: <CA+M3ks4cKxYy15-6ewbMaJOLF0e2NdhwrZUCq-U2s4Y8n212fw@mail.gmail.com>
References: <20171011140144.3746128-1-arnd@arndb.de>
 <CA+M3ks74eOSOEwadsjjMcQme_6ivzmYGRdc9jvw4RHYa6dxRTA@mail.gmail.com>
 <CAK8P3a2RsCXq7L6w5K+KmhP1Q2b1=SjnG2Xws2w232vmyj=yEA@mail.gmail.com>
 <CA+M3ks4cKxYy15-6ewbMaJOLF0e2NdhwrZUCq-U2s4Y8n212fw@mail.gmail.com>
Message-ID: <CAK8P3a3j5Awh9V6+PHZf-79TM_7wdQ0GkZZv75a3ztewrw6CmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 4:46 PM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> 2017-10-11 16:39 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> On Wed, Oct 11, 2017 at 4:27 PM, Benjamin Gaignard
>> <benjamin.gaignard@linaro.org> wrote:
>>> 2017-10-11 16:01 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>>>
>>>> @@ -398,6 +400,9 @@ static enum dma_slave_buswidth stm32_mdma_get_max_width(u32 buf_len, u32 tlen)
>>>>                         break;
>>>>         }
>>>>
>>>> +       if (addr % max_width)
>>>> +               max_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>>>> +
>>>
>>> I'm only half-convince by the implicite 32 bits cast done into
>>> function prototype.
>>> If we keep using dma_addr_t and use do_div() instead of %
>>> does compiler can still optimize the code ?
>>>
>>
>> I wouldn't want to add a do_div() here, since it's guaranteed
>> not to be needed. Would you prefer an explicit cast here
>> and leave the argument as dma_addr_t?
>>
>> We could also use a bit mask here like
>>
>>   if (addr & (max_width-1))
>
> That sound better for me since it doesn't limit the code to 32 bits architecture

FWIW, I used the u32 type here because that's the limit of the
dma driver, the dma_addr_t gets converted to that anyway
later.

>>
>> or we could combined it with the check above:
>>
>>                 if ((((buf_len | addr) & (max_width - 1)) == 0) &&
>>                    (tlen >= max_width))
>
> No it is more simple to read with two checks

I should have mentioned that this variant would also change
behavior: the current code falls back to byte access when
the address alignment is less than the length alignment.
The change I suggested here would change that to use
the maximum possible address width that fits the alignment
of either size or address.

I don't know what behavior we actually want though, or
if that change would be correct.

      Arnd
