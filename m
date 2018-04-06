From: labbott@redhat.com (Laura Abbott)
Date: Fri, 6 Apr 2018 09:17:05 -0700
Subject: [PATCH 1/1] arm64: To remove initrd reserved area entry from
 memblock
In-Reply-To: <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
References: <CGME20180406045340epcas1p1ae6416dc25823212303c9109d125c018@epcas1p1.samsung.com>
 <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
Message-ID: <ff125919-66f7-6658-e9b1-817188c1bdd9@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2018 09:53 PM, CHANDAN VN wrote:
> INITRD reserved area entry is not removed from memblock
> even though initrd reserved area is freed. After freeing
> the memory it is released from memblock. The same can be
> checked from /sys/kernel/debug/memblock/reserved.
> 
> The patch makes sure that the initrd entry is removed from
> memblock when keepinitrd is not enabled.
> 

Does this have an impact on anything besides accounting
in memblock?

> Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
> ---
>   arch/arm64/mm/init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9f3c47a..1b18b47 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -646,8 +646,10 @@ void free_initmem(void)
>   
>   void __init free_initrd_mem(unsigned long start, unsigned long end)
>   {
> -	if (!keep_initrd)
> +	if (!keep_initrd) {
>   		free_reserved_area((void *)start, (void *)end, 0, "initrd");
> +		memblock_free(__virt_to_phys(start), end - start);
> +	}
>   }
>   
>   static int __init keepinitrd_setup(char *__unused)
> 
