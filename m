From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 3 Apr 2012 09:47:13 -0400
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <201204030819.48798.arnd@arndb.de>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLpim2TCMO5nDVNe0bdm9ZQ+czUWNpxxWugDzrHO6aYVAQ@mail.gmail.com>
 <CAOMZO5A-+tcz6ewTykXL33opRVP9U4o7Ltdkbr7LLqWMBQczSQ@mail.gmail.com>
 <201204030819.48798.arnd@arndb.de>
Message-ID: <4F7AFF61.3070803@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Bjorn Helgaas to CC; I overlooked doing that earlier]

On 12-04-03 04:19 AM, Arnd Bergmann wrote:
> On Tuesday 03 April 2012, Fabio Estevam wrote:
>> On Mon, Apr 2, 2012 at 10:01 PM, Paul Gortmaker
>> <paul.gortmaker@windriver.com> wrote:
>>
>>> I see.  Well, there weren't any follow ups to it but I would say that
>>> passing both sys->resources and sys both side-by-side at the same
>>> time doesn't really make sense.  I think just passing in sys by itself
>>> as I did is a cleaner way to go, wouldn't you agree?
>>
>> Yes, I agree.
> 
> But that doesn't work: struct pci_sys_data is ARM specific, while
> pci_add_resource_offset is common code.

I'm not sure I'm following you here. I'm not feeding the
struct pci_sys_data to pci_add_resource_offset.  Instead it
is getting subfields of it, consistent with the rest of the
original commit from Bjorn.

-	pci_add_resource_offset(resources, &io_mem, sys->io_offset);
-	pci_add_resource_offset(resources, &non_mem, sys->mem_offset);
-	pci_add_resource_offset(resources, &pre_mem, sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &io_mem, sys->io_offset);
+	pci_add_resource_offset(&sys->resources, &non_mem, sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &pre_mem, sys->mem_offset);

As a side note, the fact that struct pci_sys_data is ARM specific
does make one think it would be nice if the name somehow did
reflect that...  wonder if it is worth changing.  Anyway, that is
a separate topic.

Thanks,
Paul.
--

> 
> I think it would be much more sensible here to just use pci_add_resource(),
> which is the same as the offsets are all zero for versatile.
> 
> 	Arnd
