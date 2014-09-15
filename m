From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Sep 2014 19:33:34 +0100
Subject: [PATCH] arm64:free_initrd_mem should also free the memblock
In-Reply-To: <35FD53F367049845BC99AC72306C23D103CDBFBFB029@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB029@CNBJMBX05.corpusers.net>
Message-ID: <20140915183334.GA30737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 11:17:18AM +0100, Wang, Yalin wrote:
> this patch fix the memblock statics for memblock
> in file /sys/kernel/debug/memblock/reserved
> if we don't call memblock_free the initrd will still
> be marked as reserved, even they are freed.
> 
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> ---
>  arch/arm64/mm/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 5472c24..34605c8 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -334,8 +334,10 @@ static int keep_initrd;
>  
>  void free_initrd_mem(unsigned long start, unsigned long end)
>  {
> -	if (!keep_initrd)
> +	if (!keep_initrd) {
>  		free_reserved_area((void *)start, (void *)end, 0, "initrd");
> +		memblock_free(__pa(start), end - start);
> +	}

I don't think it makes any technical difference, but doing the memblock_free
before the free_reserved_area makes more sense to me.

Will
