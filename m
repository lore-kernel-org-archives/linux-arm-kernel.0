From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Dec 2012 15:55:36 -0800
Subject: [PATCH] kexec: disable non-boot CPUs
In-Reply-To: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
 (Stephen Warren's message of "Wed, 19 Dec 2012 16:44:41 -0700")
References: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <87mwx9y4uf.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> From: Stephen Warren <swarren@nvidia.com>
>
> Both the regular reboot and shutdown paths do this. It seems reasonable
> for kexec to work the same way.
>
> On the Tegra ARM SoC at least, this change allows kexec to work with SMP
> enabled. ARM's machine_shutdown() simply puts all CPUs into a loop. If
> the code of that loop is over-written, the CPUs may crash, and cause the
> kexec'd kernel not to be able to initialize them. In practice, this
> causes the kexec'd kernel to hang and/or crash. The intended way to
> solve this is for ARM machines to provide a cpu_kill SMP operation to
> e.g. power down the CPUs, or place them in reset. However, at least on
> Tegra, the implementation of that function would simply be duplicating
> the hotplug code that already exists, so it seems simpler to just call
> disable_nonboot_cpus() for the kexec path, just like reboot/shutdown.

I would like to ack this but I think this is one of those differences
for which there is a reason.

On x86 this happens in machine_shutdown.

Before this can be merged someone needs to look into the history and
see why we don't share this code path.

My hunch is because it was duplication of effort and the stop machine
code has historically been fragile.

Eric



> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  kernel/kexec.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 5e4bd78..6fe74d3 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1570,6 +1570,7 @@ int kernel_kexec(void)
>  #endif
>  	{
>  		kernel_restart_prepare(NULL);
> +		disable_nonboot_cpus();
>  		printk(KERN_EMERG "Starting new kernel\n");
>  		machine_shutdown();
>  	}
