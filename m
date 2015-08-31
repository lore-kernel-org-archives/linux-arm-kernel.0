From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Mon, 31 Aug 2015 09:46:48 +0800
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <1440844631.2912.248.camel@kernel.crashing.org>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAL_JsqLOpUTVeKbkJ6uPi0EYistd=BowAHdtSmaUYYDhU6c9Sg@mail.gmail.com>
 <55E17F58.5020101@huawei.com> <1440844631.2912.248.camel@kernel.crashing.org>
Message-ID: <55E3B208.3020404@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/8/29 18:37, Benjamin Herrenschmidt wrote:
> On Sat, 2015-08-29 at 17:46 +0800, Leizhen (ThunderTown) wrote:
>> Why not copy the method of ACPI numa? There only three elements
>> should be configured:
>> 1) a cpu belong to which node
>> 2) a memory block belong to which node
>> 3) the distance of each two nodes

Sorry, I forgot to write something:
4) a device(maybe a bus device) belongs to which node

For example:
device-name {
        ...
        numa-node = <&node0>;
};

To simplify the discussion, I will not mention device again. Treat both
cpus and devices as masters, memorys as slaves.

A bus is not a master, we allow binding numa node to a bus, because we may
want all devices on the bus to inherit its numa node-id without obvious configured one by one.

> 
> This means your are bolting into the DT representation the concept of
> "Node" which isn't necessarily very meaningful.
> 
> Your system is really a hierarchy of objects. You can have cores on a
> chip, already possibly sharing some level of cache or not, you can have
> chips on a module, modules linked at various distances, etc...
> 
> What is "a node" ?
> 
> For example, I have a P8 chip with 2 chips on a module (fast X-bus) and
> 2 modules (slightly slower A-bus). All 4 chips have 2 memory
> controllers each.
> 
> Is a "node" a chip or a module ?

A numa node is a abstract concept, it needn't related to a real hardware level.
A numa node normally contains both cpus and mems, but may only contains cpus or mems,
or maybe nothing(quite rare). We put cpus or mems into a node, because we want to use
node-distance to implement the nearest memory access, the nearest process schedule.

In your example:
On fast X-bus, have a module contains 2 chips.
On slightly slower A-bus, have 2 modules(treat them as 2 chips).
Each chip contains 2 memory controllers.

Suppose each chip access its local bus memory faster than another.

Case1:
Each chip access its 2 local memory controllers faster than others. Then we can define numa nodes:
node-xbus-0: a chip and 2 local memory.
node-xbus-1: a chip and 2 local memory.
node-abus-0: a chip(module) and 2 local memory.
node-abus-1: a chip(module) and 2 local memory.

Case2:
Each chip access any memory controllers on its local bus are the same. Then we can define numa nodes:
node-xbus: 2 chips and 4 local memory.
node-abus: 2 chips(modules) and 4 local memory.


> 
> The Linux concept of node is too restrictive. The associativity
> properties avoid this by allowing you to define as many "levels" of
> associativity as you wish. Also since it's right justified, a given
> component doesn't need to have all levels (a MC can stop at chip while
> cores can go down one more level for example).
> 
> The reference points property gives a hint as "interesting" levels can
> typically be used as a hint for chosing what Linux will use as a "node"
> at least until Linux gets smarter. It can also be used to calculate
> distances.
> 
> Cheers,
> Ben.
> 
> 
> .
> 
