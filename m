From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Sat, 29 Aug 2015 20:26:42 +0530
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <55E17F58.5020101@huawei.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAL_JsqLOpUTVeKbkJ6uPi0EYistd=BowAHdtSmaUYYDhU6c9Sg@mail.gmail.com>
 <55E17F58.5020101@huawei.com>
Message-ID: <CAFpQJXWO0xT0kxWf09L_XcAOXm1Lov8i2U2BQzk-x0TStj7vBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thunder,

On Sat, Aug 29, 2015 at 3:16 PM, Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
> On 2015/8/28 22:02, Rob Herring wrote:
>> +benh
>>
>> On Fri, Aug 28, 2015 at 7:32 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> Hi,
>>>
>>> On Fri, Aug 14, 2015 at 05:39:32PM +0100, Ganapatrao Kulkarni wrote:
>>>> DT bindings for numa map for memory, cores and IOs using
>>>> arm,associativity device node property.
>>>
>>> Given this is just a copy of ibm,associativity, I'm not sure I see much
>>> point in renaming the properties.
>>
>> So just keep the ibm? I'm okay with that. That would help move to
>> common code. Alternatively, we could drop the vendor prefix and have
>> common code just check for both.
>>
>
> Hi all,
>
> Why not copy the method of ACPI numa? There only three elements should be configured:
> 1) a cpu belong to which node
> 2) a memory block belong to which node
> 3) the distance of each two nodes
>
> The devicetree nodes of numa can be like below:
> / {
>         ...
>
>         numa-nodes-info {
>                 node-name: node-description {
>                         mem-ranges = <...>;
>                         cpus-list = <...>;
>                 };
>
>                 nodes-distance {
>                         distance-list = <...>;
>                 };
>         };
>
>         ...
> };
>
some what similar to what your are proposing is already implemented in
my v2 patchset.
https://lwn.net/Articles/623920/
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305164.html
we have went to associativity property based implementation to keep it
more generic.
i do have both acpi(using linaro/hanjun's patches) and associativity
based implementations on our internal tree
and tested on thunderx platform.
i do see issue in creating numa mapping using ACPI for IOs(for
example, i am not able to create numa mapping for ITS which is on each
node, using ACPI tables),  since ACPI spec (tables SRAT and SLIT)
talks only about processor and memory.
however associativity is generic and you can apply on any dt node.
> Sorry, I don't think xxx,associativity is a good method, it's hard to config, and it
> seems hardware-dependent. Especially, when we want to support memory hot-add, it's too hard.
> Because xxx,associativity have no obvious information about it. Like powerpc, it use another
> property: "/ibm,dynamic-reconfiguration-memory".
>
> I spend almost a whole month to implement of_numa(configured by dt-nodes), base upon my opinion
> mentioned above. If somebody are interested in it, I can send my patchset to show it.
>
> Regards,
> Thunder.
>
thanks
ganapat
