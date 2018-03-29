From: npcomplete13@gmail.com (Vivek Unune)
Date: Thu, 29 Mar 2018 18:16:12 -0400
Subject: [PATCH v2] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <20180309220530.nz2qkuipjqabus5h@osboxes>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20180302194155.50808-1-npcomplete13@gmail.com>
 <88e9d209-c45e-0e8f-53ce-4705d0b7e3c2@gmail.com>
 <20180309220530.nz2qkuipjqabus5h@osboxes>
Message-ID: <CAChtp77E=LfYdZ5Jv8kU1Enmw5qAWfFc4hgQWC2AMYVav4SU8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Fri, Mar 9, 2018 at 5:05 PM, Vivek Unune <npcomplete13@gmail.com> wrote:
>> > +
>> > +           port at 5 {
>> > +                   reg = <5>;
>> > +                   ethernet = <&gmac0>;
>> > +                   label = "cpu";
>> > +
>> > +                   fixed-link {
>> > +                           speed = <1000>;
>> > +                           full-duplex;
>> > +                   };
>> > +           };
>> > +
>> > +           port at 7 {
>> > +                   reg = <7>;
>> > +                   ethernet = <&gmac1>;
>> > +                   label = "cpu";
>> > +
>> > +                   fixed-link {
>> > +                           speed = <1000>;
>> > +                           full-duplex;
>> > +                   };
>> > +           };
>> > +
>> > +           port at 8 {
>> > +                   reg = <8>;
>> > +                   ethernet = <&gmac2>;
>> > +                   label = "cpu";
>> > +
>> > +                   fixed-link {
>> > +                           speed = <1000>;
>> > +                           full-duplex;
>> > +                   };
>> > +           };
>>
>> None of this is wrong, but DSA effectively will take the first port
>> specified with a "cpu" label and declare it as the one and only CPU port
>> it supports. If the architecture on Northstar is similar to what is done
>> on Northstar Plus, port 5 can be either internal or external PHY, port 7
>> is indeed gmac1, and port 8 is connected to the flow accelerator, which
>> should be in "bypass" mode by default. We can always change that later
>> on if we have to anyway.
>
> From what I understand from the source is that gmac0 and gmac1 in NorthStar
> are connected to FA while gmac2 is connected to port8
> Although I could be completely wrong :)
>
> Snippet from GPL source [1]:
>
>  * A typical GMAC configuration is:
>  *   GMAC#0 - port#5 - fwd0 <---> wl0 (radio 0) on CPU core0
>  *   GMAC#1 - port#7 - fwd1 <---> wl1 (radio 1) on CPU core1
>  *
>  *   GMAC#2 - port#8 - eth0 <--- vlan1 ---> br0
>
> Note: EA9500 has three radios, fwd0 is connected to even numbered radios
> While odd numbered radios are connected to fwd1. Also, fw0,fw1 and eth0
> listed above are devices created by the factory firmware.

Correction: Port 5 and port 7 act as forwarders and are not connected to
flow accelerator. And you are right, port 8 is connected to flow accelerator.
Although, it seems it is not enabled in Linksys factory firmware.

Some more excerpt from GPL source:

 * Northstar router includes 3 GMAC ports from the integrated switch to the Host
 * (single or dual core) CPU. The integrated switch provides advanced ethernet
 * hardware switching functions, similar to that of a Linux software bridge.
 * In Northstar, this integrated HW switch is responsible for bridging packets
 * between the 4 LAN ports. All LAN ports are seen by the ethernet network
 * device driver as a single "vlan1" interface. This single vlan1 interface
 * represents the collection of physical LAN ports on the switch, without
 * having to create a seperate interface per LAN port and  adding each one of
 * these LAN interfaces to the default Linux software LAN bridge "br0".
 * The hardware switch allows the LAN ports to be segregated into multiple
 * bridges using VLAN (Independent VLAN Learning Mode). Again, each subset of
 * physical LAN ports are represented by a single interface, namely "vlanX".
 *
 * The 3 GMAC configuration treats the primary WLAN interface as just another
 * LAN interface (albeit with a WLAN 802.11 MAC as opposed to an Ethernet 802.3
 * MAC). Two of the three GMACs are dedicated for binding the primary WLAN
 * interfaces to the HW switch which performs the LAN to WLAN bridging function.
 * These two GMACs are referred to as Forwarding GMACs.
 * The third GMAC is used to connect the switch to the Linux router network
 * stack, by making all LAN and WLAN ports appear as a single vlan1 interface
 * that is added to the software Linux bridge "br0". This GMAC is referred to
 * as the Networking GMAC.
 *
 * Similar to LAN to WAN routing, where LAN originated packets would be flooded
 * to the WAN port via the br0, likewise, WLAN originated packets would re-enter
 * Linux network stack via the 3rd GMAC. Software Cut-Through-Forwarding CTF
 * will accelerate WLAN <-> WAN traffic. When the hardware Flow Accelerator is
 * enabled, WLAN <-> WAN traffic need not re-enter the host CPU, other than the
 * first few packets that are needed to establish the flows in the FA, post
 * DPI or Security related flow classification functions.
