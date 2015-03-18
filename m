From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Mar 2015 10:20:29 +0000
Subject: [PATCH 2/2] ARM: psci: move psci firmware calls out of line
In-Reply-To: <1424866236-12482-2-git-send-email-will.deacon@arm.com>
References: <1424866236-12482-1-git-send-email-will.deacon@arm.com>
 <1424866236-12482-2-git-send-email-will.deacon@arm.com>
Message-ID: <20150318102029.GC8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 12:10:36PM +0000, Will Deacon wrote:
> -/*
> - * The following two functions are invoked via the invoke_psci_fn pointer
> - * and will not be inlined, allowing us to piggyback on the AAPCS.
> - */
> -static noinline int __invoke_psci_fn_hvc(u32 function_id, u32 arg0, u32 arg1,
> -					 u32 arg2)
> -{
> -	asm volatile(
> -			__asmeq("%0", "r0")
> -			__asmeq("%1", "r1")
> -			__asmeq("%2", "r2")
> -			__asmeq("%3", "r3")
> -			__HVC(0)
> -		: "+r" (function_id)
> -		: "r" (arg0), "r" (arg1), "r" (arg2));
> -
> -	return function_id;
> -}

Why not convert these to:

static int __naked __invoke_psci_fn_hvc(u32 function_id, u32 arg0, u32 arg1,
					u32 arg2)
{
	asm(
		__HVC(0)
		"bx lr");
}

?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
