From: bp@alien8.de (Borislav Petkov)
Date: Sat, 5 May 2018 12:12:09 +0200
Subject: [PATCH v3 02/12] ACPI / APEI: Generalise the estatus queue's
 add/remove and notify code
In-Reply-To: <20180427153510.5799-3-james.morse@arm.com>
References: <20180427153510.5799-1-james.morse@arm.com>
 <20180427153510.5799-3-james.morse@arm.com>
Message-ID: <20180505101209.GC3708@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 04:35:00PM +0100, James Morse wrote:
> To support asynchronous NMI-like notifications on arm64 we need to use
> the estatus-queue. These patches refactor it to allow multiple APEI
> notification types to use it.
> 
> Refactor the estatus queue's pool grow/shrink code and notification
> routine from NOTIFY_NMI's handlers. This will allow another notification
> method to use the estatus queue without duplicating this code.

These two are repeated from patch 1.

> This patch adds rcu_read_lock()/rcu_read_unlock() around the list
> list_for_each_entry_rcu() walker. These aren't strictly necessary as
> the whole nmi_enter/nmi_exit() window is a spooky RCU read-side
> critical section.
> 
> Keep the oops_begin() call for x86, arm64 doesn't have one of these,
> and APEI is the only thing outside arch code calling this..

Next patch removes it so I guess you don't have to talk about it here.

> The existing ghes_estatus_pool_shrink() is folded into the new
> ghes_estatus_queue_shrink_pool() as only the queue uses it.
> 
> _in_nmi_notify_one() is separate from the rcu-list walker for a later
> caller that doesn't need to walk a list.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
> 
> ---
> Changes since v1:
>  * Tidied up _in_nmi_notify_one().
> 
>  drivers/acpi/apei/ghes.c | 100 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 65 insertions(+), 35 deletions(-)

...

> +static int ghes_estatus_queue_notified(struct list_head *rcu_list)
> +{
> +	int ret = -ENOENT;
> +	struct ghes *ghes;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ghes, rcu_list, list) {
> +		if (!_in_nmi_notify_one(ghes))
> +			ret = 0;
> +	}
> +	rcu_read_unlock();
> +
> +	if (IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && ret == 0)

		... && !ret

like the rest of the file.

> +		irq_work_queue(&ghes_proc_irq_work);
> +
> +	return ret;
> +}
> +
>  static unsigned long ghes_esource_prealloc_size(
>  	const struct acpi_hest_generic *generic)
>  {

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
