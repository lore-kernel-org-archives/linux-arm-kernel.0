From: oleg@redhat.com (Oleg Nesterov)
Date: Sun, 10 Feb 2013 21:13:12 +0100
Subject: [PATCH v5 04/45] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
In-Reply-To: <5117F0C0.2030605@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073347.13822.85876.stgit@srivatsabhat.in.ibm.com>
 <20130208231017.GK2666@linux.vnet.ibm.com>
 <5117F0C0.2030605@linux.vnet.ibm.com>
Message-ID: <20130210201312.GB6236@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11, Srivatsa S. Bhat wrote:
>
> On 02/09/2013 04:40 AM, Paul E. McKenney wrote:
> >> +static void announce_writer_inactive(struct percpu_rwlock *pcpu_rwlock)
> >> +{
> >> +	unsigned int cpu;
> >> +
> >> +	drop_writer_signal(pcpu_rwlock, smp_processor_id());
> >
> > Why do we drop ourselves twice?  More to the point, why is it important to
> > drop ourselves first?
> >
>
> I don't see where we are dropping ourselves twice. Note that we are no longer
> in the cpu_online_mask, so the 'for' loop below won't include us. So we need
> to manually drop ourselves. It doesn't matter whether we drop ourselves first
> or later.

Yes, but this just reflects its usage in cpu-hotplug. cpu goes away under
_write_lock.

Perhaps _write_lock/unlock shoud use for_each_possible_cpu() instead?

Hmm... I think this makes sense anyway. Otherwise, in theory,
percpu_write_lock(random_non_hotplug_lock) can race with cpu_up?

Oleg.
