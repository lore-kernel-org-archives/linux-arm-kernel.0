From: daniel@zonque.org (Daniel Mack)
Date: Thu, 17 Apr 2014 14:34:37 +0200
Subject: [PATCH v4 00/21] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1397736755.16539.15.camel@host5.omatika.ru>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>	
 <1397668411-27162-1-git-send-email-ynvich@gmail.com>	
 <534EC04F.9010408@gmail.com>	
 <610ed273-1e54-4d44-b523-cbe0d042cf48@email.android.com>	
 <534FAF30.1000101@zonque.org> <1397736755.16539.15.camel@host5.omatika.ru>
Message-ID: <534FCA5D.1020606@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 02:12 PM, Sergei Ianovich wrote:
> On Thu, 2014-04-17 at 12:38 +0200, Daniel Mack wrote:

>> 1. We keep the old API around, along with compat wrappers for existing
>> drivers until someone finally finds time to at least test the patches
>> that I can only compile-test myself.
>>
>> 2. For platforms that don't need those exotic drivers for devices that
>> nobody seems to be interested in, use DT and the pxa-mmp-dma driver, and
>> make sure it performs as well as the old implementation.
>>
>> 3. Do not add hacks for DT-compatability of existing drivers to make
>> them work with the old DMA implementation (like your patch #7).
>>
>> 4. For new drivers, don't add any compat code for the old DMA
>> implementation but soley rely on the new DMA framework.
>>
>> Does this sound suitable for you?
> 
> No. I see no value in #3. There are obvious reasons to use DT whenever
> possible.

Of course. But if you do, you should really use the mmp-pdma driver, and
make sure it works. That way, that driver gets more test coverage.
Please, let's *not* introduce new hacks that lead to more users of the
old DMA API instead.

> #3 effectively blocks DT usage for new devices.

No, it doesn't. It just makes sure those new boards use the new dma
implementation, and obtain their DMA runtime information from the common
APIs. After all, the problem here is the lack of users who are willing
to dig into the DMA bits of the drivers they're using. By making it a
requirement to use the new pdma driver, we can possibly change that.

> I have all the
> reasons to believe, that LP-8x4x support would already have be merged,
> if I didn't try to use DT.

That might be, but that's not the point. We want progress here, and that
means we occasionally have to get rid of legacy.

> My plan:
> A. We need to know whether the new DMA implementation performs on par
> with the old one. (I'm starting to check).

Good, thanks!

> if so
> B. We need to thinks whether it's acceptable to kill support for video
> capture.

We can't. As I said, for this particular driver, we can keep the old API
around. We can even make it depend on !CONFIG_DMA_ENGINE, so if anyone
actually wants to use it with DT-enabled boards, we finally have a user
and things can be fixed up. Similar for other drivers we can't test
ourselves.

> In short:
> 
> if (A && B)
>   we drop old DMA
> else
>   we take my patch #7

If A works, there's no need to for patch #7, right? If A doesn't work,
we have to check why and fix it.

Arnd, any oppinion on this?


Thanks,
Daniel
