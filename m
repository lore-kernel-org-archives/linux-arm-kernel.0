From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 7 Apr 2016 20:48:26 +0200
Subject: 4.4 BCM5301X ARM regression "External imprecise Data abort"
In-Reply-To: <CAC3K-4pHw1YQbcD2pp3eaJp0o5OSO+Ft0B_0o1y6uRCJGxGhaw@mail.gmail.com>
References: <CACna6rz=KE_FtNtrSKmcYE514s4-dgrnx=iGbN7JDXkQPd6bTw@mail.gmail.com>
 <CAC3K-4pHw1YQbcD2pp3eaJp0o5OSO+Ft0B_0o1y6uRCJGxGhaw@mail.gmail.com>
Message-ID: <CACna6rzw9_AP6sfNkjeoOFtpb90oUCNDmJzx88Xtn2-oxnNSFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2016 at 23:10, Jon Mason <jon.mason@broadcom.com> wrote:
> On Mon, Apr 4, 2016 at 2:13 AM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>> I got regression reports from Netgear R8000 (BCM4709A0) users and did
>> some testing & regression tracking with Aditya.
>>
>> It happens that Linux 4.4 doesn't boot due to the following commits:
>> bbeb920 ("ARM: 8422/1: enable imprecise aborts during early kernel
>> startup")
>> 9254970 ("ARM: 8447/1: catch pending imprecise abort on unmask")
>> 937b123 ("ARM: BCM5301X: remove workaround imprecise abort fault handler")
>>
>> In kernel 4.3 we got that abort workaround which was resulting in:
>> [    5.007128] Freeing unused kernel memory: 212K (c0435000 - c046a000)
>> [    5.694632] init: Console is alive
>> [    5.698169] init: - watchdog -
>> [    5.701470] External imprecise Data abort at addr=0x0, fsr=0x1406
>> ignored.
>> As you can see, this abort was happening soon after freeing unused
>> memory and ignoring it *once* did the trick. It was never appearing
>> again.
>>
>> With 4.4 similar (or the same?) abort happens earlier (during PCI host
>> driver init) and doesn't get ignored:
>> [    2.478461] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [    2.483451] pci 0000:00:00.0:   bridge window [mem
>> 0x08000000-0x085fffff]
>> [    2.599449] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
>> [    2.605744] pci_bus 0001:00: root bus resource [mem
>> 0x40000000-0x47ffffff]
>> [    2.612657] pcie_iproc_bcma bcma0:8: link: UP
>> [    2.617241] PCI: bus0: Fast back to back transfers disabled
>> [    2.622845] pci 0001:00:00.0: bridge configuration invalid ([bus
>> 00-00]), reconfiguring
>> [    2.631297] PCI: bus1: Fast back to back transfers disabled
>> [    2.636887] pci 0001:01:00.0: bridge configuration invalid ([bus
>> 00-00]), reconfiguring
>> [    2.645035] Unhandled fault: imprecise external abort (0x1406) at
>> 0x00000000
>> (see 4.4.txt for the backtrace)
>>
>> At first I was hoping that we simply need to re-add the removed
>> workaround. I tried it but it appeared that one abort is immediately
>> followed by another:
>> [    2.936895] pci 0001:01:00.0: bridge configuration invalid ([bus
>> 00-00]), reconfiguring
>> [    2.945053] External imprecise Data abort at addr=0x0, fsr=0x1406
>> ignored.
>> [    2.951966] Unhandled fault: imprecise external abort (0x1406) at
>> 0x00000000
>>
>> So it seems that commits bbeb920 and 9254970 broke something in PCI
>> host initialization (or maybe just exposed another bug?). Instead of
>> getting an abort once and late we are getting now many of them and a
>> bit earlier.
>
> Do you know if the device causing it is a PCI multifunction device?

I don't know. What gets discovered on the first controller are two
devices: 14e4:d612 (kind of bridge I believe) and 14e4:4365 (wireless
with BCM4366).


> Can you try regressing the PCI host driver and isolate that?

What do you mean by regressing PCI host driver?

-- 
Rafa?
