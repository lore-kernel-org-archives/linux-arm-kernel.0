From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Wed, 17 Sep 2014 16:12:41 -0700
Subject: [RFC PATCH] dt:numa: adding numa node mapping for memory nodes.
In-Reply-To: <541A01B7.8030601@mentor.com>
References: <1410944189-3608-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <541A01B7.8030601@mentor.com>
Message-ID: <CAMDttNfSr5BrnEwLXqgy676jOZbFHhXcMtC0n7gBSniwhWCDRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 2:48 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> On 09/17/2014 03:56 AM, Ganapatrao Kulkarni wrote:
>> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>
>> This patch adds property "nid" to memory node to provide the memory range to
>> numa node id mapping.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>
>> ---
>>  Documentation/devicetree/bindings/numa.txt | 58 ++++++++++++++++++++++++++++++
>>  1 file changed, 58 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/numa.txt
>>
>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>> new file mode 100644
>> index 0000000..c4a94f2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/numa.txt
>> @@ -0,0 +1,58 @@
>> +======================================================
>> +numa id binding description
>> +======================================================
>> +
>> +======================================================
>> +1 - Introduction
>> +======================================================
>> +The device node  property "nid(numa node id)" can be added to memory
>> +device node to map the range of memory addresses as defined in property "reg".
>> +The property "nid" maps the memory range to the numa node id, which is used to
>> +find the local and remory pages on numa aware systems.
>
> "Local" and "remote" memory are notions that relate to some other
> resource -- typically a CPU, but also I/O resources on some systems.  It
> seems to me that a useful NUMA binding would at least specify a "nid"
> property, or something like it, for both cpu and memory nodes.  But this
> document speaks only of memory nodes.
>
> As Kumar said, the device tree on powerpc server systems already has
> properties that express NUMA information.  If you can get hold of a copy
> of the PAPR (not ePAPR) from power.org, refer to the description of
> "ibm,associativity" and related properties.  I recall that it's a bit
> more complex than this proposal, though.

I'm not able to find a link to the actual PAPR (not ePAPR)
specification. Anyone has a linky?

I did find some code in tree, but couldn't find the bindings in
Documentation/devicetree/.

Seems like we'd care about form1?
-----8<-----
commit 41eab6f88f24124df89e38067b3766b7bef06ddb
Author: Anton Blanchard <anton@samba.org>
Date:   Sun May 16 20:22:31 2010 +0000

    powerpc/numa: Use form 1 affinity to setup node distance

    Form 1 affinity allows multiple entries in
ibm,associativity-reference-points
    which represent affinity domains in decreasing order of importance. The
    Linux concept of a node is always the first entry, but using the other
    values as an input to node_distance() allows the memory allocator to make
    better decisions on which node to go first when local memory has been
    exhausted.

    We keep things simple and create an array indexed by NUMA node, capped at
    4 entries. Each time we lookup an associativity property we initialise
    the array which is overkill, but since we should only hit this path during
    boot it didn't seem worth adding a per node valid bit.

    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
----->8-----


>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
