From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jan 2013 21:52:38 +0000
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130102215238.GG2631@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 02:07:41PM -0700, Stephen Warren wrote:
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

I guess the discussions about getting this into the generic parts of
the kernel came to nothing?

So, yes.

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
> -- 
> 1.7.10.4
> 
