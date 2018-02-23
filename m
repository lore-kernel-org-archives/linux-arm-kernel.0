From: james.morse@arm.com (James Morse)
Date: Fri, 23 Feb 2018 18:02:21 +0000
Subject: [PATCH 01/11] ACPI / APEI: Move the estatus queue code up, and
 under its own ifdef
In-Reply-To: <20180220192852.GB24320@pd.tnic>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-2-james.morse@arm.com> <20180220192852.GB24320@pd.tnic>
Message-ID: <5A90572D.9010704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 20/02/18 19:28, Borislav Petkov wrote:
> On Thu, Feb 15, 2018 at 06:55:56PM +0000, James Morse wrote:
>> +#ifdef CONFIG_HAVE_ACPI_APEI_NMI
>> +/*
>> + * While printk() now has an in_nmi() path, the handling for CPER records
>> + * does not. For example, memory_failure_queue() takes spinlocks and calls
>> + * schedule_work_on().
>> + *
>> + * So in any NMI-like handler, we allocate required memory from lock-less
>> + * memory allocator (ghes_estatus_pool), save estatus into it, put them into
>> + * lock-less list (ghes_estatus_llist), then delay printk into IRQ context via
>> + * irq_work (ghes_proc_irq_work).  ghes_estatus_size_request record
>> + * required pool size by all NMI error source.
> 
> Since you're touching this, pls correct the grammar too, while at it,
> and correct them into proper sentences.
> Also, end function names with "()".
> Also the "we" pronoun and tense sounds funny - let's make it passive.

Sure. I reckon your English grammar is better than mine, is this better?:

| In any NMI-like handler, memory from ghes_estatus_pool is used to save
| estatus, and added to the ghes_estatus_llist. irq_work_queue() causes
| ghes_proc_in_irq() to run in IRQ context where each estatus in
| ghes_estatus_llist are processed. Each NMI-like error source must grow
| the ghes_estatus_pool to ensure memory is available.



Thanks,

James
