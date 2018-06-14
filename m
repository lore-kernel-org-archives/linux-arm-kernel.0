From: Matt.Sealey@arm.com (Matt Sealey)
Date: Thu, 14 Jun 2018 15:04:52 +0000
Subject: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
In-Reply-To: <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
 <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com>
 <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
 <HE1PR0802MB24121F0EEF8D7D643BC391A1EE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <5e013d65-9931-6b8d-ce7c-4333309d4ada@arm.com>
 <CAL_Jsq+0kExVY33kdDoR6bAxbr2VzRUzW2j0k+2wmv4CSNVnpQ@mail.gmail.com>
Message-ID: <HE1PR0802MB241249AB5A90012AA6EB5235EE7D0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

To take this in a somewhat different direction...

> > No, the above comment is about using "unit" ( if it is a standard
> > property for specifying something specific to hardware) instead of
> > "coresight,hwid". I would prefer to stick to the DT graph bindings,
> > because :
>
> "unit" is not a standard property and I don't like it either.

Fair enough.

> If you have "in-ports" and "out-ports" nodes, then that gives you
> direction and you can use reg for the "hardware port".
>
> in-ports {
>   port at 0 {
>     reg = <0>;
>     endpoint {...};
>   };
>   port at 1 {
>     reg = <1>;
>     endpoint {...};
>   };
> };
> out-ports {
>   port at 0 {
>     reg = <0>;
>     endpoint {...};
>   };
> };
>
> I'll need to check, but dtc may need an update to not warn about this.

If the requirement that unit-address and the low #address-cells of reg
now being forced by a validation tool is screwing us over here, we can't
really change the tool; that's a IEEE 1275-1994 requirement we'd be
hacking around.

Here's a thought - why don't we define the ports in each component in a
separate graph? Describing the ATB topology as a bus with a graph structure
and then having the components simply reference the port nodes would make
it much easier to design.

Part of the problem is trying to describe an ATB bus via a component on
an APB bus. You lose all the niceties of describing a bus with bus
subcomponents. Lets take the ATB bus outside.. by describing the ingress
and egress of the component you have no idea where in the graph you are
at the point of entry (you could start parsing at a funnel, which means
travelling around looking for other units that match other compatibles).

If the CoreSight subsystem could have a graph pre-made of the full
topology, then the components can point to how they wrap parts of
that topology. You can also do away with ridiculous non-programmable
funnels and replicator nodes, since the trace graph would encapsulate
that information without having to instantiate a stub driver for it.

That doesn't solve 'unit' or 'unit-address' or 'reg' or anything but
it would keep us in graph bindings and abstract the ATB topology from
the components. Other fun stuff; describing bridge components and bus
widths within the graph could give abilities to describe bandwidths
over each trace path.

In any case, what happens when you have to decide what your funnel
port priorities are, you'll have to define a new property for that,
and it won't be 'reg'.

Trying not to add anything to the graph bindings is one thing but
trying to shoehorn it in either by doing that or inventing wholly
device-specific properties are just as bad.

Perhaps we can use the path at unit-address:arguments <-- parameters here to
add extra information about the port. 'my-args' would pull it out in Forth,
I don't know how FDT code deals with it (but there should be something,
since we use it for console definition in /chosen). They're entirely
specific to the node in question, but not used in path matching.

Why can't we decide on a graph-binding update that allows specifying
something simple as a demultiplexer output in a way the driver can
understand and map to the hardware?

> If DT bindings can be reused for ACPI, that's fine

However in my opinion not the preferred way to do it..

> any DT bindings to be accepted simply because they match ACPI
> bindings.

I'm sure ACPI has capability of a much classier way of describing
things, but I have some fear that it's just OF bindings stuffed in
a _DSD.. DT and ACPI have the responsibility of shouldering the
burden of describing hardware. Any attempts to try and make some
commonality to promote brevity of Linux code is totally out of scope..

You can always abstract whatever definition into whatever the Linux
drivers need at the time. That's kind of the point. Locking in to
'how it's currently coded' is stifling when realizing the first
attempt didn't actually adequately do what it was intended.

Ta,
Matt
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
