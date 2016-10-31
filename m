From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 31 Oct 2016 14:46:28 -0700
Subject: [PATCH] ARM: BCM5301X: Add back handler ignoring external
 imprecise aborts
In-Reply-To: <fb2c36cb-6f85-1a6d-160a-c50e22d6c46b@gmail.com>
References: <20161029111229.26875-1-zajec5@gmail.com>
 <a491509e-5cfc-fc7d-0011-dfcab3c884ea@broadcom.com>
 <6e252703-0010-83ae-fa14-57352add007a@hauke-m.de>
 <fb2c36cb-6f85-1a6d-160a-c50e22d6c46b@gmail.com>
Message-ID: <dcb21fe4-672f-4545-5b47-d764f390e741@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16-10-31 02:01 PM, Florian Fainelli wrote:
> On 10/31/2016 01:59 PM, Hauke Mehrtens wrote:
>>
>>
>> On 10/31/2016 07:08 PM, Scott Branden wrote:
>>> Hi Rafal,
>>>
>>>
>>> On 16-10-29 04:12 AM, Rafa? Mi?ecki wrote:
>>>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>>>
>>>> Since early BCM5301X days we got abort handler that was removed by
>>>> commit 937b12306ea79 ("ARM: BCM5301X: remove workaround imprecise abort
>>>> fault handler"). It assumed we need to deal only with pending aborts
>>>> left by the bootloader. Unfortunately this isn't true for BCM5301X.
>>>>
>>>> When probing PCI config space (device enumeration) it is expected to
>>>> have master aborts on the PCI bus. Most bridges don't forward (or they
>>>> allow disabling it) these errors onto the AXI/AMBA bus but not the
>>>> Northstar (BCM5301X) one.
>>> Should we only add this workaround code if CONFIG_PCI is on then?
>>
>> I think all the supported northstar devices have a PCIe controller. We
>> could add such a CONFIG_PCI check, but I do not see a big advantage.
>
> Actually, I do see a couple disadvantages if we gate this with
> CONFIG_PCI: if this problem shows up irrespective of your kernel
> configuration, you want the error handler to clear it, not rely on
> CONFIG_PCI to be enabled for the error to go away and also, without an
> additional ifdef, additional compiler coverage.
>
A problem with reintroducing this change is that all imprecise data 
aborts are ignored, not just PCI.  So if you don't actually use PCI in 
your system and want to debug other aborts you are unable to.  I don't 
know if we care about such situation.
