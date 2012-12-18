From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 18 Dec 2012 12:30:01 -1000
Subject: [RFC] gate clock binding and descriptiveness of bindings
In-Reply-To: <50CFF628.4010208@codeaurora.org>
References: <50CFF628.4010208@codeaurora.org>
Message-ID: <50D0EE69.1050905@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 6:50 PM, Stephen Boyd wrote:
> Hi,
> 
> I'd like to propose a binding for gate clocks so that we can discuss how
> descriptive devicetree clock bindings should be.
> 
> Binding for simple gate clocks.
> 
> This binding uses the common clock binding[1].
> 
> [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> 
> Required properties:
> - compatible : shall be "gate-clock"
> - #clock-cells : from common clock binding; shall be set to 0
> - reg : shall be register containing bit to toggle to gate/ungate the clock
> - enable-bit : shall be bit in register to set/clear to toggle the gate
> 
> Optional properties:
> - clock-output-names : from common clock binding
> - clocks : shall be the input parent clock which is gated by this clock.
> - set-to-disable: if present, indicates bit must be set to disable the clock
> 
> Example:
>         gate {
>                 compatible = "gate-clock";
>                 #clock-cells = <0>;
>                 reg = <0x45 0x4>;
>                 enable-bit = <1>;
>                 clocks = <&osc>
>         };
> 
> This seems to capture what the gate clock needs, minus the spinlock
> which can't come from DT.
> 
> Some starter questions:
> 
> 1) Should we have two compatible strings, one for the "set-to-disable"
> clocks and one for the "set-to-enable" clocks instead of having a
> property "set-to-disable"?

I would say no, based on the fact that it is very likely that there will
be a single driver.

> 
> 2) Should we specify the enable bit as a property or should that be
> handled by software? I.e. is it too descriptive to specify the bits
> within a register that do something?

If you want to parameterize it down to the register level, you probably
also need to express the register access size.  For ARM, it will nearly
always be 32 bits, but other architectures sometimes use other access
sizes.

> 
