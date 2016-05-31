From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2016 17:18:27 +0100
Subject: [PATCH 2/2] arm64: Always provide compat /proc/cpuinfo for
 32-bit tasks
In-Reply-To: <1464706504-25224-3-git-send-email-catalin.marinas@arm.com>
References: <1464706504-25224-1-git-send-email-catalin.marinas@arm.com>
 <1464706504-25224-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160531161827.GN24936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Hmm, I'm uneasy about this. It feels like an inconsistency with other
things like uname, where we require the personality to be changed explicitly
in order to get the AArch32 interface.

I'd rather go back to changing personality automatically based on the elf
machine, or continue to require that applications be run with the correct
personality (e.g. via linux32). This half way house is just confusing.

Arnd might have more thoughts...

Will
