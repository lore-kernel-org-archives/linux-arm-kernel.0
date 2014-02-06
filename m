From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Feb 2014 11:41:55 +0000
Subject: [PATCH 29/51] arm64, debug-monitors: Fix CPU hotplug callback
 registration
In-Reply-To: <20140205220957.19080.79200.stgit@srivatsabhat.in.ibm.com>
References: <20140205220251.19080.92336.stgit@srivatsabhat.in.ibm.com>
 <20140205220957.19080.79200.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20140206114155.GL26035@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 10:09:58PM +0000, Srivatsa S. Bhat wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:

[...]

> Fix the debug-monitors code in arm64 by using this latter form of callback
> registration.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/arm64/kernel/debug-monitors.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 636ba8b..959a16b 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -155,12 +155,16 @@ static struct notifier_block os_lock_nb = {
>  
>  static int debug_monitors_init(void)
>  {
> +	cpu_maps_update_begin();
> +
>  	/* Clear the OS lock. */
>  	smp_call_function(clear_os_lock, NULL, 1);
>  	clear_os_lock(NULL);
>  
>  	/* Register hotplug handler. */
> -	register_cpu_notifier(&os_lock_nb);
> +	__register_cpu_notifier(&os_lock_nb);
> +
> +	cpu_maps_update_done();
>  	return 0;
>  }
>  postcore_initcall(debug_monitors_init);

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
