From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 04 Feb 2013 19:17:45 +0530
Subject: [PATCH v5 00/45] CPU hotplug: stop_machine()-free CPU hotplug
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
Message-ID: <510FBC01.2030405@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 01:03 PM, Srivatsa S. Bhat wrote:
> Hi,
> 
> This patchset removes CPU hotplug's dependence on stop_machine() from the CPU
> offline path and provides an alternative (set of APIs) to preempt_disable() to
> prevent CPUs from going offline, which can be invoked from atomic context.
> The motivation behind the removal of stop_machine() is to avoid its ill-effects
> and thus improve the design of CPU hotplug. (More description regarding this
> is available in the patches).
> 
> All the users of preempt_disable()/local_irq_disable() who used to use it to
> prevent CPU offline, have been converted to the new primitives introduced in the
> patchset. Also, the CPU_DYING notifiers have been audited to check whether
> they can cope up with the removal of stop_machine() or whether they need to
> use new locks for synchronization (all CPU_DYING notifiers looked OK, without
> the need for any new locks).
> 
> Applies on v3.8-rc4. It currently has some locking issues with cpu idle (on
> which even lockdep didn't provide any insight unfortunately). So for now, it
> works with CONFIG_CPU_IDLE=n.
> 

I ran this patchset on a POWER 7 machine with 32 cores (128 logical CPUs)
[POWER doesn't have the cpu idle issue]. And the results (latency or the time
taken for a single CPU offline) are shown below.

Experiment:
----------

Run a heavy workload (genload from LTP) that generates significant system time;
With '# online CPUs' online, measure the time it takes to complete the stop-m/c
phase in mainline and the equivalent phase in the patched kernel for 1 CPU
offline operation. (It is important to note here that the measurement shows the
average time it takes to perform a *single* CPU offline operation).

Expected results:
----------------

Since stop-machine doesn't scale with no. of online CPUs, we expect the
mainline kernel to take longer and longer for taking 1 CPU offline, with
increasing no. of online CPUs. The patched kernel is expected to take a
constant amount of time, irrespective of the number of online CPUs, because it
has a scalable design.


Experimental results:
---------------------

                 Avg. latency of 1 CPU offline (ms) [stop-cpu/stop-m/c latency]

# online CPUs    Mainline (with stop-m/c)       This patchset (no stop-m/c)

      8                 17.04                          7.73

     16                 18.05                          6.44

     32                 17.31                          7.39

     64                 32.40                          9.28

    128                 98.23                          7.35


Analysis and conclusion:
------------------------

The patched kernel performs pretty well and meets our expectations. It beats
mainline easily. As shown in the table above and the graph attached with this
mail, it has the following advantages:

1. Avg. latency is less than mainline (roughly half that of even the least
   in mainline).

2. The avg. latency is a constant, irrespective of number of online CPUs in
   the system, which proves that the design/synchronization scheme is scalable.

3. Throughout the duration shown above, mainline disables interrupts on all
   CPUs. But the patched kernel not only has a smaller duration of hotplug,
   but also keeps interrupts enabled on other CPUs, which makes CPU offline
   less disruptive on latency-sensitive workloads running on the system.


So, this gives us an idea of how this patchset actually performs. Of course
there are bugs and issues that still need fixing (even mainline crashes with
hotplug sometimes), but I did the above experiment to verify whether the
design is working as expected and whether it really shows significant
improvements over mainline. And thankfully, it does :-)

Regards,
Srivatsa S. Bhat

-------------- next part --------------
A non-text attachment was scrubbed...
Name: CPU hotplug latency.png
Type: image/png
Size: 172574 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/9a92227e/attachment-0001.png>
