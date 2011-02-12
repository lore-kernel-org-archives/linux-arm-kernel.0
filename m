From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 10:36:50 +0000
Subject: [PATCH v4 17/19] ARM: LPAE: mark memory banks with start >
	ULONG_MAX as highmem
In-Reply-To: <1295891761-18366-18-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-18-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110212103650.GE15616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 05:55:59PM +0000, Catalin Marinas wrote:
> @@ -782,7 +782,8 @@ static void __init sanity_check_meminfo(void)
>  
>  #ifdef CONFIG_HIGHMEM
>  		if (__va(bank->start) > vmalloc_min ||
> -		    __va(bank->start) < (void *)PAGE_OFFSET)
> +		    __va(bank->start) < (void *)PAGE_OFFSET ||
> +		    bank->start > ULONG_MAX)

I think this check should be first, so that we don't try to evaluate __va()
on phys addresses > ULONG_MAX, possibly resulting in truncation.
