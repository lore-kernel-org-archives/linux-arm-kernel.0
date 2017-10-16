From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 16 Oct 2017 09:17:23 +0800
Subject: ARM64: Regression with commit e3067861ba66 ("arm64: add basic
 VMAP_STACK support")
In-Reply-To: <da09fd83-f3f0-f800-fea4-988cfa56bac7@arm.com>
References: <20171010142725.GA24797@leoy-linaro>
 <20171010154558.GJ27659@leverpostej>
 <da09fd83-f3f0-f800-fea4-988cfa56bac7@arm.com>
Message-ID: <20171016011723.GB12470@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 05:03:44PM +0100, Robin Murphy wrote:
> On 10/10/17 16:45, Mark Rutland wrote:
> > On Tue, Oct 10, 2017 at 10:27:25PM +0800, Leo Yan wrote:
> >> Hi Mark,
> > 
> > Hi Leo,
> >  
> >> I work mainline kernel on Hikey620 board, I find it's easily to
> >> introduce the panic and report the log as below. So I bisect the kernel
> >> and finally narrow down the commit e3067861ba66 ("arm64: add basic
> >> VMAP_STACK support") which introduce this issue.
> >>
> >> I tried to remove 'select HAVE_ARCH_VMAP_STACK' from
> >> arch/arm64/Kconfig, then I can see the panic issue will dismiss. So
> >> could you check this and have insight for this issue?
> > 
> > Given the stuff in the backtrace, my suspicion is something is trying to
> > perform DMA to/from the stack, getting junk addresses form the attempted
> > virt<->phys conversions.
> > 
> > Could you try enabling both VMAP_STACK and CONFIG_DEBUG_VIRTUAL?
> 
> CONFIG_DMA_API_DEBUG should scream about drivers trying to use stack
> addresses either way, too.

Thanks for suggestions, Mark & Robin.

I enabled these debugging configs but cannot get clue from it; but
occasionally found this issue is quite likely related with CA53 errata,
especialy ERRATA_A53_855873 is the relative one. So I changed to use
ARM-TF mainline code with ERRATA fixing, this issue can be dismissed.

Please ignore this regression reporting.

Thanks,
Leo Yan
