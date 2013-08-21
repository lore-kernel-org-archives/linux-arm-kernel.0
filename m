From: andre.przywara@linaro.org (Andre Przywara)
Date: Wed, 21 Aug 2013 23:22:07 +0200
Subject: [PATCH 1/2] DMA: fix AMBA PL08x driver issue with 64bit DMA
 address type
In-Reply-To: <CACRpkdZg6kQSY2bm6LWpNCDhd90-7G2GSFQv7Jho2+Xq-EQCkw@mail.gmail.com>
References: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
 <1376484729-11826-2-git-send-email-andre.przywara@linaro.org>
 <CACRpkdZg6kQSY2bm6LWpNCDhd90-7G2GSFQv7Jho2+Xq-EQCkw@mail.gmail.com>
Message-ID: <52152F7F.9070708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2013 11:01 PM, Linus Walleij wrote:
> On Wed, Aug 14, 2013 at 2:52 PM, Andre Przywara
> <andre.przywara@linaro.org> wrote:
>
>> In Rob's recent pull request the patch
>>          ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
>> promotes dma_addr_t to 64bit, which breaks compilation of the
>> AMBA PL08x DMA driver.
>> GCC has no function for the 64bit/8bit modulo operation.
>> Looking more closely the divisor can only be 1, 2 or 4, so the full
>> featured '%' modulo operation is overkill and can be replaced by
>> simple bit masking.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>
> Can you give some context? Which platform have you tested
> this on after the change, or is this only compile-tested?

Only compile tested (sorry, forgot to mention that).
Actually I don't have this hardware anywhere, I just happened to had 
this in my config - probably just by accident as a leftover from some 
experiments.
So if you have access to any of those platforms, please give it a test.

> Of the current defconfigs selecting this driver, none is 64bit,

But it would be selected by allyesconfig or randconfig, right? And with 
more and more platforms moving into single zImage, we will spot more of 
those, as one "64-bit platform" will promote the types for every other.

> so makes me a bit curious if there is really some PL08x
> on the Highbank or similar?

Sorry, no hidden DMA controller on Highbank ;-)

Regards,
Andre.
