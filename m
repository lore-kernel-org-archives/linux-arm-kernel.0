From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 18 Oct 2011 11:54:21 -0700
Subject: [RFC] [PATCH] ARM: tegra: emc: device tree bindings
In-Reply-To: <CAOesGMh387Oghyd_TobnTOja6tU2uU5kt-86_HwQe7nFiL+svw@mail.gmail.com>
References: <1318873976-25335-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173CA2CBFB@HQMAIL01.nvidia.com>
	<CAOesGMh387Oghyd_TobnTOja6tU2uU5kt-86_HwQe7nFiL+svw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173CA2CC18@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Tuesday, October 18, 2011 12:43 PM:
> On Tue, Oct 18, 2011 at 11:30 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > Olof Johansson wrote at Monday, October 17, 2011 11:53 AM:
> > ...
> >> +Embedded Memory Controller configuration table
> > ...
> >> +Properties:
> >> +- name : Should start with emc-table
> >
> >> +- compatible : should contain "nvidia,tegra20-emc-table".
> >> +- reg : only needed if nvidia,use-ram-code is present in the
> >> + ?parent. If so, the numerical representation of the selected ram code
> >> + ?as reported by the strap option APB misc register.
> >
> > I don't think the compatible or reg properties are needed; the EMC tables
> > aren't addressable objects on a bus, so no need for reg. I could see an
> > argument that we'd want to version the emc-table format, and so the
> > compatible flag might be useful, yet AIUI, compatible is more for defining
> > HW compatibility (and hence driver instantiation), rather than a property
> > of some configuration node.
> 
> I was struggling with a good way to specify the selection of the
> modules. I can definitely use a nvidia,ram-code property instead of
> reg (with a similar definition to how reg was used here).

Ah, so reg is the ram-code value. I missed that. Using an explicitly
named property for this seems better to me, but I'll defer to DT experts
on what's the standard practice for this.

> Compatible is still needed, in my opinion -- otherwise there will be
> no way to tell if the node is there to describe emc timings or if it's
> some new node used to describe something else (such as SDRAM chips as
> mentioned above).

Can't you go by node name; enumerate all nodes with a particular name.
Or define another intermediate node that will always contain tables and
nothing else, then just enumerate all child nodes of that node:

emc at xxxxx {
    emc-tables {
        table-333 at 0 {};
        table-666 at 0 {};
    };
};

The Tegra pinmux bindings I proposed certainly used this technique; a
main node with a well-known name, followed by enumeration of all child
nodes of that, and nobody /said/ anything about that being a bad idea.

-- 
nvpublic
