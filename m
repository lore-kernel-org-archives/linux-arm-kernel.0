From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Mar 2017 13:50:39 +0000
Subject: [PATCH v3] irqchip/gicv3-its: Avoid memory over allocation for
 ITEs
In-Reply-To: <1488896720-6223-1-git-send-email-shankerd@codeaurora.org>
References: <1488896720-6223-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <b74f8fbb-0d9a-b1e2-83d2-ba9c1a858222@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/17 14:25, Shanker Donthineni wrote:
> We are always allocating extra 255Bytes of memory to handle ITE
> physical address alignment requirement. The kmalloc() satisfies
> the ITE alignment since the ITS driver is requesting a minimum
> size of ITS_ITT_ALIGN bytes.
> 
> Let's try to allocate the exact amount of memory that is required
> for ITEs to avoid wastage.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit.
> v3: changed from IITE to ITE.
> 
>  drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 86bd428..5aeca78 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1329,8 +1329,13 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	 */
>  	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
>  	sz = nr_ites * its->ite_size;
> -	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
> +	sz = max(sz, ITS_ITT_ALIGN);
>  	itt = kzalloc(sz, GFP_KERNEL);
> +	if (itt && !IS_ALIGNED(virt_to_phys(itt), ITS_ITT_ALIGN)) {
> +		kfree(itt);
> +		itt = kzalloc(sz + ITS_ITT_ALIGN - 1, GFP_KERNEL);
> +	}
> +

Is this really worth the complexity? Are you aware of a system where the
accumulation of overallocation actually shows up as being an issue?

If you want to be absolutely exact in your allocation, then I'd suggest
doing it all the time, and have a proper dedicated allocator that always
do the right thing, without a wasteful fallback like you still have here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
