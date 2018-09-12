From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 12 Sep 2018 12:11:15 +0100
Subject: [PATCH v5 05/27] arm64: Use daifflag_restore after bp_hardening
In-Reply-To: <641119b9-3466-817d-3d6b-dd710c646b49@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-6-git-send-email-julien.thierry@arm.com>
 <641119b9-3466-817d-3d6b-dd710c646b49@arm.com>
Message-ID: <8f200315-1db9-1905-71ae-cb4269450b7c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 12/09/18 11:32, James Morse wrote:
> Hi Julien,
> 
> On 28/08/18 16:51, Julien Thierry wrote:
>> For EL0 entries requiring bp_hardening, daif status is kept at
>> DAIF_PROCCTX_NOIRQ until after hardening has been done. Then interrupts
>> are enabled through local_irq_enable().
>>
>> Before using local_irq_* functions, daifflags should be properly restored
>> to a state where IRQs are enabled.
> 
>> Enable IRQs by restoring DAIF_PROCCTX state after bp hardening.
> 
> Is this just for symmetry, or are you going on to add something to the daifflags
> state that local_irq_* functions won't change? (if so, could you allude to that
> in the commit message)
> 

What happens is that once we use ICC_PMR_EL1, local_irq_enable will not 
touch PSR.I. And we are coming back from an entry where PSR.I was kept 
to 1 so local_irq_enable was not actually enabling the interrupts. On 
the otherhand, restore will affect both.

Another option is to have the asm macro "enable_da_f" also switch to PMR 
usage (i.e. "just keep normal interrupts disabled"). Overall it would 
probably be easier to reason with, but I'm just unsure whether it is 
acceptable to receive a Pseudo NMI before having applied the bp_hardening.

If it is possible, I'm happy to solve this with enable_da_f.

Thanks,

> 
> Either way,
> 
> Acked-by: James Morse <james.morse@arm.com>
> 

-- 
Julien Thierry
