From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 2 Jun 2011 09:40:05 -0600
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <4DE403C5.7060003@firmworks.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
	<4DE336A1.5040509@firmworks.com>
	<20110530070138.GA5036@opensource.wolfsonmicro.com>
	<8d2515b13c817cc956b185d043bcef00@kernel.crashing.org>
	<BANLkTi=hkScxYpt449CQCky+bLU3UvkC_A@mail.gmail.com>
	<4DE403C5.7060003@firmworks.com>
Message-ID: <BANLkTikyDmPiSWFh2yemsz3Uk6UWu0Fksw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 2:53 PM, Mitch Bradley <wmb@firmworks.com> wrote:
> Perhaps the interrupt-mapping binding is not the best model. ?Interrupt
> hardware in general is hierarchical but is not isomorphic to the physical
> addressing hierarchy of the device tree.
>
> GPIOs share the need to "point across the tree to different nodes", but it
> is unclear that there is a need for a entirely different hierarchy.
>
> That suggests the possibility of using the device tree addressing mechanism
> as much as possible. ?Normal device tree addresses could be used to specify
> GPIO numbers.
>
> Suppose we have:
>
> ? ? ? ?gpio-controller1: gpio-controller {
> ? ? ? ? ? ? ? ?#address-cells = <2>;
> ? ? ? ? ? ? ? ?#mode-cells = <2>;
> ? ? ? ? ? ? ? ?gpio1: gpio at 12,0 {
> ? ? ? ? ? ? ? ? ? ?reg = <12 0>;
> ? ? ? ? ? ? ? ? ? ?mode = <55 66>;
> ? ? ? ? ? ? ? ? ? ?usage = "Audio Codec chip select"; ?/* Optional */
> ? ? ? ? ? ? ? ?}
> ? ? ? ?};
> ? ? ? ?gpio-controller2: gpio-controller {
> ? ? ? ? ? ? ? ? #address-cells = <1>;
> ? ? ? ? ? ? ? ? #mode-cells = <1>;
> ? ? ? ? ? ? ? ? gpio2: gpio at 4 {
> ? ? ? ? ? ? ? ? ? ? reg = <4>;
> ? ? ? ? ? ? ? ? ? ? #mode-cells = <1>;
> ? ? ? ? ? ? ? ? }
> ? ? ? ?};
> ? ? ? ?[...]
> ? ? ? ?chipsel-gpio = ?<&gpio1>,
> ? ? ? ? ? ? ? ? ? ? ? ?<&gpio-controller1 13 0 55 77>,
> ? ? ? ? ? ? ? ? ? ? ? ?<0>, /* holes are permitted, means no GPIO 2 */
> ? ? ? ? ? ? ? ? ? ? ? ?<&gpio2 88>,
> ? ? ? ? ? ? ? ? ? ? ? ?<&gpio-controller2 5 1>;
>
>
> A GPIO spec consist of:
>
> 1) A reference to either a gpio-controller or a gpio device node.
>
> 2) 0 or more address cells, according to the value of #address-cells in the
> referenced node. ?If the node has no #address-cells property, the value is
> assumed to be 0.
>
> 3) 0 or more mode cells, according to the value of #mode-cells in the
> referenced node.

I can see having nodes for individual gpios being useful in
circumstances, but I really don't like having multiple methods of
specifying a gpio (handle to the gpio-controller, or a handle to the
gpio node, and a different specifier depending on the contents of the
target node).  I think it will be less confusing for users if the
reference is always to the gpio controller.  A specific gpio
controller can still use child nodes to capture extra information
about specific gpios, but doing so doesn't need to be exposed to a
gpio consumer; it can all be internal to the gpio controller and its
hardware specific binding (since any mode details are going to be
hardware specific anyway most likely).

[Amending to the above which was written before you latest post: even
with the refined proposal to link to only a child node, the gpio
specifier still changes depending on the contents of the child node]

If a gpio controller does use child nodes, then I do like the approach
of using #{address,size}-cells to line up with gpio numbering.
However, we've already got a definition of #gpio-cells in use which
specifies the total number of cells for a '*-gpio' property binding,
so I do want to take care not to conflict with the existing pattern.
I suspect the solution would simply be to state that #gpio-cells >=
#address-cells must be true.

> In the example, the chipsel-gpio specs are interpreted as:
>
> <&gpio1> ?- ?refers to a pre-bound gpio device node, in which the address
> (12 0) and mode (55 66) are specified within that node.
>
> <&gpio-controller1 13 0 55 77> ?- ?refers to a GPIO controller node,
> specifing the address (13 0) and the mode (55 77) in the client's GPIO spec.
>
> <gpio2> ?- ?another reference to a gpio node on a different controller. ?In
> this case the address (4) is bound in the gpio node, but the mode (88) is
> passed in from the client's GPIO spec.
>
> <&gpio-controller2 5 1> ?- ?another reference to a controller node, with a
> one-cell address (5) and a one-cell mode (1), according to the values of
> #address-cells and #mode-cells in that controller node.
>
> I expect that the "pre-bound gpio node" case would get a lot of use in
> practice, as it lets you isolate the client from the details of the
> interrupt controller addressing and modes. ?In my experience, GPIOs often
> get reassigned between revisions of the same board, especially early in the
> development cycle.

I'm not convinced that the pre-bound gpio node will be any better or
worse from a usability standpoint that direct references.  I've
certainly not had problems with keeping up with gpio moves (and
everything else moving) on the FPGA projects that I've worked with.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
