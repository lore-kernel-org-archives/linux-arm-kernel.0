From: npcomplete13@gmail.com (Vivek Unune)
Date: Sat, 19 Aug 2017 17:30:25 -0400
Subject: [PATCH] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <f49561fd-9227-1506-9b5c-c6e6130ba168@gmail.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20170315185214.GF21021@lunn.ch>
 <CAChtp75xk3LN1-DPVvaHT5qEvrdoFFvXEk-daVCcJ=4rYu_vmw@mail.gmail.com>
 <7f5ddeba-6f79-9de5-2c67-a77e6bec0ef9@broadcom.com>
 <CAChtp75mzHkSg4rVh602vaMotqs6NtaPOD4383Gef8tVPO37FQ@mail.gmail.com>
 <2e4ed52f-4134-9b6a-18c9-7c1f28cd7038@broadcom.com>
 <CAChtp76sbKjxq03ipSDJN69XeJRU-0aRTeJ75+gCXZfo4D5r0A@mail.gmail.com>
 <03ba6198-a2cc-da9f-7d7d-f626d53d5717@gmail.com>
 <CAChtp77nD-dUCytja6PM3fAqXLCVshHqN-hV6pp6ues0PQcaOA@mail.gmail.com>
 <CAChtp745Ho-=DQCTgFawA_c40Syupn9geGr5SBZjQaz6NvJgxQ@mail.gmail.com>
 <f49561fd-9227-1506-9b5c-c6e6130ba168@gmail.com>
Message-ID: <CAChtp74jBaBgFMh0Y5Wnj_2H=1NXqzBiF=Hc_w8Dr2x+Zad2KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 12:37 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Please ignore above mib counters. I noticed that I see lot of RxFCSErrors
>> and RxSymbolErrors for extswitch. The count for both counters always
>> remain same.
>
> Yes that is not exactly good, it means that the RGMII interface between
> the internal and external switches is not properly configured.

It appears that I do not need to set any phy-mode on internal sw's
port 0 or external sw's port 8. Also, you were right about internal port 0 to
be configured as tagged member of the vlan. It was indeed set to untagged!
LEDE lacks aw way to configure this. But I can do this via a post script.

After making above changes I was able to ping the router using physical port on
external switch. However, the ping dies out after few seconds. I'm try to figure
out the cause for this. Al least, I have some connectivity!

>
>>
>> root at LEDE:/# ethtool -S extswitch
>> NIC statistics:
>>      tx_packets: 212
>>      tx_bytes: 19179
>>      rx_packets: 0
>>      rx_bytes: 0
>>      TxOctets: 14403
>>      TxDropPkts: 0
>>      TxBroadcastPkts: 24
>>      TxMulticastPkts: 122
>>      TxUnicastPkts: 0
>>      TxCollisions: 0
>>      TxSingleCollision: 0
>>      TxMultipleCollision: 0
>>      TxDeferredTransmit: 0
>>      TxLateCollision: 0
>>      TxExcessiveCollision: 0
>>      TxPausePkts: 0
>>      RxOctets: 3593
>>      RxUndersizePkts: 0
>>      RxPausePkts: 0
>>      Pkts64Octets: 0
>>      Pkts65to127Octets: 36
>>      Pkts128to255Octets: 1
>>      Pkts256to511Octets: 0
>>      Pkts512to1023Octets: 0
>>      Pkts1024to1522Octets: 0
>>      RxOversizePkts: 0
>>      RxJabbers: 0
>>      RxAlignmentErrors: 0
>>      RxFCSErrors: 37
>>      RxGoodOctets: 0
>>      RxDropPkts: 0
>>      RxUnicastPkts: 0
>>      RxMulticastPkts: 0
>>      RxBroadcastPkts: 0
>>      RxSAChanges: 0
>>      RxFragments: 0
>>      RxJumboPkts: 0
>>      RxSymbolErrors: 37
>>      RxDiscarded: 0
>>      p08_TxOctets: 47537
>>      p08_TxDropPkts: 0
>>      p08_TxBroadcastPkts: 163
>>      p08_TxMulticastPkts: 319
>>      p08_TxUnicastPkts: 0
>>      p08_TxCollisions: 0
>>      p08_TxSingleCollision: 0
>>      p08_TxMultipleCollision: 0
>>      p08_TxDeferredTransmit: 0
>>      p08_TxLateCollision: 0
>>      p08_TxExcessiveCollision: 0
>>      p08_TxPausePkts: 0
>>      p08_RxOctets: 14403
>>      p08_RxUndersizePkts: 0
>>      p08_RxPausePkts: 0
>>      p08_Pkts64Octets: 25
>>      p08_Pkts65to127Octets: 102
>>      p08_Pkts128to255Octets: 17
>>      p08_Pkts256to511Octets: 2
>>      p08_Pkts512to1023Octets: 0
>>      p08_Pkts1024to1522Octets: 0
>>      p08_RxOversizePkts: 0
>>      p08_RxJabbers: 0
>>      p08_RxAlignmentErrors: 0
>>      p08_RxFCSErrors: 0
>>      p08_RxGoodOctets: 14403
>>      p08_RxDropPkts: 0
>>      p08_RxUnicastPkts: 0
>>      p08_RxMulticastPkts: 122
>>      p08_RxBroadcastPkts: 24
>>      p08_RxSAChanges: 40
>>      p08_RxFragments: 0
>>      p08_RxJumboPkts: 0
>>      p08_RxSymbolErrors: 0
>>      p08_RxDiscarded: 146
>>
>>
>>
>> I'm able to now use sw0port8 <-> eth2 (i.e use cpu port 8 to connect to gmac2).
>> For this I had to modify net/dsa/b53/b53_common.c (see below). This is how
>> it is setup in net/phy/b53/b53_common.c. Also need to set
>> cpu_port = B53_CPU_PORT for 53012 sw instead of B53_CPU_PORT_25
>
> I actually plan to remove the use cpu_port entirely, or actually only
> use it as a "hint" of which CPU ports are capable of supporting Broadcom
> tags. A better change for now would be not to use dev->cpu_port, but
> instead use ds->dst->cpu_dp->index like what b53_br_join() does.

This will be quite helpful as current implementation creates some confusion
when there are more than one cpu ports.

>
>>
>> @@ -357,9 +357,11 @@ static void b53_enable_vlan(struct b53_d
>>   b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL5, &vc5);
>>   }
>>
>> - mgmt &= ~SM_SW_FWD_MODE;
>>
>>   if (enable) {
>> +
>> + mgmt |= SM_SW_FWD_MODE;
>> +
>
> Humm, that I don't really understand because this is turning on managed
> mode which only influences how multicast addresses are processed, it
> should not make a different for non-MC traffic AFAICT.

I tried to remove setting of SM_SW_FWD_MODE but no go. Even GPL source
sets it for 53012. For now I'll leave it until I get back to it.

> Configuration may have to be tuned on both switches unfortunately
> because both RGMII interfaces would have the ability to configure
> delays. Do you have a way to dump what the original firmware settings
> for the register that b53_adjust_link() modifies such that we can see
> what was previous configured?
>
> Thanks!
> --
> Florian

Thanks for your time!!

Vivek
