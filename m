From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 5 Dec 2017 12:27:06 +0100
Subject: [PATCH] ASoC: atmel-classd: select correct Kconfig symbol
In-Reply-To: <CAK8P3a29G4T1DbkjwhEqa6cSVQL77z0jW0znMX47tqd5vM-P9Q@mail.gmail.com>
References: <20171205101000.968887-1-arnd@arndb.de>
 <20171205105750.GI21780@piout.net>
 <CAK8P3a29G4T1DbkjwhEqa6cSVQL77z0jW0znMX47tqd5vM-P9Q@mail.gmail.com>
Message-ID: <8268ff41-576b-4438-ad10-ec90f66b6e9f@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2017 at 12:13, Arnd Bergmann wrote:
> On Tue, Dec 5, 2017 at 11:57 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> On 05/12/2017 at 11:09:38 +0100, Arnd Bergmann wrote:
>>> Commit 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
>>> changed the way that the dependencies are handled, but then the
>>> Class D amplifier support got merged, which used the old method.
>>>
>>> This seems to have triggered a very rare randconfig condition for me
>>> now, leading to a link error:
>>>
>>> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
>>> atmel_ssc_dai.c:(.text+0x79c): undefined reference to `atmel_pcm_dma_platform_register'
>>> atmel_ssc_dai.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_register'
>>> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_put_audio':
>>> atmel_ssc_dai.c:(.text+0xf24): undefined reference to `atmel_pcm_dma_platform_unregister'
>>> atmel_ssc_dai.c:(.text+0xf24): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_unregister'
>>>
>>> Changing it to select SND_ATMEL_SOC_SSC_DMA as intended rather than
>>> SND_ATMEL_SOC_DMA directly makes it work again.
>>>
>>> Fixes: e0a25b6d1862 ("ASoC: atmel-classd: add the Audio Class D Amplifier")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Unfortunately, my testing just found a new problem with this patch
> applied, I had
> not run enough randconfig tests on top of it:
> 
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> atmel_ssc_dai.c:(.text+0x73c): undefined reference to `ssc_request'
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_put_audio':
> atmel_ssc_dai.c:(.text+0x7be): undefined reference to `ssc_free'
> 
> This is for a configuration with SND_ATMEL_SOC_CLASSD=y
> and CONFIG_ATMEL_SSC=n. Could you tell me whether that is a
> sensible configuration that should work, or whether we need a dependency
> on ATMEL_SSC in SND_ATMEL_SOC_CLASSD? I can't really tell
> from the source code, but you probably know the answer.

Actually, they are two different interfaces which can be enabled at the
same time or not and CLASSD doesn't use the SSC.
So no dependency between them.

It might be an issue with SND_ATMEL_SOC_DMA not selecting the proper code...

Regards,
-- 
Nicolas Ferre
