From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Mon, 26 Mar 2012 19:23:44 +0200
Subject: [PATCH v2.1 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
In-Reply-To: <20120326170443.GA25229@redhat.com>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
 <1332593021.16159.27.camel@twins> <20120324164316.GB3640@lizard>
 <20120325174210.GA23605@redhat.com> <1332748746.16159.62.camel@twins>
 <20120326170443.GA25229@redhat.com>
Message-ID: <1332782624.16159.145.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-03-26 at 19:04 +0200, Oleg Nesterov wrote:

> Interesting... Why? I mean, why do you dislike stop_machine() in
> _cpu_down() ? Just curious.

It disturbs all cpus, the -rt people don't like that their FIFO tasks
don't get to run, the trading people don't like their RDMA poll loops to
be interrupted.. etc.

Now arguably, one should simply not do hotplug crap while such things
are running, and mostly that's a perfectly fine constraint. But it
doesn't help that people view cpu hotplug as a power savings or resource
provisioning 'feature' and there's userspace daemons that plug
on-demand.

But my ultimate goal is to completely remove synchronization that is
actively machine wide, since we all know that as long as such stuff
exists people will want to use it.

Now I don't know we'll ever fully get there -- see the BKL saga -- but
its worth trying I think. The module unload and esp. the text_poke usage
of stop_machine are much worse offenders, since both those are
relatively common and much harder to avoid.
