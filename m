From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Oct 2017 18:19:59 +0100
Subject: [PATCH v4 11/13] firmware: arm_sdei: add support for CPU private
 events
In-Reply-To: <20171017174432.1684-12-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-12-james.morse@arm.com>
Message-ID: <20171018171959.GJ21820@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:44:30PM +0100, James Morse wrote:
> Private SDE events are per-cpu, and need to be registered and enabled
> on each CPU.
> 
> Hide this detail from the caller by adapting our {,un}register and
> {en,dis}able calls to send an IPI to each CPU if the event is private.
> 
> CPU private events are unregistered when the CPU is powered-off, and
> re-registered when the CPU is brought back online. This saves bringing
> secondary cores back online to call private_reset() on shutdown, kexec
> and resume from hibernate.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/firmware/arm_sdei.c | 242 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 228 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 28e4c4cbb16d..5598d9ba8b5d 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -21,9 +21,11 @@
>  #include <linux/acpi.h>
>  #include <linux/arm_sdei.h>
>  #include <linux/arm-smccc.h>
> +#include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/compiler.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/errno.h>
>  #include <linux/hardirq.h>
> @@ -64,12 +66,49 @@ struct sdei_event {
>  	u8			priority;
>  
>  	/* This pointer is handed to firmware as the event argument. */
> -	struct sdei_registered_event *registered;
> +	union {
> +		/* Shared events */
> +		struct sdei_registered_event *registered;
> +
> +		/* CPU private events */
> +		struct sdei_registered_event __percpu *private_registered;
> +	};
>  };
>  
>  static LIST_HEAD(sdei_events);
>  static DEFINE_SPINLOCK(sdei_events_lock);
>  
> +/* When frozen, cpu-hotplug notifiers shouldn't unregister/re-register events */
> +static bool frozen;

It looks like this can be accessed concurrently, so you need at least
READ_ONCE/WRITE_ONCE.

>  /* When entering idle, mask/unmask events for this cpu */
>  static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
>  			    void *data)
> @@ -610,6 +813,7 @@ static int sdei_device_freeze(struct device *dev)
>  {
>  	int err;
>  
> +	frozen = true;
>  	err = sdei_event_unregister_all();

Are the release semantics from spin_unlock in sdei_event_unregister_all
sufficient for the ordering guarantees you need?

Will
