From: npcomplete13@gmail.com (Vivek Unune)
Date: Mon, 14 Aug 2017 00:44:53 -0400
Subject: [PATCH] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <CAChtp77nD-dUCytja6PM3fAqXLCVshHqN-hV6pp6ues0PQcaOA@mail.gmail.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20170315185214.GF21021@lunn.ch>
 <CAChtp75xk3LN1-DPVvaHT5qEvrdoFFvXEk-daVCcJ=4rYu_vmw@mail.gmail.com>
 <7f5ddeba-6f79-9de5-2c67-a77e6bec0ef9@broadcom.com>
 <CAChtp75mzHkSg4rVh602vaMotqs6NtaPOD4383Gef8tVPO37FQ@mail.gmail.com>
 <2e4ed52f-4134-9b6a-18c9-7c1f28cd7038@broadcom.com>
 <CAChtp76sbKjxq03ipSDJN69XeJRU-0aRTeJ75+gCXZfo4D5r0A@mail.gmail.com>
 <03ba6198-a2cc-da9f-7d7d-f626d53d5717@gmail.com>
 <CAChtp77nD-dUCytja6PM3fAqXLCVshHqN-hV6pp6ues0PQcaOA@mail.gmail.com>
Message-ID: <CAChtp745Ho-=DQCTgFawA_c40Syupn9geGr5SBZjQaz6NvJgxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian,

On Thu, Jun 29, 2017 at 5:04 PM, Vivek Unune <npcomplete13@gmail.com> wrote:
> Florian,
>
>>> I have managed to use DSA driver and was able detect both internal and
>>> external switches. However, I only get packets flowing only through the
>>> internal switch. I have used the ip & bridge commands to setup the vlan
>>> 101 & 102 for lan and wan respectively.
>>>
>>> VLAN101 = lan1 lan2 lan3 lan4 lan5 lan6 lan7 lan8 eth0.101
>>
>> That looks reasonable although keep in mind that the IMP/CPU interfaces
>> of the switch are configured with VLAN tags (see commit [1]), so you may
>> need to make sure that port 0 of the internal switch is not accidentally
>> configured back to untagged since that would cause problem when
>> terminating the VLAN tag on the SW side.
>>
>> So here are a few things that you want to check:
>>
>> - read the MIB counters from the "extswitch" interface and see if
>> packets flow through in both directions with no errors
>
> lan4 is on internal switch, lan1 on external. I cannot ping router from lan1
>
> Inter-    |   Receive                |  Transmit
>  face     |bytes    packets errs drop|bytes    packets errs drop
> br-lan:      168590    1726    0    0   190542     753    0    0
> extswitch:        0       0    0    0   101012    1221    0    0
>   lan1:           0       0    0    0     5382     111    0    0
>   lan4:           0       0    0    0  1306680   13909    0    0
>   eth0:     3276924    5539    0    0  1106135    5084    0    0
> eth0.101:    169338    1732    0    0   190256     750    0    0
> eth0.102:   2959522    3274    0    0   587248    1094    0    0
>     lo:       39390     502    0    0    39390     502    0    0
> br-wan:     2956822    3254    0    0   587248    1094    0    0
>

Please ignore above mib counters. I noticed that I see lot of RxFCSErrors
and RxSymbolErrors for extswitch. The count for both counters always
remain same.

root at LEDE:/# ethtool -S extswitch
NIC statistics:
     tx_packets: 212
     tx_bytes: 19179
     rx_packets: 0
     rx_bytes: 0
     TxOctets: 14403
     TxDropPkts: 0
     TxBroadcastPkts: 24
     TxMulticastPkts: 122
     TxUnicastPkts: 0
     TxCollisions: 0
     TxSingleCollision: 0
     TxMultipleCollision: 0
     TxDeferredTransmit: 0
     TxLateCollision: 0
     TxExcessiveCollision: 0
     TxPausePkts: 0
     RxOctets: 3593
     RxUndersizePkts: 0
     RxPausePkts: 0
     Pkts64Octets: 0
     Pkts65to127Octets: 36
     Pkts128to255Octets: 1
     Pkts256to511Octets: 0
     Pkts512to1023Octets: 0
     Pkts1024to1522Octets: 0
     RxOversizePkts: 0
     RxJabbers: 0
     RxAlignmentErrors: 0
     RxFCSErrors: 37
     RxGoodOctets: 0
     RxDropPkts: 0
     RxUnicastPkts: 0
     RxMulticastPkts: 0
     RxBroadcastPkts: 0
     RxSAChanges: 0
     RxFragments: 0
     RxJumboPkts: 0
     RxSymbolErrors: 37
     RxDiscarded: 0
     p08_TxOctets: 47537
     p08_TxDropPkts: 0
     p08_TxBroadcastPkts: 163
     p08_TxMulticastPkts: 319
     p08_TxUnicastPkts: 0
     p08_TxCollisions: 0
     p08_TxSingleCollision: 0
     p08_TxMultipleCollision: 0
     p08_TxDeferredTransmit: 0
     p08_TxLateCollision: 0
     p08_TxExcessiveCollision: 0
     p08_TxPausePkts: 0
     p08_RxOctets: 14403
     p08_RxUndersizePkts: 0
     p08_RxPausePkts: 0
     p08_Pkts64Octets: 25
     p08_Pkts65to127Octets: 102
     p08_Pkts128to255Octets: 17
     p08_Pkts256to511Octets: 2
     p08_Pkts512to1023Octets: 0
     p08_Pkts1024to1522Octets: 0
     p08_RxOversizePkts: 0
     p08_RxJabbers: 0
     p08_RxAlignmentErrors: 0
     p08_RxFCSErrors: 0
     p08_RxGoodOctets: 14403
     p08_RxDropPkts: 0
     p08_RxUnicastPkts: 0
     p08_RxMulticastPkts: 122
     p08_RxBroadcastPkts: 24
     p08_RxSAChanges: 40
     p08_RxFragments: 0
     p08_RxJumboPkts: 0
     p08_RxSymbolErrors: 0
     p08_RxDiscarded: 146


>>
>> - check the "extswitch" VLAN configuration on both the internal switch
>> side (port 0) and on the external switch side ("cpu", port 8, not visible)
>
> #bridge vlan show
> port    vlan ids
> extswitch       None
> extswitch
> lan7     101 PVID Egress Untagged
> lan7     101 PVID Egress Untagged
> lan4     101 PVID Egress Untagged
> lan4     101 PVID Egress Untagged
> lan8     101 PVID Egress Untagged
> lan8     101 PVID Egress Untagged
> wan      102 PVID Egress Untagged
> wan      102 PVID Egress Untagged
> lan1     101 PVID Egress Untagged
> lan1     101 PVID Egress Untagged
> lan5     101 PVID Egress Untagged
> lan5     101 PVID Egress Untagged
> lan2     101 PVID Egress Untagged
> lan2     101 PVID Egress Untagged
> lan6     101 PVID Egress Untagged
> lan6     101 PVID Egress Untagged
> lan3     101 PVID Egress Untagged
> lan3     101 PVID Egress Untagged
> br-lan  None
> eth0.101         101 PVID Egress Untagged
> eth0.101
> br-wan  None
> eth0.102         102 PVID Egress Untagged
> eth0.102
>
>>
>> - see if you can get traffic end-to-end from eth0 all the way through
>> one of the external switch port. If that's the case, that means that the
>> configuration of internal switch port 0, internal switch CPU port, and
>> external switch external port is working and operational
>>
>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e47112d9d6009bf6b7438cedc0270316d6b0370d
>>
>>> VLAN102 = wan eth0.102
>>>
>>> Reading configs from the factory firmware, I'm sure that sw0port0 and> sw1port8 are connected. Excerpt from the same:
>>>
>>> port_numbers=0 2 4 2 1 3 1 3
>>> port_switch_id=1 1 1 0 1 1 0 0
>>> port_names=port0 port1 port2 port3 port4 port5 port6 port7
>>
>> Is 0 the identifier for the external or internal switch? If 0 is
>> internal switch identifier and 1 is the external switch identifier, your
>> mapping looks correct to me with one exception below:
>
> 0 is internal here.
>
>>
>>> cpu_port_number=5 7 8
>>> cpu_port_switch_id=0 0 0
>>> hidden_port_numbers=0 8
>>> hidden_port_switch_id=0 1
>>>
>>> Below is my updated device tree.
>>>
>>> Thanks,
>>>
>>> Vivek
>>>
>>> &srab {
>>>     compatible = "brcm,bcm53012-srab", "brcm,bcm5301x-srab";
>>>     status = "okay";
>>>     dsa,member = <0 0>;
>>>
>>>     ports {
>>>         #address-cells = <1>;
>>>         #size-cells = <0>;
>>>
>>>         port at 1 {
>>>             reg = <1>;
>>>             label = "lan7";
>>>         };
>>>
>>>         port at 2 {
>>>             reg = <2>;
>>>             label = "lan4";
>>>         };
>>>
>>>         port at 3 {
>>>             reg = <3>;
>>>             label = "lan8";
>>>         };
>>>
>>>         port at 4 {
>>>             reg = <4>;
>>>             label = "wan";
>>>         };
>>>
>>>         port at 5 {
>>>             reg = <5>;
>>>             ethernet = <&gmac0>;
>>>             label = "cpu";
>>>
>>>             fixed-link {
>>>
>>>                 speed = <1000>;
>>>                 full-duplex;
>>>             };
>>>         };
>>
>> I think this is meant to be port 8 here based on the hidden_port_number
>> value. This actually matters for VLAN configuration because B53 is not
>> (unfortunately, to be fixed) consistently using dst->cpu_port (whatever
>> is configured in Device Tree) vs. dev->cpu_port (hardcoded to 8 for this
>> class of switch).
>
> When I connect to port 8 I receive no packets on internal switch.

I'm able to now use sw0port8 <-> eth2 (i.e use cpu port 8 to connect to gmac2).
For this I had to modify net/dsa/b53/b53_common.c (see below). This is how
it is setup in net/phy/b53/b53_common.c. Also need to set
cpu_port = B53_CPU_PORT for 53012 sw instead of B53_CPU_PORT_25

@@ -357,9 +357,11 @@ static void b53_enable_vlan(struct b53_d
  b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL5, &vc5);
  }

- mgmt &= ~SM_SW_FWD_MODE;

  if (enable) {
+
+ mgmt |= SM_SW_FWD_MODE;
+
  vc0 |= VC0_VLAN_EN | VC0_VID_CHK_EN | VC0_VID_HASH_VID;
  vc1 |= VC1_RX_MCST_UNTAG_EN | VC1_RX_MCST_FWD_EN;
  vc4 &= ~VC4_ING_VID_CHECK_MASK;

>
>>
>> PS: on that front, we will have to rework that when we bring multiple
>> CPU port support in DSA/B53/bcm_sf2 and so for now what we could do is
>> just check that the configured CPU port in Device Tree is a valid CPU
>> port for that switch (typically 5, 7 or 8), and if not, just issue a
>> warning.
>>
>>>
>>>         sw0port0: port at 0 {
>>>             reg = <0>;
>>>             label = "extswitch";
>>>
>>>             fixed-link {
>>>                 speed = <1000>;
>>>                 full-duplex;
>>>             };
>>
>> There might be some additional configuration needed here for this port,
>> because by default, the port will most likely try to use its built-in
>> PHY and maybe that's what they did, they wired the built-in PHY directly
>> to the IMP port of the external switch.
>
> Do you know what that configuration might be?

Given that I see RxFCSErrors and RxSymbolErrors errors wrt extswitch.
configuration definitely needs tweaking. I tried setting the phy-mode to
rgmii and rgmii-txid but no go.

Thanks,

Vivek
