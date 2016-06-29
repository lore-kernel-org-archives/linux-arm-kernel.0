From: briannorris@chromium.org (Brian Norris)
Date: Wed, 29 Jun 2016 12:51:37 -0700
Subject: [PATCH 2/2] arm64: Always provide compat /proc/cpuinfo for
 32-bit tasks
In-Reply-To: <1464706504-25224-3-git-send-email-catalin.marinas@arm.com>
References: <1464706504-25224-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160629195137.GA142854@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Tue, May 31, 2016 at 03:55:04PM +0100, Catalin Marinas wrote:
> Currently, the compat /proc/cpuinfo is provided only if a task has the
> PER_LINUX32 personality, either by setting it explicitly or by
> inheriting it from the parent task. This is in line with the "uname -m"
> behaviour.
> 
> However, there are 32-bit user applications making use of the
> /proc/cpuinfo and unaware of a need to set the personality. This patch
> changes the arm64 /proc/cpuinfo logic to provide the compat information
> if the task is 32-bit _or_ the PER_LINUX32 personality is set.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

What's the status on this patch? The previous patch (which was accepted
already) is indeed confusing, because ARM32 processes on an ARM64 system
are not necessarily setting PER_LINUX32.

I'm also curious, why was 'model name' removed from ARM64 in the first
place? Plenty of other architectures support a similar property, and
it's useful for some tools that already parse this, such as coreutils
`uname -p` on Gentoo (and presumably others -- my Ubuntu machine must be
similarly patched, as it supports `uname -p` on x86_64).

If we were to just stick 'model name' back in unconditionally, we could
avoid the objections Will raised entirely :)

Regards,
Brian

> ---
>  arch/arm64/kernel/cpuinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index c173d329397f..bd6a122ea856 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -106,7 +106,8 @@ static const char *const compat_hwcap2_str[] = {
>  static int c_show(struct seq_file *m, void *v)
>  {
>  	int i, j;
> -	bool compat = personality(current->personality) == PER_LINUX32;
> +	bool compat = is_compat_task() ||
> +		personality(current->personality) == PER_LINUX32;
>  
>  	for_each_online_cpu(i) {
>  		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
