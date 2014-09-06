From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 06 Sep 2014 16:12:57 +0200
Subject: [PATCH] arm64: LLVMLinux: Add missing abort() for AARCH64
In-Reply-To: <1409959302-13976-1-git-send-email-behanw@converseincode.com>
References: <1409959302-13976-1-git-send-email-behanw@converseincode.com>
Message-ID: <53558632.2D4ZDSZcaf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 16:21:42 behanw at converseincode.com wrote:
> From: Mark Charlebois <charlebm@gmail.com>
> 
> Add missing abort for arch aarch64.
> 
> This patch makes the aarch64 kernel able to compile with gcc or clang.
> 
> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
> Signed-off-by: Behan Webster <behanw@converseincode.com>

You don't describe why this is needed. When does clang emit an abort()
call? Is that the expected behavior when not linking against a full
C library?

>  arch/arm64/kernel/traps.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 02cd3f0..123cd6e 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -349,6 +349,15 @@ void __pgd_error(const char *file, int line, unsigned long val)
>         pr_crit("%s:%d: bad pgd %016lx.\n", file, line, val);
>  }
>  
> +void abort(void)
> +{
> +       BUG();
> +
> +       /* if that doesn't kill us, halt */
> +       panic("Oops failed to kill thread");
> +}
> +EXPORT_SYMBOL(abort);

I don't see the point in doing both BUG() and panic(). Doesn't panic()
already print all the information you want in this case?

	Arnd
