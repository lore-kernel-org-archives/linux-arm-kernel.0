From: olof@lixom.net (Olof Johansson)
Date: Sun, 24 Aug 2014 11:27:47 -0700
Subject: [PATCH v16 9/9] of: fdt: fix memory address be truncated
In-Reply-To: <1407121088-4151-10-git-send-email-haojian.zhuang@linaro.org>
References: <1407121088-4151-1-git-send-email-haojian.zhuang@linaro.org>
 <1407121088-4151-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140824182747.GC11563@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 10:58:08AM +0800, Haojian Zhuang wrote:
> early_init_dt_add_memory_arch() accepts base & size parameters as u64
> type. memblock_add() accepts base & size parameters as phys_addr_t type.
> But phys_addr_t isn't equal to u64. In 32-bit system, phys_addr_t is
> 32-bit long. If 64-bit memory address is specified in DTS file, it'll be
> truncated into 32-bit address.
> 
> So create two values to store base & size first as phys_addr_t type.
> Then compare them with u64 base & u64 size. If they don't match, discard
> them.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/of/fdt.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index c4cddf0..10d5382 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -878,6 +878,8 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
>  	const u64 phys_offset = __pa(PAGE_OFFSET);
> +	phys_addr_t mbase, msize;
> +
>  	base &= PAGE_MASK;
>  	size &= PAGE_MASK;
>  	if (base + size < phys_offset) {
> @@ -885,6 +887,14 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  			   base, base + size);
>  		return;
>  	}
> +	/* phys_addr_t may not be equal to u64 */
> +	mbase = base;
> +	msize = size;
> +	if ((mbase != base) || (msize != size)) {
> +		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
> +			   base, base + size);
> +		return;

Actually, you can do better than this -- you can still use the part that fits in 32 bits even
if not all of it does.


-Olof
