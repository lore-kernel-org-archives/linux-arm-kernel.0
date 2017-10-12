From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Oct 2017 11:51:37 +0100
Subject: [PATCH] arm:fix negation of -2147483648 warning with UBSASN
In-Reply-To: <1507804858-10205-1-git-send-email-manjeet.p@samsung.com>
References: <CGME20171012104401epcas5p3c707a85cc3a6b35bf34a710f435736cd@epcas5p3.samsung.com>
 <1507804858-10205-1-git-send-email-manjeet.p@samsung.com>
Message-ID: <20171012105137.GE20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 04:10:58PM +0530, Manjeet Pawar wrote:
> From: Rohit Thapliyal <r.thapliyal@samsung.com>
> 
> Using gcc-6 and UBSAN enabled, we get the following warning:
> 
> =========================================================
> [1-1.4604] UBSAN: Undefined behaviour in ./arch/arm/include/asm/bitops.h:296:17
> [1-1.4604] negation of -2147483648 cannot be represented in type 'int':
> [1-1.4605] CPU: 1 PID: 189 Comm: sync Tainted: GO 4.1.10 #1 PPID: 166 PComm: init
> [1-1.4605] SCHED_NORMAL (p:120, static_p:120, normal_p:120, rt_p:0)
> [1-1.4605] Backtrace:
> [1-1.4605] [<c0016050>] (dump_backtrace) from [<c0016fac>] (show_stack+0x18/0x20)
> [1-1.4605]  r7:c098196c r6:00000000 r5:60040093 r4:c0a177f4
> [1-1.4605] [<c0016f94>] (show_stack) from [<c06f36d8>] (dump_stack+0xf4/0x148)
> [1-1.4605] [<c06f35e4>] (dump_stack) from [<c03b8b94>] (ubsan_epilogue+0x14/0x54)
> [1-1.4605]  r10:00000101 r9:00000120 r8:00000100 r7:00001000 r6:80000000 r5:c0a18b00
> [1-1.4605]  r4:d8099c00
> [1-1.4605] [<c03b8b80>] (ubsan_epilogue) from [<c03b941c>] (__ubsan_handle_negate_overflow+0x88/0x90)
> [1-1.4605]  r5:c0a18b00 r4:c098148c
> [1-1.4605] [<c03b9394>] (__ubsan_handle_negate_overflow) from [<c03823c4>] (radix_tree_next_chunk+0x380/0x470)
> [1-1.4605]  r6:e1b88d20 r5:00000006 r4:00000020
> [1-1.4606] [<c0382044>] (radix_tree_next_chunk) from [<c0158f10>] (find_get_pages_tag+0x158/0x1e8)
> [1-1.4606]  r10:00000004 r9:0000000e r8:00000101 r7:ffffffff r6:00000000 r5:e1b91cb4
> [1-1.4606]  r4:00000001
> [1-1.4606] [<c0158db8>] (find_get_pages_tag) from [<c016e160>] (pagevec_lookup_tag+0x30/0x3c)
> [1-1.4606]  r10:0000000e r9:27f662e4 r8:00000000 r7:ffffffff r6:e50da320 r5:d8099d60
> =========================================================
> 
> In order to remove these warnings, it seems harmless to modify
> the signed ints with unsigned long as a fix of negation of -2147483648 in signed int.
> 
> Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
> ---
>  arch/arm/include/asm/bitops.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index 5638099..95028db 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -222,7 +222,7 @@ extern int _find_next_bit_be(const unsigned long *p, int size, int offset);
>  
>  #else
>  
> -static inline int constant_fls(int x)
> +static inline int constant_fls(unsigned long x)
>  {
>  	int r = 32;
>  
> @@ -270,7 +270,7 @@ static inline unsigned int __clz(unsigned int x)
>   * fls() returns zero if the input is zero, otherwise returns the bit
>   * position of the last set bit, where the LSB is 1 and MSB is 32.
>   */
> -static inline int fls(int x)
> +static inline int fls(unsigned long x)
>  {
>  	if (__builtin_constant_p(x))
>  	       return constant_fls(x);
> @@ -291,7 +291,7 @@ static inline unsigned long __fls(unsigned long x)
>   * ffs() returns zero if the input was zero, otherwise returns the bit
>   * position of the first set bit, where the LSB is 1 and MSB is 32.
>   */
> -static inline int ffs(int x)
> +static inline int ffs(unsigned long x)
>  {
>  	return fls(x & -x);
>  }

Every other architecture, including asm-generic, uses 'int' for fls()
and ffs().  If we're going to change the prototype, it needs to be
changed everwhere, not just one implementation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
