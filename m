From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Dec 2012 20:50:48 -0800
Subject: [RFC] gate clock binding and descriptiveness of bindings
Message-ID: <50CFF628.4010208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'd like to propose a binding for gate clocks so that we can discuss how
descriptive devicetree clock bindings should be.

Binding for simple gate clocks.

This binding uses the common clock binding[1].

[1] Documentation/devicetree/bindings/clock/clock-bindings.txt

Required properties:
- compatible : shall be "gate-clock"
- #clock-cells : from common clock binding; shall be set to 0
- reg : shall be register containing bit to toggle to gate/ungate the clock
- enable-bit : shall be bit in register to set/clear to toggle the gate

Optional properties:
- clock-output-names : from common clock binding
- clocks : shall be the input parent clock which is gated by this clock.
- set-to-disable: if present, indicates bit must be set to disable the clock

Example:
        gate {
                compatible = "gate-clock";
                #clock-cells = <0>;
                reg = <0x45 0x4>;
                enable-bit = <1>;
                clocks = <&osc>
        };

This seems to capture what the gate clock needs, minus the spinlock
which can't come from DT.

Some starter questions:

1) Should we have two compatible strings, one for the "set-to-disable"
clocks and one for the "set-to-enable" clocks instead of having a
property "set-to-disable"?

2) Should we specify the enable bit as a property or should that be
handled by software? I.e. is it too descriptive to specify the bits
within a register that do something?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
