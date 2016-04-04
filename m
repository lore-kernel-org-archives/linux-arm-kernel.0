From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Mon, 4 Apr 2016 23:23:25 +0200
Subject: 4.4 BCM5301X ARM regression "External imprecise Data abort"
In-Reply-To: <5702D7DD.2080205@broadcom.com>
References: <CACna6rz=KE_FtNtrSKmcYE514s4-dgrnx=iGbN7JDXkQPd6bTw@mail.gmail.com>
 <5702D7DD.2080205@broadcom.com>
Message-ID: <5702DB4D.5070203@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafal,

On 04/04/2016 11:08 PM, Scott Branden wrote:
> Hi Rafal,
> 
> I do not work on BCM5301x SoCs but perhaps Jon Mason can comment.
> A few comments inline as well.
> 
> On 16-04-03 11:13 PM, Rafa? Mi?ecki wrote:
>> Hi guys,
>>
>> I got regression reports from Netgear R8000 (BCM4709A0) users and did
>> some testing & regression tracking with Aditya.
>>
>> It happens that Linux 4.4 doesn't boot due to the following commits:
>> bbeb920 ("ARM: 8422/1: enable imprecise aborts during early kernel
>> startup")
>> 9254970 ("ARM: 8447/1: catch pending imprecise abort on unmask")
>> 937b123 ("ARM: BCM5301X: remove workaround imprecise abort fault
>> handler")
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

I assume it only can throw one of these and if it is deactivated it will
ignore the next one or overwrite it. So it could be that more than one
is thrown here.

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

These commits mad the kernel earlier "listen" to such errors, so that
they will be shown at the time they occur and not sometime later.

> We do not observe such issues in Cygnus and other SoCs that use this
> PCIe driver (we do not use bcma either - I do not know if that is related).
>>
>> Reverting all three commits from the top of 4.4.6 gives me back a
>> working & booting kernel.
>>
>> Do you have any idea how to fix this regression (and hopefully
>> original problem as well)?
> I think the proper fix is to correct the issues in the bootloader.  It
> was my understanding from Jon Mason that this is the root of the
> original problem.
>>

I think this is a new problem.

In the Broadcom SDK was a comment saying that probably the bootloader is
broken and that causes this fault which was worked around in the
mainline kernel with the fault handler in the brcm code.

When I added the code Arnd asked me if this SoC has a PCIe controller
because he saw such a problem on an other SoC with a PCIe controller.
https://www.spinics.net/lists/arm-kernel/msg298112.html

As this is now happening in the PCIe code I assume that this has
something to do with PCIe. ;-)

Have you tried to deactivate PCIe support in Device tree and see what
happens? Have you tried to load the PCIe controller as a module later on
so if that makes a difference?

Hauke
