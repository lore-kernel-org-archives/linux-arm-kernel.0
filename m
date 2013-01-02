From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 02 Jan 2013 15:59:02 -0800
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50E4C9C6.20609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/13 13:07, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> On Tegra at least, this change allows kexec to work with SMP enabled.
> Without this,  machine_shutdown() simply puts all CPUs into a loop. If
> the code of that loop is over-written, the CPUs may hang or crash (which
> I do observe in practice), or cause the kexec'd kernel not to be able to
> initialize them.
>
> This fix has the added benefit that the kexec always happens on the boot
> CPU, and thus kexec mirrors the initial kernel boot as much as possible.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Russell, I assume this should go into the ARM patch tracker if OK?
>
>  arch/arm/kernel/process.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index f79dd1e..1893bda 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -239,6 +239,7 @@ __setup("reboot=", reboot_setup);
>  
>  void machine_shutdown(void)
>  {
> +	disable_nonboot_cpus();
>  #ifdef CONFIG_SMP
>  	smp_send_stop();
>  #endif

How does this work in a CONFIG_SUSPEND=n build? It looks like
disable_nonboot_cpus() would be a no-op and so we wouldn't actually hot
unplug the other CPUs before sending the smp_send_stop(). And then the
smp_send_stop() seems a little unnecessary if we do actually shutdown
the other CPUs.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
