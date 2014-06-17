From: thunder.leizhen@huawei.com (leizhen)
Date: Tue, 17 Jun 2014 14:32:47 +0800
Subject: [PATCH RFC v2 0/3] Add support for Hisilicon SMMU architecture
In-Reply-To: <20140616163742.GW16758@arm.com>
References: <1402549692-5224-1-git-send-email-thunder.leizhen@huawei.com>
 <20140616163742.GW16758@arm.com>
Message-ID: <539FE10F.2040601@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/6/17 0:37, Will Deacon wrote:
> Hi there,
> 
> On Thu, Jun 12, 2014 at 06:08:09AM +0100, Zhen Lei wrote:
>> Changes in v2:
>>
>> - Split Hisilicon smmu implementation in a separate file, hisi-smmu.c
>> - Refactor arm-smmu.c. Some direct call hardware dependent functions replaced
>>   with hooks. And move common struct and marco definition into arm-smmu.h
>> - Merge the description of Hisilicon private properties into arm,smmu.txt
>>
>> Hisilicon smmu is similar to arm-smmu, some code can be direct reused. For
>> example: map and unmap, device tree configuration, and the software framework.
>> I found that, abstract about 11 hardware dependent functions in arm-smmu.c is
>> enough . Abstract means use hooks to replace the direct call of functions. Now,
>> if need to support Hisilicon SMMU or others arm smmu variants, just selective
>> rewrite these hooks. And I add a dt_cfg_probe hook, to allow each variant parse
>> their hardware special configuration. Finally, flush_pgtable is a special case,
>> hardware independent but maybe referenced. So, total 13 hooks.
> 
> The fundamental question here is whether or not your SMMU implementation is
> intended to follow the ARM SMMU architecture specification. Given the
> changes you've highlighted, it clearly doesn't comply, so then it comes down
> to how much code can actually be re-used between arm-smmu.c and hisi-smmu.c.
> 
> With your current split, I can still see plenty of duplication between the
> two files (e.g. bits in the SCTLR register). I also recognise a fair number
> of lines in hisi-smmu.c that I wrote originally.
> 
> So, is this supposed to be architecturally compliant with the ARM SMMU spec
> or is it something completely independent?
> 
> Will
> 
> .
> 
Yeah, it doesn't comply, and finally will not comply too. So, I said before:
"similar to" and "arm-smmu variant" maybe inappropriate. It looks like a new
smmu hardware implementation.

I also want to reuse your code as much as possible. But in order to keep your
code flow clearly, I try to make as few changes as possible. I think make
differentiate granule too small is not well. Because all of our codes maybe
changed in future, and may any other smmu variants to reuse arm-smmu.c.

Especially, SCTLR register, the hardware dependent feature. I think not
suitable for reuse. A bit field differentiation may need a marco to seperate,
make the code ugly.
