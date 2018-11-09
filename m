From: Robert.Richter@cavium.com (Richter, Robert)
Date: Fri, 9 Nov 2018 08:09:28 +0000
Subject: [PATCH 08/10] irqchip/gic-v3-its: Decouple its initialization
 from gic
In-Reply-To: <21a0183b-bf4b-1895-d10b-8287dbff930a@arm.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <20181107220254.6116-9-rrichter@cavium.com>
 <21a0183b-bf4b-1895-d10b-8287dbff930a@arm.com>
Message-ID: <20181109080920.GE4064@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.11.18 11:26:02, Julien Thierry wrote:
> On 07/11/18 22:03, Robert Richter wrote:

> >-static int __init its_init(void)
> >+int __init its_init(void)
> >  {
> >      struct its_node *its;
> >      bool has_v4 = false;
> >      int err;
> >
> >+     if (list_empty(&its_probed))
> >+             return 0;
> >+
> >+     raw_spin_lock(&its_lock);
> >+redo:
> >+     list_for_each_entry(its, &its_probed, entry) {
> >+             list_del_init(&its->entry);
> >+
> >+             raw_spin_unlock(&its_lock);
> >+
> >+             /* Needs to be called in non-atomic context */
> >+             err = its_init_one(its);
> >+             if (err)
> >+                     its_free(its);
> >+
> >+             raw_spin_lock(&its_lock);
> >+
> >+             if (!err)
> >+                     list_add_tail(&its->entry, &its_nodes);
> >+
> >+             goto redo;
> 
> Again, you're starting a loop only to work on the first element and then
> restarting the loop.
> 
> Just do a while (!list_empty()), and without gotos...

When writing the code I have looked into an alternative to
list_for_each_entry() and did not find a better way that works with
proper locking. list_first_entry() requires the list being non-empty.
If you set the lock after list_empty() it is not granted the list is
actual empty. See also my other comment in an earlier mail.

-Robert

> 
> >+     }
> >+
> >+     raw_spin_unlock(&its_lock);
> >+
> >      if (list_empty(&its_nodes)) {
> >              pr_warn("ITS: No ITS available, not enabling LPIs\n");
> >              return -ENXIO;
> >      }
> >
> >      err = allocate_lpi_tables();
> >-     if (err)
> >+     if (err) {
> >+             pr_warn("ITS: Failed to initialize (%d), not enabling LPIs\n",
> >+                     err);
> >              return err;
> >+     }
