From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 20 May 2014 11:17:25 -0600
Subject: [PATCH v1 5/5] pci: keystone: add pcie driver based on designware
 core driver
In-Reply-To: <4769015.Y4xoyoQxYb@wuerfel>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <5671513.YgJm44AVLV@wuerfel> <537A735A.9070607@ti.com>
 <4769015.Y4xoyoQxYb@wuerfel>
Message-ID: <CAErSpo5iehwoDAuETCxCEHHj1_0jHCJUnn+wj1OUAn6PpxbtyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 1:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 19 May 2014 17:10:50 Murali Karicheri wrote:

>> On ARM, by default pci_bus_config seems to be set to 0
>> (PCIE_BUS_TUNE_OFF). So the code doesn't get
>> executed for this default. But for PCIE_BUS_SAFE, it doesn't change the
>> mrrs at the EP and is not
>> good for our platform w.r.t mrrs settings. For PCIE_BUS_PERFORMANCE, it
>> seems to increase the payload
>> size as well and Keystone Payload size is limited to 128 bytes. So it is
>> not safe to increase the payload
>> size to 256 based on the log.
>>
>> On other platforms, Why the PCI core try to set the payload size equal
>> to mrrs? Is this explained in any
>> PCI spec?  Looks like this is done for performance? Let me know if you
>> want me to send a patch for
>> review to add the pcie_bus_configure_settings() code to
>> arch/arm/kernel/bios32.c
>>
>> For the Keystone PCI driver, I believe. it is safe to have the quirk so
>> that controller can handle the
>> read requests properly. Let me know if the quirk code above looks good
>> to go.
>
> I don't know enough about these to give you a definite answer, but
> I'd still prefer to handle this in generic code. A quirk seems to
> be the wrong answer here. If this isn't something we can do in generic
> fashion, can you do it in the add_bus() callback perhaps?

I definitely prefer a more generic approach than a quirk.
Unfortunately the MPS management was implemented originally just for
x86, not because there's anything arch-specific about it, but because
the author was only concerned about x86.  Making that more generic has
been an open issue all along.

Bjorn
