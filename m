From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Feb 2016 17:36:06 +0000
Subject: [PATCH 6/6] arm64: compat: Check for AArch32 state
In-Reply-To: <1453980737-6126-7-git-send-email-suzuki.poulose@arm.com>
References: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
 <1453980737-6126-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160209173606.GX22874@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 11:32:17AM +0000, Suzuki K Poulose wrote:
> Make sure we have AArch32 state available for running COMPAT binaries.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> [ Added checks for ELF HWCAP, Use cap bit in cap_hwcaps ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

[...]

> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 8cc2a86..2890b74 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -124,7 +124,8 @@ static int c_show(struct seq_file *m, void *v)
>  		 * software which does already (at least for 32-bit).
>  		 */
>  		seq_puts(m, "Features\t:");
> -		if (personality(current->personality) == PER_LINUX32) {
> +		if (system_supports_32bit_el0() &&
> +			personality(current->personality) == PER_LINUX32) {

Wouldn't it be better to prevent tasks changing to the PER_LINUX32
personality on systems that don't support AArch32 at EL0?

Will
