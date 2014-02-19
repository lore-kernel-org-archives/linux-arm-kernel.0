From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 19 Feb 2014 15:18:39 -0700
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <3351875.BO8J5k2cFs@wuerfel>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <3905203.TvF8RmfLsz@wuerfel>
 <CAErSpo7g5G0vn_8tyRE52MK6YuTB8XhBbk9thhzLx4tg0hmDMg@mail.gmail.com>
 <3351875.BO8J5k2cFs@wuerfel>
Message-ID: <CAErSpo6mBj=qKbkEOq0bBXp0ihRBnkaFdLQhF2vrNWW14hevPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 3:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 19 February 2014 14:33:54 Bjorn Helgaas wrote:
>> On Wed, Feb 19, 2014 at 1:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 19 February 2014 13:18:24 Bjorn Helgaas wrote:
>> >> >
>> >> > Right, this is an interesting case indeed, and I think we haven't
>> >> > considered it in the binding so far. We already encode a "bus-range"
>> >> > in DT, so we can easily partition the ECAM config space, but it
>> >> > still violates one of the two assumptions:
>> >> > a) that the register ranges for the two host bridge devices are
>> >> >    non-overlapping in DT
>> >> > b) that the ECAM register range as specified in DT starts at bus
>> >> >    0 and is a power-of-two size.
>> >> > Since the binding is not fixed that, we could change the definition to
>> >> > say that the ECAM register range in the "reg" property must match
>> >> > the buses listed in the "bus-range" property.
>> >>
>> >> Addresses in the ACPI MCFG table correspond to bus number 0, but the
>> >> MCFG also provides start & end bus numbers, so the valid range does
>> >> not necessarily start with bus 0 and need not be power-of-two in size.
>> >>  Something similar sounds like a good idea for DT.
>> >
>> > Hmm, we'll have to think about that. From a DT perspective, we try
>> > to keep things local to the node using it, so listing only the
>> > registers we are allowed to access is more natural.
>>
>> The combination of MCFG base address for bus 00 and the bus number
>> range from _CRS, plus the obvious offset computation does effectively
>> describe the registers you're allowed to access; it's just up to the
>> OS to compute the offsets.
>
> That's not what I meant. The 'reg' property is supposed to list the
> registers that are exclusively owned by the device. We normally
> expect that we want to request_mem_region() and ioremap() the entire
> range for each device, which doesn't make sense if we only want a
> small part of it, or if another device owns the same registers.

Oh, right, that makes good sense.  The ACPI approach means we have to
have special-case code for that; it can't be handled by
request_mem_region() in a generic _CRS parser.

Bjorn
