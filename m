From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 9 Apr 2016 00:05:22 +0200
Subject: 4.4 BCM5301X ARM regression "External imprecise Data abort"
In-Reply-To: <96f638d9-fa40-c599-b708-8a687569a016@broadcom.com>
References: <CACna6rz=KE_FtNtrSKmcYE514s4-dgrnx=iGbN7JDXkQPd6bTw@mail.gmail.com>
 <5702D7DD.2080205@broadcom.com> <5702DB4D.5070203@hauke-m.de>
 <CACna6rwVR3mBqHbxq-J3wPqOiajsxatAQfzH0hb1SYjc-cmx8w@mail.gmail.com>
 <1460104993.32099.18.camel@pengutronix.de>
 <96f638d9-fa40-c599-b708-8a687569a016@broadcom.com>
Message-ID: <CACna6rwfHzB=zP6GWbLFW5j9hXYGhgWCn+qRKmWHggsPT8frYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 April 2016 at 00:02, Ray Jui <ray.jui@broadcom.com> wrote:
> On 4/8/2016 1:43 AM, Lucas Stach wrote:
>>
>> Am Freitag, den 08.04.2016, 08:45 +0200 schrieb Rafa? Mi?ecki:
>>>
>>> On 4 April 2016 at 23:23, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>>>
>>>> On 04/04/2016 11:08 PM, Scott Branden wrote:
>>>>>
>>>>> On 16-04-03 11:13 PM, Rafa? Mi?ecki wrote:
>>>>>>
>>>>>> I got regression reports from Netgear R8000 (BCM4709A0) users and did
>>>>>> some testing & regression tracking with Aditya.
>>>>>>
>>>>>> It happens that Linux 4.4 doesn't boot due to the following commits:
>>>>>> bbeb920 ("ARM: 8422/1: enable imprecise aborts during early kernel
>>>>>> startup")
>>>>>> 9254970 ("ARM: 8447/1: catch pending imprecise abort on unmask")
>>>>>> 937b123 ("ARM: BCM5301X: remove workaround imprecise abort fault
>>>>>> handler")
>>>>>>
>>>>>> In kernel 4.3 we got that abort workaround which was resulting in:
>>>>>> [    5.007128] Freeing unused kernel memory: 212K (c0435000 -
>>>>>> c046a000)
>>>>>> [    5.694632] init: Console is alive
>>>>>> [    5.698169] init: - watchdog -
>>>>>> [    5.701470] External imprecise Data abort at addr=0x0, fsr=0x1406
>>>>>> ignored.
>>>>>> As you can see, this abort was happening soon after freeing unused
>>>>>> memory and ignoring it *once* did the trick. It was never appearing
>>>>>> again.
>>>>
>>>>
>>>> I assume it only can throw one of these and if it is deactivated it will
>>>> ignore the next one or overwrite it. So it could be that more than one
>>>> is thrown here.
>>>>
>>>>>> With 4.4 similar (or the same?) abort happens earlier (during PCI host
>>>>>> driver init) and doesn't get ignored:
>>>>>> [    2.478461] pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>> [    2.483451] pci 0000:00:00.0:   bridge window [mem
>>>>>> 0x08000000-0x085fffff]
>>>>>> [    2.599449] pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
>>>>>> [    2.605744] pci_bus 0001:00: root bus resource [mem
>>>>>> 0x40000000-0x47ffffff]
>>>>>> [    2.612657] pcie_iproc_bcma bcma0:8: link: UP
>>>>>> [    2.617241] PCI: bus0: Fast back to back transfers disabled
>>>>>> [    2.622845] pci 0001:00:00.0: bridge configuration invalid ([bus
>>>>>> 00-00]), reconfiguring
>>>>>> [    2.631297] PCI: bus1: Fast back to back transfers disabled
>>>>>> [    2.636887] pci 0001:01:00.0: bridge configuration invalid ([bus
>>>>>> 00-00]), reconfiguring
>>>>>> [    2.645035] Unhandled fault: imprecise external abort (0x1406) at
>>>>>> 0x00000000
>>>>>> (see 4.4.txt for the backtrace)
>>>>>>
>>>>>> At first I was hoping that we simply need to re-add the removed
>>>>>> workaround. I tried it but it appeared that one abort is immediately
>>>>>> followed by another:
>>>>>> [    2.936895] pci 0001:01:00.0: bridge configuration invalid ([bus
>>>>>> 00-00]), reconfiguring
>>>>>> [    2.945053] External imprecise Data abort at addr=0x0, fsr=0x1406
>>>>>> ignored.
>>>>>> [    2.951966] Unhandled fault: imprecise external abort (0x1406) at
>>>>>> 0x00000000
>>>>>>
>>>>>> So it seems that commits bbeb920 and 9254970 broke something in PCI
>>>>>> host initialization (or maybe just exposed another bug?). Instead of
>>>>>> getting an abort once and late we are getting now many of them and a
>>>>>> bit earlier.
>>>>
>>>>
>>>> These commits mad the kernel earlier "listen" to such errors, so that
>>>> they will be shown at the time they occur and not sometime later.
>>>
>>>
>>> So AFAIU with kernel 4.3:
>>> 1) Aborts were masked (silent) until "Freeing unused kernel memory"
>>> 2) There was one (silent) abort caused by a bootloader
>>> 3) There were likely multiple aborts (silent) during early PCI init
>>> 4) After unmasking we got only a single abort reported and we were
>>> ignoring it
>>>
>>> With kernel 4.4:
>>> 1) All aborts are reported immediately
>>> 2) Abort caused by a bootloader gets ignored by ARM code:
>>> "Hit pending asynchronous external abort (FSR=0x00001c06) during first
>>> unmask"
>>> thanks to 9254970 ("ARM: 8447/1: catch pending imprecise abort on
>>> unmask")
>>> 3) There are still multiple aborts during PCI init (reported immediately
>>> now)
>>> 4) To work as before (in 4.3) we should ignore all aborts, not only the
>>> 1st one
>>>
>>> Of course proposed solution is an ugly workaround, we should have no
>>> aborts reported in the first place.
>>>
>> A master abort on the PCI bus during probe of the PCI config space
>> (device enumeration) is expected. Most host bridges ignore those errors
>> and just return 0 for the read transaction.
>>
>> Some bridges forward the error onto the AXI/AMBA bus and thus cause
>> imprecise external aborts on the ARM core.
>
>
> Yes, I suspect this is the case for these imprecise external abort triggered
> by the iProc PCIe.
>
>> If your host bridge doesn't
>> have a way to disable error forwarding during PCI bus probe you need to
>> install an abort handler. Most implementations based on the designware
>> PCIe core do this already.
>
>
> Is this as simple as registering an abort handler to the hook in the iProc
> PCIe driver, and based on the fsr (0x1406 in our case), simply ignore the
> abort by returning zero from the abort handler?

This is what I did in OpenWrt an hour ago and it seems to be working:
http://git.openwrt.org/?p=openwrt.git;a=commitdiff;h=f823c5da71f0dd859facc5ece575a48c28279d35

-- 
Rafa?
