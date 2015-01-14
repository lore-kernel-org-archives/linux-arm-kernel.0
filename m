From: jcm@redhat.com (Jon Masters)
Date: Wed, 14 Jan 2015 12:18:39 -0500
Subject: sysfs topology for arm64 cluster_id
In-Reply-To: <20150114170045.GC21115@leverpostej>
References: <54B5BC84.8090603@redhat.com> <20150114170045.GC21115@leverpostej>
Message-ID: <54B6A4EF.7020501@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 12:00 PM, Mark Rutland wrote:
> On Wed, Jan 14, 2015 at 12:47:00AM +0000, Jon Masters wrote:
>> Hi Folks,
>>
>> TLDR: I would like to consider the value of adding something like
>> "cluster_siblings" or similar in sysfs to describe ARM topology.
>>
>> A quick question on intended data representation in /sysfs topology
>> before I ask the team on this end to go down the (wrong?) path. On ARM
>> systems today, we have a hierarchical CPU topology:
>>
>>                  Socket ---- Coherent Interonnect ---- Socket
>>                    |                                    |
>>          Cluster0 ... ClusterN                Cluster0 ... ClusterN
>>             |             |                      |             |
>>       Core0...CoreN  Core0...CoreN        Core0...CoreN  Core0...CoreN
>>         |       |      |        |           |       |      |       |
>>      T0..TN  T0..Tn  T0..TN  T0..TN       T0..TN T0..TN  T0..TN  T0..TN
>>
>> Where we might (or might not) have threads in individual cores (a la SMT
>> - it's allowed in the architecture at any rate) and we group cores
>> together into units of clusters usually 2-4 cores in size (though this
>> varies between implementations, some of which have different but similar
>> concepts, such as AppliedMicro Potenza PMDs CPU complexes of dual
>> cores). There are multiple clusters per "socket", and there might be an
>> arbitrary number of sockets. We'll start to enable NUMA soon.
> 
> I have a slight disagreement with the diagram above.

Thanks for the clarification - note that I was *explicitly not* saying
that the MPIDR Affinity bits sufficiently described the system :) Nor do
I think cpu-map does cover everything we want today.

> The MPIDR_EL1.Aff* fields and the cpu-map bindings currently only
> describe the hierarchy, without any information on the relative
> weighting between levels, and without any mapping to HW concepts such as
> sockets. What these happen to map to is specific to a particular system,
> and the hierarchy may be carved up in a number of possible ways
> (including "virtual" clusters). There are also 24 RES0 bits that could
> potentially become additional Aff fields we may need to describe in
> future.

> "socket", "package", etc are meaningless unless the system provides a
> mapping of Aff levels to these. We can't guess how the HW is actually
> organised.

The replies I got from you and Arnd gel with my thinking that we want
something generic enough in Linux to handle this in a non-architectural
way (real topology, not just hierarchies). That should also cover the
kind of cluster-like stuff e.g. AMD with NUMA on HT on a single socket
and other stuff. So...it sounds like we need "something" to add to our
understanding of hierarchy, and that "something" is in sysfs. A proposal
needs to be derived (I think Don will followup since he is keen to poke
at this). We'll go back to the ACPI ASWG folks to add whatever is
missing to future ACPI bindings after that discussion.

Jon.
