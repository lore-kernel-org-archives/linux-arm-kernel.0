From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 22 Mar 2010 07:58:49 -0400
Subject: [PATCH 1/6] ASoC: split pxa ssp for reusing code
In-Reply-To: <20100320170049.GB1549@opensource.wolfsonmicro.com>
References: <771cded01003190851w2bb94ca2w1faf2a5fffa11794@mail.gmail.com>
	<20100320170049.GB1549@opensource.wolfsonmicro.com>
Message-ID: <771cded01003220458i5a2c6860i278dd8edf72d1150@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 1:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Mar 19, 2010 at 11:51:55AM -0400, Haojian Zhuang wrote:
>> Subject: [PATCH] ASoC: split pxa ssp for reusing code
>
> Again, please remember to CC ALSA patches to the ALSA list. ?You should
> also remember to CC Liam, my ASoC comaintainer.
>
I'm sorry to forget it.

>> hw_params() isn't put in common ssp files since cpu_is_pxa3xx() is used. The
>> cpu_is_pxa3xx() macro is only valid in ARCH_PXA and it's used to distinguish
>> pxa2xx and pxa3xx. This macro is meaning less in other architectures. So keep
>> this function in device specific driver.
>
> Looking at the code it seems (like I mentioned before) it'd be much
> better to factor this out so that the common code is in a library
> function which both PXA and MMP variants can use it, with the PXA3xx
> specific stuff calling the library function and overriding its behaviour
> (eg, by overwriting the registers) where required.
>
> Like I keep saying the SSP port configuration is really rather fragile
> (in part due to the documentation issues) so forking this code seems
> like it's going to be painful in the long run.
>
I don't want to merge hw_params() between pxa2xx and pxa168 together.
Because I won't change pxa2xx function code. In my zylonite platform,
sound can't work with 2.6.34-rc1 kernel. If I change pxa2xx
functionality code, I can not verify it. I need to check why sound
can't work on zylonite first. I'm planning to follow this after this
change set.

> Some other stuff below...
>
>> - * TODO:
>> - * ?o Test network mode for > 16bit sample size
>
> Have you actually done this testing?
>
>> -static void ssp_enable(struct ssp_device *ssp)
>> +void ssp_enable(struct ssp_device *ssp)
>> ?{
>> ? ? ? uint32_t sscr0;
>>
>
> If this is being marked non-static presumably it should be exported too?
> Similarly for most of the other functions. ?Might be worth considering
> the namespacing too and shoving some pxa_ or similar prefixes on there
> if the function is going global, right now there's a mix of ssp_ and
> pxa_ssp_ being exported.
>
ok. I'll do the change.

>> +/*
>> + * pxa2xx-ssp.c ?-- ?ALSA Soc Audio Layer
>> + *
>
> I'm not a big fan of the naming here since this also covers PXA3xx
> devices. ?Is there some general term for the non-MMP processors which
> could be used - I'm not aware of one but I might've missed something?
>
pxa2xx is enough. Actually there's no general term for the non-MMP
processors. The silicon behavior on SSP is defferent one by one. In
PXA910, we will use SQU as DMA. In PXA168, we will use another clock
system. In PXA968, we will use ABU in SSP. The difference between
pxa2xx and pxa3xx is so small. PXA168 and PXA910 is MMP processors.
PXA968 is non-MMP processors.

>> +enum {
>> + ? ? PXA2XX_DAI_SSP1,
>> + ? ? PXA2XX_DAI_SSP2,
>> + ? ? PXA2XX_DAI_SSP3,
>> + ? ? PXA2XX_DAI_SSP4,
>> + ? ? PXA2XX_DAI_SSP_MAX,
>> +};
>
> TBH I'd be much happier with #defines here - the use of an enum is
> rather random given that none of the other defines use one and since the
> particular values on this one really matter (as a result of being array
> indexes) something that sets the values explicitly seems better.
>
ok. I'll change.
