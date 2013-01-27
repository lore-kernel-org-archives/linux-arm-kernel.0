From: yinghai@kernel.org (Yinghai Lu)
Date: Sun, 27 Jan 2013 10:22:10 -0800
Subject: [PATCH v2 16/22] PCI, arm: Kill pci_root_buses
In-Reply-To: <20130127173816.GH23505@n2100.arm.linux.org.uk>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
 <1359265003-16166-1-git-send-email-yinghai@kernel.org>
 <1359265003-16166-17-git-send-email-yinghai@kernel.org>
 <20130127173816.GH23505@n2100.arm.linux.org.uk>
Message-ID: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 9:38 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jan 26, 2013 at 09:36:37PM -0800, Yinghai Lu wrote:
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-arm-kernel at lists.infradead.org
>
> So... what's this about.  This email is all I've recieved, and the only
> thing that I have to go on is one single subject line and not description
> about what's going on.  I guess there's some other patch introducing this
> for_each_pci_host_bridge() macro somewhere?  I guess that's part of this
> patch set?

yes.

sorry for not put you in the cc list of the whole patchset. will do
that next reversion.

>
> Yet... I guess you want an ack for this or something... which would be
> irresponsible to give without knowing the purpose behind this, the
> reasoning, or even being able to tell whether the replacement code is
> functionally equivalent.

the purpose is to make iteration for root bus to be root-bus
hotplug safe.

will update change log.

>
> So, no ack (or nack) at the moment.
>
>> ---
>>  arch/arm/kernel/bios32.c |    9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
>> index 9b72261..d0befe4 100644
>> --- a/arch/arm/kernel/bios32.c
>> +++ b/arch/arm/kernel/bios32.c
>> @@ -57,13 +57,10 @@ static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, in
>>
>>  void pcibios_report_status(u_int status_mask, int warn)
>>  {
>> -     struct list_head *l;
>> +     struct pci_host_bridge *host_bridge = NULL;
>>
>> -     list_for_each(l, &pci_root_buses) {
>> -             struct pci_bus *bus = pci_bus_b(l);
>> -
>> -             pcibios_bus_report_status(bus, status_mask, warn);
>> -     }
>> +     for_each_pci_host_bridge(host_bridge)
>> +             pcibios_bus_report_status(host_bridge->bus, status_mask, warn);
>>  }
>>
>>  /*
>> --
>> 1.7.10.4
>>
