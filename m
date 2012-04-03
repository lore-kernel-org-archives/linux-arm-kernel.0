From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 3 Apr 2012 10:44:39 -0600
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <201204031426.22652.arnd@arndb.de>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <201204030819.48798.arnd@arndb.de> <4F7AFF61.3070803@windriver.com>
 <201204031426.22652.arnd@arndb.de>
Message-ID: <CAErSpo5RiDgfXHB30rOTco6CjhH4Nzovhvddifk9i=tb4QKtNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2012 at 8:26 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 03 April 2012, Paul Gortmaker wrote:
>> I'm not sure I'm following you here. I'm not feeding the
>> struct pci_sys_data to pci_add_resource_offset. ?Instead it
>> is getting subfields of it, consistent with the rest of the
>> original commit from Bjorn.
>
> Sorry, my fault, I thought the suggestion was to pass sys into
> pci_add_resource_offset.
>
> However, I would still prefer just reverting the versatile
> part of Bjorn's patch because versatile uses a zero offset.
> I think we should only pass the offset in cases where it's
> actually required because there are multiple buses or they
> have interesting mappings to the physical address space.

I used pci_add_resource_offset() on *all* arm platforms because the
offsets are defined in struct pci_sys_data, which is not specific to
any platform type, and I thought it was easier and more future-proof
to pay attention to those offsets.

I was also thinking that the actual pci_add_resource_offset() calls
and the request_resource() or allocate_resource() calls usually found
near them in the arm .setup() functions are really not
platform-specific, so it might make sense to float them up into
something like pcibios_init_hw() someday.

But if you prefer to use the offset only for platforms that actually
assign non-zero values to the pci_sys_data offsets, that's fine with
me.

Since this only affects arm, do you want to handle the fix entirely in
the arm tree?  If you want me to push something through PCI, I can do
that, too.  Sorry for the breakage.

Bjorn
