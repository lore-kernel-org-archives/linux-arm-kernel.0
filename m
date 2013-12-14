From: bhelgaas@google.com (Bjorn Helgaas)
Date: Sat, 14 Dec 2013 13:18:23 -0700
Subject: Memory mapping of config space of pcie devices
In-Reply-To: <CAHH3p5J7Se8zu64MfoSDkAN_NtOp=qv1DcvWBAa8jWKouo0TXg@mail.gmail.com>
References: <CAHH3p5+3Zy+YkgDS_1bJ7B84w5iHOh6-QG7LRJXo2WQHREcRHw@mail.gmail.com>
 <CAErSpo59htYoPBoouUfSXAVXwCUQPK-TB_zG0BkE-PLhV=KRbQ@mail.gmail.com>
 <CAHH3p5J7Se8zu64MfoSDkAN_NtOp=qv1DcvWBAa8jWKouo0TXg@mail.gmail.com>
Message-ID: <CAErSpo5k1KZuaL7jYp1-5YaxjdZseDPrFo64mJcb2tu2PWJowA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc devicetree, linux-arm-kernel]

On Sat, Dec 14, 2013 at 1:05 PM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> On Sun, Dec 15, 2013 at 12:29 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Sat, Dec 14, 2013 at 11:32 AM, shiv prakash Agarwal
>> <chhotu.shiv@gmail.com> wrote:
>>> Hi All,
>>>
>>> How devices config spaces are mapped to host memory?
>>> Is it being handled by core driver? I could not locate.
>>
>> The PCI core does not map config space into memory.  That's not even
>> possible for the legacy config access methods, e.g., using I/O ports
>> 0xcf8 and 0xcfc [1].
>>
>> If you're wondering about how Linux uses ECAM, that's mostly in
>> arch/x86/pci/mmconfig*.  That code does ioremap the ECAM area into
>> kernel virtual space, but only for access via pci_read_config_word(),
>> pci_write_config_word(), etc.
>>
>> Bjorn
>>
>> [1] http://en.wikipedia.org/wiki/PCI_configuration_space#Software_implementation
>
> Thanks Bjorn for quick reply,
>
> Above reference says:
> During system initialization, firmware determines the base address for
> this ?stolen? address region and communicates it to the root complex
> and to the operating system. This communication method is
> implementation-specific, and not defined in the PCI Express
> specification.
>
> How above is implemented on ARM?

On x86, we learn the ECAM address via ACPI (the MCFG table or a host
bridge _CBA method).  I don't know how this is done on ARM.  I could
imagine it being done via device tree, but I really don't know.
Unfortunately both the address discovery and the actual ECAM accesses
are in arch-specific code.

Bjorn
