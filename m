From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 27 Apr 2016 13:16:29 +0100
Subject: [PATCH 3/3] ARM: domain: move {set, get}_domain under config guard
In-Reply-To: <20160427104918.GQ19428@n2100.arm.linux.org.uk>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <1461325416-29570-4-git-send-email-vladimir.murzin@arm.com>
 <20160427104918.GQ19428@n2100.arm.linux.org.uk>
Message-ID: <5720AD9D.7020909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/16 11:49, Russell King - ARM Linux wrote:
> On Fri, Apr 22, 2016 at 12:43:36PM +0100, Vladimir Murzin wrote:
>> Domains is not available on !MMU cores, like R/M class. However,
>> currently guarding manages M-class only, for the R-class, in case
>> of fault we get in recursive "undefined instruction" faulting because
>> __show_regs() tries to get domain information.
>>
>> Fix it by extending CONFIG_CPU_USE_DOMAINS on {set,get}_domain
>> functions and providing stubs for the case where Domains is not
>> supported.
> 
> Huge big bloody NAK.
> 
> I think it would be useful if you read the history of the file,
> particularly looking at commit a5e090acbf545c0a3b04080f8a488b17ec41fe02.
> 
> It really amazes me how people propose patches which undo bits of
> previous patches without making comments about it.
> 
> No way is this patch going in, which has the effect of completely
> disabling SW PAN, sorry.
> 

Thanks, Russell!

I've confused myself that support for CPU_SW_DOMAIN_PAN implies
CONFIG_CPU_USE_DOMAINS, but now I see they are in fact different
features/users of those accessors.

So something like below should be sufficient to fix my case, right?

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 4adfb46..d10c385 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -108,7 +108,7 @@ void __show_regs(struct pt_regs *regs)
        else
                domain = *(unsigned int *)(regs + 1);
 #else
-       domain = get_domain();
+       domain = IS_ENABLED(CONFIG_CPU_USE_DOMAINS)? get_domain() : 0;
 #endif
 #endif


Cheers
Vladimir
