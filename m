From: oleg@redhat.com (Oleg Nesterov)
Date: Thu, 9 Aug 2018 16:38:28 +0200
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
Message-ID: <20180809143827.GC22636@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I need to read this (hopefully final) version carefully. I'll try to do
this before next Monday.

just one note,

On 08/09, Ravi Bangoria wrote:
>
> +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct list_head *pos, *q;
> +	struct delayed_uprobe *du;
> +
> +	if (!uprobe && !mm)
> +		return;
> +
> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +		du = list_entry(pos, struct delayed_uprobe, list);
> +
> +		if (uprobe && mm && du->uprobe == uprobe && du->mm == mm)
> +			delayed_uprobe_delete(du);
> +		else if (!uprobe && du->mm == mm)
> +			delayed_uprobe_delete(du);
> +		else if (!mm && du->uprobe == uprobe)
> +			delayed_uprobe_delete(du);
> +	}

Sorry, I can't resist... this doesn't look very nice. How about

	list_for_each_safe(pos, q, &delayed_uprobe_list) {
		du = list_entry(pos, struct delayed_uprobe, list);

		if (uprobe && du->uprobe != uprobe)
			continue;
		if (mm && du->mm != mm)
			continue;

		delayed_uprobe_delete();
	}

I won't insist, this is cosmetic after all, but please consider this change
in case you will need to send v9.

Oleg.
