From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Oct 2011 13:53:49 -0700
Subject: [RFC] [PATCH] ARM: tegra: emc: device tree bindings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173CA2CC18@HQMAIL01.nvidia.com>
References: <1318873976-25335-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CBFB@HQMAIL01.nvidia.com>
	<CAOesGMh387Oghyd_TobnTOja6tU2uU5kt-86_HwQe7nFiL+svw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CC18@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMghu6Bn3RrFKEUBKkUNS_K8Y0ho3Y2uFZh_LXbfT80hFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 11:54 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Tuesday, October 18, 2011 12:43 PM:
>> On Tue, Oct 18, 2011 at 11:30 AM, Stephen Warren <swarren@nvidia.com> wrote:
>> > Olof Johansson wrote at Monday, October 17, 2011 11:53 AM:
>> > ...
>> >> +Embedded Memory Controller configuration table
>> > ...
>> >> +Properties:
>> >> +- name : Should start with emc-table
>> >
>> >> +- compatible : should contain "nvidia,tegra20-emc-table".
>> >> +- reg : only needed if nvidia,use-ram-code is present in the
>> >> + ?parent. If so, the numerical representation of the selected ram code
>> >> + ?as reported by the strap option APB misc register.
>> >
>> > I don't think the compatible or reg properties are needed; the EMC tables
>> > aren't addressable objects on a bus, so no need for reg. I could see an
>> > argument that we'd want to version the emc-table format, and so the
>> > compatible flag might be useful, yet AIUI, compatible is more for defining
>> > HW compatibility (and hence driver instantiation), rather than a property
>> > of some configuration node.
>>
>> I was struggling with a good way to specify the selection of the
>> modules. I can definitely use a nvidia,ram-code property instead of
>> reg (with a similar definition to how reg was used here).
>
> Ah, so reg is the ram-code value. I missed that. Using an explicitly
> named property for this seems better to me, but I'll defer to DT experts
> on what's the standard practice for this.

Sounds like for these binding-specific things the rules are pretty
loose in general, but see below on my new proposal.

>> Compatible is still needed, in my opinion -- otherwise there will be
>> no way to tell if the node is there to describe emc timings or if it's
>> some new node used to describe something else (such as SDRAM chips as
>> mentioned above).
>
> Can't you go by node name; enumerate all nodes with a particular name.
> Or define another intermediate node that will always contain tables and
> nothing else, then just enumerate all child nodes of that node:
>
> emc at xxxxx {
> ? ?emc-tables {
> ? ? ? ?table-333 at 0 {};
> ? ? ? ?table-666 at 0 {};
> ? ?};
> };
>
> The Tegra pinmux bindings I proposed certainly used this technique; a
> main node with a well-known name, followed by enumeration of all child
> nodes of that, and nobody /said/ anything about that being a bad idea.

I'm not really picky on this, but I think I would rather use a
compatible field than rely on naming.

That being said, doing a two-level approach will probably make it
easier than the flat structure I initially had. So:

emc at xxx {
    nvidia,use-ram-code;
    emc-table-ram-code-0 {
        nvidia,ram-code = < 0 >;
        table-166 { compatible = "tegra20-emc-table"; ... };
        table-333 { ... };
    };

    emc-table-ram-code-1 {
        nvidia,ram-code = < 1 >;
        ...
    };
};

... and for none-ram-code, just leave out the emc-table-ramcode-x level.

So, for nvidia,use-ram-code case, it'll be one intermediate step of
finding the right subnode, the rest of the table setup code will be
common. None of it will be bound to actual node names though -- first
step is iterating child nodes looking for nvidia,ram-code properties
to match, and second step iterates by matching compatible fields.


-Olof
