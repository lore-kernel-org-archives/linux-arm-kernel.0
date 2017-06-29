From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Jun 2017 10:59:30 +0100
Subject: [PATCH] arm64: fix endianness annotation in get_kaslr_seed()
In-Reply-To: <20170628145805.24587-1-luc.vanoostenryck@gmail.com>
References: <20170628145805.24587-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170629095929.GB14607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 04:58:05PM +0200, Luc Van Oostenryck wrote:
> In the flattened device tree format, all integer properties are
> in big-endian order.
> Here the property "kaslr-seed" is read from the fdt and then
> correctly converted to native order (via fdt64_to_cpu()) but the
> pointer used for this is not annotated as being for big-endian.
> 
> Fix this by declaring the pointer as __be64 instead of u64.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/arm64/kernel/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index d7e90d97f..b9f0ec99e 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -27,7 +27,7 @@ u16 __initdata memstart_offset_seed;
>  static __init u64 get_kaslr_seed(void *fdt)
>  {
>  	int node, len;
> -	u64 *prop;
> +	__be64 *prop;

I think this should be fdt64_t.

Will
