From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Feb 2016 14:36:48 +0000
Subject: [PATCH v2 5/5] arm64: kernel: Don't toggle PAN on systems with UAO
In-Reply-To: <1454684330-892-6-git-send-email-james.morse@arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <1454684330-892-6-git-send-email-james.morse@arm.com>
Message-ID: <20160218143648.GC2538@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 02:58:50PM +0000, James Morse wrote:
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -234,6 +234,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	}
>  
>  	if (permission_fault(esr) && (addr < USER_DS)) {
> +		if (get_thread_info(regs->sp)->addr_limit == KERNEL_DS)
> +			panic("Accessing user space memory with fs=KERNEL_DS");

We could simply use "get_fs() == KERNEL_DS" as we should call
do_page_fault() outside the current context.

-- 
Catalin
