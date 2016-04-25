From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Apr 2016 10:12:39 +0100
Subject: [PATCH] arm64: fix /proc/cpuinfo for elf32
In-Reply-To: <1461555453-60440-1-git-send-email-prime.zeng@huawei.com>
References: <1461555453-60440-1-git-send-email-prime.zeng@huawei.com>
Message-ID: <20160425091239.GB9614@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 11:37:33AM +0800, Zeng Tao wrote:
> For elf32 thread, personality is used for arm32,
> and thread_flag for arm64.
> 
> Here personality is used for arm64, so fix it.
> 
> Signed-off-by: Zeng Tao <prime.zeng@huawei.com>
> ---
>  arch/arm64/kernel/cpuinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 84c8684..f739398 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -126,7 +126,7 @@ static int c_show(struct seq_file *m, void *v)
>  		 * software which does already (at least for 32-bit).
>  		 */
>  		seq_puts(m, "Features\t:");
> -		if (personality(current->personality) == PER_LINUX32) {
> +		if (test_thread_flag(TIF_32BIT)) {
>  #ifdef CONFIG_COMPAT
>  			for (j = 0; compat_hwcap_str[j]; j++)
>  				if (compat_elf_hwcap & (1 << j))

We discussed this some time ago and we decided against it. One reason
was scripts where you may or may not end up with the desired cpuinfo
(e.g. grep being 64-bit invoked by a 32-bit bash). The personality at
least is inherited by child processes.

-- 
Catalin
