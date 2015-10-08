From: panand@redhat.com (Pratyush Anand)
Date: Thu, 8 Oct 2015 15:55:20 +0530
Subject: [PATCH v4 1/2] arm64: Introduce IRQ stack
In-Reply-To: <1444231692-32722-2-git-send-email-jungseoklee85@gmail.com>
References: <1444231692-32722-1-git-send-email-jungseoklee85@gmail.com>
 <1444231692-32722-2-git-send-email-jungseoklee85@gmail.com>
Message-ID: <20151008102520.GA10912@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jungseok,

On 07/10/2015:03:28:11 PM, Jungseok Lee wrote:
> Currently, kernel context and interrupts are handled using a single
> kernel stack navigated by sp_el1. This forces a system to use 16KB
> stack, not 8KB one. This restriction makes low memory platforms suffer
> from memory pressure accompanied by performance degradation.

How will it behave on 64K Page system? There, it would take atleast 64K per cpu,
right?

> +int alloc_irq_stack(unsigned int cpu)
> +{
> +	void *stack;
> +
> +	if (per_cpu(irq_stacks, cpu).stack)
> +		return 0;
> +
> +	stack = (void *)__get_free_pages(THREADINFO_GFP, THREAD_SIZE_ORDER);

Above would not compile for 64K pages as THREAD_SIZE_ORDER is only defined for
non 64K. This need to be fixed.

~Pratyush
