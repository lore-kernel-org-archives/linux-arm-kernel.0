From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 30 Sep 2014 13:53:06 -0600
Subject: [PATCH] of/pci: add pci_pio_to_address dummy for !CONFIG_OF
In-Reply-To: <20140930171002.GB15854@bart.dudau.co.uk>
References: <706416181.hbVGLDA3o6@wuerfel> <20140930160139.GA5625@google.com>
 <20140930171002.GB15854@bart.dudau.co.uk>
Message-ID: <CAErSpo61favodLTSwCYzFZq-sB60+ZH6_WvwSGHgRx6cPKtXpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 11:10 AM, Liviu Dudau <liviu@dudau.co.uk> wrote:
> On Tue, Sep 30, 2014 at 10:01:39AM -0600, Bjorn Helgaas wrote:
>> On Tue, Sep 30, 2014 at 03:19:05PM +0200, Arnd Bergmann wrote:
>> > The pci_register_io_range() and pci_pio_to_address() were recently
>> > introduced to generalize the handling of memory mapped PCI I/O space,
>> > but they are only valid when CONFIG_OF is set, leading to a possible
>> > build error:
>> >
>> > drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_setup_window':
>> > drivers/pci/host/pcie-rcar.c:340:3: error: implicit declaration of function 'pci_pio_to_address' [-Werror=implicit-function-declaration]
>> >    res_start = pci_pio_to_address(res->start);
>> >    ^
>> > drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_probe':
>> > drivers/pci/host/pcie-rcar.c:945:3: error: implicit declaration of function 'of_pci_range_to_resource' [-Werror=implicit-function-declaration]
>> >    err = of_pci_range_to_resource(&range, pdev->dev.of_node,
>> >    ^
>> > cc1: some warnings being treated as errors
>> >
>> > This provides inline dummy implementations for the case that
>> > CONFIG_OF is disabled, to allow better build testing.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > Fixes: 279c5dd046 ("of/pci: Add pci_register_io_range() and pci_pio_to_address()")
>>
>> I'm rebuilding the pci/host-generic branch to pick up the other v13 fixes,
>> so I folded this fix directly into the "of/pci: Add pci_register_io_range()
>> and pci_pio_to_address()" patch.  Thanks for finding this; the config
>> dependencies are a bit of a mess.
>
> Bjorn,
>
> I suggest splitting this patch into 2 parts, move the one that adds pci_pio_to_address() in patch 2
> and the other in patch 5.

Yeah, I screwed that up.  I had just applied Arnd's patch completely
to 279c5dd046, which doesn't quite make sense.

I tried again like this:

  - In "of/pci: Add pci_register_io_range() and pci_pio_to_address()",
I added the dummy pci_pio_to_address(), so there's an extern and a
definition in address.c when CONFIG_OF_ADDRESS=y, and an inline dummy
otherwise.

  - I dropped "of/pci: Define of_pci_range_to_resource() only when
CONFIG_PCI=y".

  - In "of/pci: Move of_pci_range_to_resource() to of/address.c", I
added the dummy of_pci_range_to_resource(), so there's an extern an a
definition in address.c when CONFIG_OF_ADDRESS=y and CONFIG_PCI=y, and
an inline dummy otherwise.

I'm not really set up to build test this, and my head is swimming a
bit, so I hope this is it.  I pushed the pci/host-generic branch
again, so you can look at it yourself.

Bjorn
