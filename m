From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Jul 2015 09:48:47 +0100
Subject: [PATCH v7 09/11] KVM: arm64: guest debug, HW assisted debug
 support
In-Reply-To: <1435775343-20034-10-git-send-email-alex.bennee@linaro.org>
References: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
 <1435775343-20034-10-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150702084847.GB3418@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Wed, Jul 01, 2015 at 07:29:01PM +0100, Alex Benn?e wrote:
> This adds support for userspace to control the HW debug registers for
> guest debug. In the debug ioctl we copy an IMPDEF registers into a new
> register set called host_debug_state.
> 
> We use the recently introduced vcpu parameter debug_ptr to select which
> register set is copied into the real registers when world switch occurs.
> 
> I've made some helper functions from hw_breakpoint.c more widely
> available for re-use.
> 
> As with single step we need to tweak the guest registers to enable the
> exceptions so we need to save and restore those bits.
> 
> Two new capabilities have been added to the KVM_EXTENSION ioctl to allow
> userspace to query the number of hardware break and watch points
> available on the host hardware.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

[...]

> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index e7d934d..ac07f2a 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -50,13 +50,13 @@ static int core_num_brps;
>  static int core_num_wrps;
> 
>  /* Determine number of BRP registers available. */
> -static int get_num_brps(void)
> +int get_num_brps(void)
>  {
>         return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
>  }
> 
>  /* Determine number of WRP registers available. */
> -static int get_num_wrps(void)
> +int get_num_wrps(void)
>  {
>         return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
>  }

Sorry, just noticed this, but we already have a public interface for
figuring these numbers out as required by perf. Can't you use
hw_breakpoint_slots(...) instead of exposing these internal helpers?

Will
