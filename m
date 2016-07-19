From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 19 Jul 2016 16:22:08 +0200 (CEST)
Subject: [PATCH v11 04/10] genirq/msi-doorbell: allow MSI doorbell
 (un)registration
In-Reply-To: <1468933367-23159-5-git-send-email-eric.auger@redhat.com>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
 <1468933367-23159-5-git-send-email-eric.auger@redhat.com>
Message-ID: <alpine.DEB.2.11.1607191617071.3596@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2016, Eric Auger wrote:
> +
> +#include <linux/slab.h>
> +#include <linux/irq.h>
> +#include <linux/msi-doorbell.h>
> +
> +struct irqchip_doorbell {
> +	struct irq_chip_msi_doorbell_info info;
> +	struct list_head next;

Again, please align the struct members.

> +};
> +
> +static LIST_HEAD(irqchip_doorbell_list);
> +static DEFINE_MUTEX(irqchip_doorbell_mutex);
> +
> +struct irq_chip_msi_doorbell_info *
> +msi_doorbell_register_global(phys_addr_t base, size_t size,
> +			     int prot, bool irq_remapping)
> +{
> +	struct irqchip_doorbell *db;
> +
> +	db = kmalloc(sizeof(*db), GFP_KERNEL);
> +	if (!db)
> +		return ERR_PTR(-ENOMEM);
> +
> +	db->info.doorbell_is_percpu = false;

Please use kzalloc and get rid of zero initialization. If you add stuff to the
struct then initialization will be automatically 0.

> +void msi_doorbell_unregister_global(struct irq_chip_msi_doorbell_info *dbinfo)
> +{
> +	struct irqchip_doorbell *db, *tmp;
> +
> +	mutex_lock(&irqchip_doorbell_mutex);
> +	list_for_each_entry_safe(db, tmp, &irqchip_doorbell_list, next) {

Why do you need that iterator? 

    db = container_of(dbinfo, struct ....., info);

Hmm?

> +		if (dbinfo == &db->info) {
> +			list_del(&db->next);
> +			kfree(db);

Please move the kfree() outside of the lock region. It does not matter much
here, but we really should stop doing random crap in locked regions.

Thanks,

	tglx
