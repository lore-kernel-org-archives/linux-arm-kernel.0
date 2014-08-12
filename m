From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 12 Aug 2014 11:36:18 +0200
Subject: [PATCH v9 2/4] arm: ARMv7  dirty page logging inital mem region
 write protect (w/no huge PUD support)
In-Reply-To: <53E96F8E.3070905@samsung.com>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-3-git-send-email-m.smarduch@samsung.com>
 <20140811191257.GG10550@cbox> <53E96F8E.3070905@samsung.com>
Message-ID: <20140812093618.GM10550@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 06:36:14PM -0700, Mario Smarduch wrote:
> On 08/11/2014 12:12 PM, Christoffer Dall wrote:

[...]

> >> +/**
> >> + * stage2_wp_range() - write protect stage2 memory region range
> >> + * @kvm:	The KVM pointer
> >> + * @start:	Start address of range
> >> + * &end:	End address of range
> >> + */
> >> +static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
> >> +{
> >> +	pgd_t *pgd;
> >> +	phys_addr_t next;
> >> +
> >> +	pgd = kvm->arch.pgd + pgd_index(addr);
> >> +	do {
> >> +		/*
> >> +		 * Release kvm_mmu_lock periodically if the memory region is
> >> +		 * large features like detect hung task, lock detector or lock
> >                    large.  Otherwise, we may see panics due to..
> >> +		 * dep  may panic. In addition holding the lock this long will
> >     extra white space ^^           Additionally, holding the lock for a
> >     long timer will
> >> +		 * also starve other vCPUs. Applies to huge VM memory regions.
> >                                             ^^^ I don't understand this
> > 					    last remark.
> Sorry overlooked this.
> 
> While testing - VM regions that were small (~1GB) holding the mmu_lock
> caused not problems, but when I was running memory regions around 2GB large
> some kernel lockup detection/lock contention options (some selected by default) 
> caused deadlock warnings/panics in host kernel.
> 
> This was in one my previous review comments sometime ago, I can go back
> and find the options.
> 

Just drop the last part of the comment, so the whole thing reads:

/*
 * Release kvm_mmu_lock periodically if the memory region is
 * large. Otherwise, we may see kernel panics from debugging features
 * such as "detect hung task", "lock detector" or "lock dep checks".
 * Additionally, holding the lock too long will also starve other vCPUs.
 */

And check the actual names of those debugging features or use the
CONFIG_<WHATEVER> names and say "we may see kernel panics with CONFIG_X,
CONFIG_Y, and CONFIG_Z.

Makes sense?

-Christoffer
