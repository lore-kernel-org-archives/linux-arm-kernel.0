From: npcomplete13@gmail.com (Vivek Unune)
Date: Thu, 29 Jun 2017 17:04:43 -0400
Subject: [PATCH] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <03ba6198-a2cc-da9f-7d7d-f626d53d5717@gmail.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20170315185214.GF21021@lunn.ch>
 <CAChtp75xk3LN1-DPVvaHT5qEvrdoFFvXEk-daVCcJ=4rYu_vmw@mail.gmail.com>
 <7f5ddeba-6f79-9de5-2c67-a77e6bec0ef9@broadcom.com>
 <CAChtp75mzHkSg4rVh602vaMotqs6NtaPOD4383Gef8tVPO37FQ@mail.gmail.com>
 <2e4ed52f-4134-9b6a-18c9-7c1f28cd7038@broadcom.com>
 <CAChtp76sbKjxq03ipSDJN69XeJRU-0aRTeJ75+gCXZfo4D5r0A@mail.gmail.com>
 <03ba6198-a2cc-da9f-7d7d-f626d53d5717@gmail.com>
Message-ID: <CAChtp77nD-dUCytja6PM3fAqXLCVshHqN-hV6pp6ues0PQcaOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian,

>> I have managed to use DSA driver and was able detect both internal and
>> external switches. However, I only get packets flowing only through the
>> internal switch. I have used the ip & bridge commands to setup the vlan
>> 101 & 102 for lan and wan respectively.
>>
>> VLAN101 = lan1 lan2 lan3 lan4 lan5 lan6 lan7 lan8 eth0.101
>
> That looks reasonable although keep in mind that the IMP/CPU interfaces
> of the switch are configured with VLAN tags (see commit [1]), so you may
> need to make sure that port 0 of the internal switch is not accidentally
> configured back to untagged since that would cause problem when
> terminating the VLAN tag on the SW side.
>
> So here are a few things that you want to check:
>
> - read the MIB counters from the "extswitch" interface and see if
> packets flow through in both directions with no errors

lan4 is on internal switch, lan1 on external. I cannot ping router from lan1

Inter-    |   Receive                |  Transmit
 face     |bytes    packets errs drop|bytes    packets errs drop
br-lan:      168590    1726    0    0   190542     753    0    0
extswitch:        0       0    0    0   101012    1221    0    0
  lan1:           0       0    0    0     5382     111    0    0
  lan4:           0       0    0    0  1306680   13909    0    0
  eth0:     3276924    5539    0    0  1106135    5084    0    0
eth0.101:    169338    1732    0    0   190256     750    0    0
eth0.102:   2959522    3274    0    0   587248    1094    0    0
    lo:       39390     502    0    0    39390     502    0    0
br-wan:     2956822    3254    0    0   587248    1094    0    0

>
> - check the "extswitch" VLAN configuration on both the internal switch
> side (port 0) and on the external switch side ("cpu", port 8, not visible)

#bridge vlan show
port    vlan ids
extswitch       None
extswitch
lan7     101 PVID Egress Untagged
lan7     101 PVID Egress Untagged
lan4     101 PVID Egress Untagged
lan4     101 PVID Egress Untagged
lan8     101 PVID Egress Untagged
lan8     101 PVID Egress Untagged
wan      102 PVID Egress Untagged
wan      102 PVID Egress Untagged
lan1     101 PVID Egress Untagged
lan1     101 PVID Egress Untagged
lan5     101 PVID Egress Untagged
lan5     101 PVID Egress Untagged
lan2     101 PVID Egress Untagged
lan2     101 PVID Egress Untagged
lan6     101 PVID Egress Untagged
lan6     101 PVID Egress Untagged
lan3     101 PVID Egress Untagged
lan3     101 PVID Egress Untagged
br-lan  None
eth0.101         101 PVID Egress Untagged
eth0.101
br-wan  None
eth0.102         102 PVID Egress Untagged
eth0.102

>
> - see if you can get traffic end-to-end from eth0 all the way through
> one of the external switch port. If that's the case, that means that the
> configuration of internal switch port 0, internal switch CPU port, and
> external switch external port is working and operational
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e47112d9d6009bf6b7438cedc0270316d6b0370d
>
>> VLAN102 = wan eth0.102
>>
>> Reading configs from the factory firmware, I'm sure that sw0port0 and> sw1port8 are connected. Excerpt from the same:
>>
>> port_numbers=0 2 4 2 1 3 1 3
>> port_switch_id=1 1 1 0 1 1 0 0
>> port_names=port0 port1 port2 port3 port4 port5 port6 port7
>
> Is 0 the identifier for the external or internal switch? If 0 is
> internal switch identifier and 1 is the external switch identifier, your
> mapping looks correct to me with one exception below:

0 is internal here.

>
>> cpu_port_number=5 7 8
>> cpu_port_switch_id=0 0 0
>> hidden_port_numbers=0 8
>> hidden_port_switch_id=0 1
>>
>> Below is my updated device tree.
>>
>> Thanks,
>>
>> Vivek
>>
>> &srab {
>>     compatible = "brcm,bcm53012-srab", "brcm,bcm5301x-srab";
>>     status = "okay";
>>     dsa,member = <0 0>;
>>
>>     ports {
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>>
>>         port at 1 {
>>             reg = <1>;
>>             label = "lan7";
>>         };
>>
>>         port at 2 {
>>             reg = <2>;
>>             label = "lan4";
>>         };
>>
>>         port at 3 {
>>             reg = <3>;
>>             label = "lan8";
>>         };
>>
>>         port at 4 {
>>             reg = <4>;
>>             label = "wan";
>>         };
>>
>>         port at 5 {
>>             reg = <5>;
>>             ethernet = <&gmac0>;
>>             label = "cpu";
>>
>>             fixed-link {
>>
>>                 speed = <1000>;
>>                 full-duplex;
>>             };
>>         };
>
> I think this is meant to be port 8 here based on the hidden_port_number
> value. This actually matters for VLAN configuration because B53 is not
> (unfortunately, to be fixed) consistently using dst->cpu_port (whatever
> is configured in Device Tree) vs. dev->cpu_port (hardcoded to 8 for this
> class of switch).

When I connect to port 8 I receive no packets on internal switch.

>
> PS: on that front, we will have to rework that when we bring multiple
> CPU port support in DSA/B53/bcm_sf2 and so for now what we could do is
> just check that the configured CPU port in Device Tree is a valid CPU
> port for that switch (typically 5, 7 or 8), and if not, just issue a
> warning.
>
>>
>>         sw0port0: port at 0 {
>>             reg = <0>;
>>             label = "extswitch";
>>
>>             fixed-link {
>>                 speed = <1000>;
>>                 full-duplex;
>>             };
>
> There might be some additional configuration needed here for this port,
> because by default, the port will most likely try to use its built-in
> PHY and maybe that's what they did, they wired the built-in PHY directly
> to the IMP port of the external switch.

Do you know what that configuration might be?

Thanks,

Vivek
