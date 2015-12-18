From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 18 Dec 2015 21:00:18 +0530
Subject: [RESEND PATCH v7 2/4] Documentation, dt, arm64/arm: dt bindings
 for numa.
In-Reply-To: <20151218141826.GB30229@leverpostej>
References: <1450413433-7467-1-git-send-email-gkulkarni@caviumnetworks.com>
 <20151218141826.GB30229@leverpostej>
Message-ID: <CAFpQJXVmXkgD1FuMbU3rWg5MR3AEeneHAiG6XVfOs6m6e6=byQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


On Fri, Dec 18, 2015 at 7:48 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
>> +==============================================================================
>> +2 - numa-node-id
>> +==============================================================================
>> +
>> +For the purpose of identification, each NUMA node is associated with a unique
>> +token known as a node id. For the purpose of this binding
>> +a node id is a 32-bit integer.
>> +
>> +A device node is associated with a NUMA node by the presence of a
>> +numa-node-id property which contains the node id of the device.
>> +
>> +Example:
>> +     /* numa node 0 */
>> +     numa-node-id = <0>;
>> +
>> +     /* numa node 1 */
>> +     numa-node-id = <1>;
>> +
>> +==============================================================================
>> +3 - distance-map
>> +==============================================================================
>> +
>> +The device tree node distance-map describes the relative
>> +distance(memory latency) between all numa nodes.
>> +
>> +- compatible : Should at least contain "numa-distance-map-v1".
>
> Thank you for updating these per my request.
>
> The fact that these have changed since the late posting [1] means that
> this is a new version of the patch rather than a resend. Please update
> the PATCHvX number when changes are made.
>
> You also need to update the driver for the new compatible string, so a
> new version of that is required.
>
>> +- distance-matrix
>> +  This property defines a matrix to describe the relative distances
>> +  between all numa nodes.
>> +  It is represented as a list of node pairs and their relative distance.
>> +
>> +  Note:
>> +     1. Each entry represents distance from first node to second node.
>> +     The distance are equal in either direction.
>> +     2. The distance from a node to self(local distance) is represented
>> +     with value 10 and all inter node distance should be represented with
>> +     value greater than 10.
>> +     3. distance-matrix shold have entries in lexicographical ascending
>> +     order of nodes.
>> +     4. There must be only one Device node distance-map and must reside in the root node.
>
> I am still concerned that the local distance of 10 is completely
> arbitrary.
IMHO, i do not see any issue in having defined local distance to
arbitrary number(10).
inter node numa distance is relative number with respect to local distance
we have to fix local distance to some value, having it in dt to make
generic will not add
any additional value as compared to having the fixed local distance to 10.

 #define LOCAL_DISTANCE          10
this macro which is defined in common code and used in many places in
common code as well in other arch specific codes.
If we add property to define local distance and it imply that local
distance can be changed to any value other than 10.
having this change demands common code changes wherever LOCAL_DISTANCE is used!.
I am not finding any reasoning to make local distance generic.

please correct me, if i misunderstood your suggestion
>
> Please:
>
> * Add a new local-distance property to the distance-map node allowing a
>   uniform local distance to be described, and require this property to
>   be present.
>
> * Update the driver to account for that and the compatible string
>   change.
>
> * Send a complete PATCHv8 (or PATCHv$X where X > 7) series with a proper
>   changelog.
>
> Thanks,
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385826.html

thanks
Ganapat
