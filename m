From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 24 Jan 2013 13:07:47 -0800
Subject: [PATCH v2 1/3] ARM: stacktrace: harden FP stacktraces against
 invalid stacks
In-Reply-To: <1354230027-2204-2-git-send-email-ccross@android.com>
References: <1354230027-2204-1-git-send-email-ccross@android.com>
 <1354230027-2204-2-git-send-email-ccross@android.com>
Message-ID: <5101A2A3.8000608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2012 3:00 PM, Colin Cross wrote:

> +bool sp_addr_valid(unsigned long sp)
> +{
> +	unsigned long high;
> +	unsigned long offset;
> +	unsigned int pfn;
> +	unsigned int start_pfn;
> +	unsigned int end_pfn;
> +
> +	if (!IS_ALIGNED(sp, 4))
> +		return false;
> +
> +	offset = sp & (THREAD_SIZE - 1);
> +
> +	if (offset > THREAD_START_SP)
> +		return false;
> +
> +	if (offset < sizeof(struct thread_info))
> +		return false;
> +
> +	high = STACK_MAX(sp);
> +
> +	if (!virt_addr_valid(sp) || !virt_addr_valid(high))
> +		return false;
> +
> +	start_pfn = page_to_pfn(virt_to_page(sp));
> +	end_pfn = page_to_pfn(virt_to_page(high));
> +	for (pfn = start_pfn; pfn <= end_pfn; pfn++)
> +		if (!pfn_valid(pfn))
> +			return false;
> +
> +	return true;
> +}

I get crashes on bootup with CONFIG_SPARSEMEM enabled if a stacktrace 
needs to be saved before the sections are setup:

<1>[    0.000000] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
<1>[    0.000000] pgd = c0004000
<1>[    0.000000] [00000000] *pgd=00000000
<0>[    0.000000] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
<4>[    0.000000] Modules linked in:
<4>[    0.000000] CPU: 0    Not tainted 
(3.4.0-ga472ec0-00007-g6479b9e-dirty #10)
<4>[    0.000000] PC is at sp_addr_valid+0xb0/0x1bc
<4>[    0.000000] LR is at unwind_frame+0x4c/0x5b0
...
<1>[    0.000000] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
<1>[    0.000000] pgd = c0004000
<1>[    0.000000] [00000000] *pgd=00000000
<0>[    0.000000] BUG: spinlock lockup on CPU#0, swapper/0
<0>[    0.000000]  lock: die_lock+0x0/0x10, .magic: dead4ead, .owner: 
swapper/0, .owner_cpu: 0
<1>[    0.000000] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
<1>[    0.000000] pgd = c0004000
<1>[    0.000000] [00000000] *pgd=00000000
<0>[    0.000000] BUG: spinlock lockup on CPU#0, swapper/0
<0>[    0.000000]  lock: die_lock+0x0/0x10, .magic: dead4ead, .owner: 
swapper/0, .owner_cpu: 0
[repeat several more times]

In this case, the stacktrace is being saved via a call to kmemleak_free 
in free_bootmem. The sections have not yet been initialized so there is 
a crash in virt_to_page when accessing the section data.

I don't see an easy workaround for this right now unless we want to 
restrict sp_addr_valid until later in bootup.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
