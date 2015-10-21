From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 21 Oct 2015 09:57:11 +0530
Subject: [PATCH v6 2/4] Documentation, dt, arm64/arm: dt bindings for numa.
In-Reply-To: <20151020153526.GC3349@leverpostej>
References: <1445337931-11344-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1445337931-11344-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20151020153526.GC3349@leverpostej>
Message-ID: <CAFpQJXUfpbNkvuLrOPs2nUV+HOJKXLfO07fqsA6TeS0e9+Ub4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 9:05 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Oct 20, 2015 at 04:15:29PM +0530, Ganapatrao Kulkarni wrote:
>> DT bindings for numa mapping of memory, cores and IOs.
>>
>> Reviewed-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>> ---
>>  Documentation/devicetree/bindings/arm/numa.txt | 275 +++++++++++++++++++++++++
>>  1 file changed, 275 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/numa.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/numa.txt b/Documentation/devicetree/bindings/arm/numa.txt
>> new file mode 100644
>> index 0000000..f3bc8e6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/numa.txt
>> @@ -0,0 +1,275 @@
>> +==============================================================================
>> +NUMA binding description.
>> +==============================================================================
>> +
>> +==============================================================================
>> +1 - Introduction
>> +==============================================================================
>> +
>> +Systems employing a Non Uniform Memory Access (NUMA) architecture contain
>> +collections of hardware resources including processors, memory, and I/O buses,
>> +that comprise what is commonly known as a NUMA node.
>> +Processor accesses to memory within the local NUMA node is generally faster
>> +than processor accesses to memory outside of the local NUMA node.
>> +DT defines interfaces that allow the platform to convey NUMA node
>> +topology information to OS.
>> +
>> +==============================================================================
>> +2 - proximity
>> +==============================================================================
>> +The proximity device node property describes proximity domains within a
>> +machine. This property can be used in device nodes like cpu, memory, bus and
>> +devices to map to respective numa nodes.
>> +
>> +proximity property is a 32-bit integer which defines numa node id to which
>> +this device node has numa proximity association.
>> +
>> +Example:
>> +     /* numa node 0 */
>> +     proximity = <0>;
>> +
>> +     /* numa node 1 */
>> +     proximity = <1>;
>
>
> It would probably be better to call this something like "numa-domain-id"
> or "numa-node-id". The "proximity" is a relationship (that's actually
> described in the distance map), and it makes it obvious that this is
> NUMA related.
ok, numa-node-id makes more appropriate.
>
>> +
>> +==============================================================================
>> +3 - distance-map
>> +==============================================================================
>> +
>> +The device tree node distance-map describes the relative
>> +distance (memory latency) between all numa nodes.
>
> Rather than making this another magic name, we should give it a
> compatible string. That will also help if/when updating this in future.
thanks, we can have compatible string, which helps in future expansions.
>
>> +
>> +- distance-matrix
>> +  This property defines a matrix to describe the relative distances
>> +  between all numa nodes.
>> +  It is represented as a list of node pairs and their relative distance.
>> +
>> +  Note:
>> +     1. If there is no distance-map, the system should setup:
>> +
>> +                   local/local:  10
>> +                   local/remote: 20
>> +     for all node distances.
>
> I think that either you have both the IDs and a distance map, or we
> assume !NUMA (as we currently do). If your system is so trivial that the
> above defaults are good enough, it's trivial to write them explicitly.
it might be trivial to mention this explicitly, however definitely
2 node numa system is not trivial!!
>
> So I think this should go.
ok.
>
>> +
>> +     2. If both directions between 2 nodes have the same distance, only
>> +            one entry is required.
>
> So there's a direction implied by each entry? That should be stated
> explicitly.
ok
>
> That said, I'm having some difficulty comprehending an asymmetric
> distance, and I worry that it's ill-defined.
>
> What does the direction apply to specifically?
>
> How is it to be interpreted?
>
> Assuming I have two domains A and B, and I have:
>
>         distance-matrix = <A B 1>, <B A 255>;
>
> What does that mean for those domains? What's fast and what is slow?
lesser the distance value indicates less inter node access latency.
for cpu present in node A to access memory of node B, the latency
would be 1(less latency)
for other-way scenario, it is 255(more latency)

i am not sure how the system behaves with asymmetric distance, however
function sched_init_numa tries to assess that the distance are symmetric or not
and for asymmetric, it prints warning.
>
>> +     3. distance-matrix shold have entries in ascending order of nodes.
>
> s/ascending/lexicographical ascending/, and s/nodes/domain ids/, just to
> be explicit.
ok
>
>> +     4. Device node distance-map must reside in the root node.
>
> Presumably there should be no duplicate entries? We should state that
> explicitly.
ok
>
>> +
>> +Example:
>> +     4 nodes connected in mesh/ring topology as below,
>> +
>> +             0_______20______1
>> +             |               |
>> +             |               |
>> +          20 |               |20
>> +             |               |
>> +             |               |
>> +             |_______________|
>> +             3       20      2
>> +
>> +     if relative distance for each hop is 20,
>> +     then inter node distance would be for this topology will be,
>> +           0 -> 1 = 20
>> +           1 -> 2 = 20
>> +           2 -> 3 = 20
>> +           3 -> 0 = 20
>> +           0 -> 2 = 40
>> +           1 -> 3 = 40
>> +
>> +     and dt presentation for this distance matrix is,
>> +
>> +             distance-map {
>> +                      distance-matrix = <0 0  10>,
>> +                                        <0 1  20>,
>> +                                        <0 2  40>,
>> +                                        <0 3  20>,
>> +                                        <1 0  20>,
>> +                                        <1 1  10>,
>> +                                        <1 2  20>,
>> +                                        <1 3  40>,
>> +                                        <2 0  40>,
>> +                                        <2 1  20>,
>> +                                        <2 2  10>,
>> +                                        <2 3  20>,
>> +                                        <3 0  20>,
>> +                                        <3 1  40>,
>> +                                        <3 2  20>,
>> +                                        <3 3  10>;
>> +             };
>> +
>> +Note:
>> +      1. The entries like <0 0> <1 1>  <2 2> <3 3>
>> +         can be optional and system can put default value(local distance, i.e 10).
>
> As mentioned above, I think this should go.
ok
>
> Other than the comments above, this is looking promising!
thanks
>
> Thanks,
> Mark.
thanks
Ganapat
