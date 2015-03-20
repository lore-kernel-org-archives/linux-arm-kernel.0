From: y.gribov@samsung.com (Yury Gribov)
Date: Fri, 20 Mar 2015 14:31:15 +0300
Subject: [PATCH] arm: fix integer overflow in ELF_ET_DYN_BASE
In-Reply-To: <1426849972-19606-1-git-send-email-a.ryabinin@samsung.com>
References: <1426849972-19606-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <550C0503.3000207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2015 02:12 PM, Andrey Ryabinin wrote:
> Usually ELF_ET_DYN_BASE is 2/3 of TASK_SIZE. With 3G/1G user/kernel
> split this is not so, because 2*TASK_SIZE overflows 32 bits,
> so the actual value of ELF_ET_DYN_BASE is:
> 	(2 * TASK_SIZE / 3) = 0x2a000000

AFAIK on most platforms (e.g. Intel) that's (TASK_SIZE / 3 * 2) so ARM 
is kind of special here.

>
> When ASLR is disabled PIE binaries will load at ELF_ET_DYN_BASE address.
> On 32bit platforms AddressSanitzer uses addresses [0x20000000 - 0x40000000]
> for shadow memory [1]. So ASan doesn't work for PIE binaries when ASLR disabled
> as it fails to map shadow memory.
> Also after Kees's 'split ET_DYN ASLR from mmap ASLR' patchset PIE binaries
> has a high chance of loading somewhere in between [0x2a000000 - 0x40000000]
> even if ASLR enabled. This makes ASan with PIE absolutely incompatible.
>
> Fix overflow by dividing TASK_SIZE prior to multiplying.
> After this patch ELF_ET_DYN_BASE equals to (for CONFIG_VMSPLIT_3G=y):
> 	(TASK_SIZE / 3 * 2) = 0x7f555554
>
> [1] https://code.google.com/p/address-sanitizer/wiki/AddressSanitizerAlgorithm#Mapping

Perhaps we should fix other platforms as well?

-Y
