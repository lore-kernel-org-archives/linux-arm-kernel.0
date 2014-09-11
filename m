From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 11 Sep 2014 09:22:29 +0800
Subject: [Xen-devel] [PATCH v1 04/21] x86/xen/MSI: Eliminate
 arch_msix_mask_irq() and arch_msi_mask_irq()
In-Reply-To: <541045BE.9050804@citrix.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-5-git-send-email-wangyijing@huawei.com>
 <541045BE.9050804@citrix.com>
Message-ID: <5410F955.80609@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/9/10 20:36, David Vrabel wrote:
> On 05/09/14 11:09, Yijing Wang wrote:
>> Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
>> and arch_msi_mask_irq() to fix a bug found when running xen in x86.
>> Introduced these two funcntions make MSI code complex. And mask/unmask
>> is the irq actions related to interrupt controller, should not use
>> weak arch functions to override mask/unmask interfaces. This patch
>> reverted commit 0e4ccb150 and export struct irq_chip msi_chip, modify
>> msi_chip->irq_mask/irq_unmask() in xen init functions to fix this
>> bug for simplicity. Also this is preparation for using struct
>> msi_chip instead of weak arch MSI functions in all platforms.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> 
> But I wonder if it would be better the Xen subsystem to provide its own
> struct irq_chip instead of adjusting the fields in the generic x86 one.

Thanks! Currently, Xen and the bare x86 system only have the different irq_chip->irq_mask/irq_unmask.
So I chose to override the two ops of bare x86 irq_chip in xen. Konrad Rzeszutek Wilk has been tested it
ok in his platform, so I think we could use its own irq_chip for xen later if the difference become large.

Thanks!
Yijing.

> 
> David
> 
> .
> 


-- 
Thanks!
Yijing
