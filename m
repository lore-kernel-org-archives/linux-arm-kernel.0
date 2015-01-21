From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 21 Jan 2015 16:49:39 +0100
Subject: [PATCH 5/5] PCI: st: disable IO support
In-Reply-To: <20141217140131.607a1ac7@lxorguk.ukuu.org.uk>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1418812486-12394-6-git-send-email-gabriel.fernandez@linaro.org>
 <20141217140131.607a1ac7@lxorguk.ukuu.org.uk>
Message-ID: <CAG374jD3Y_y1Ugt0Y7_j9kz66yUCx8PPNLkkpWBdpVPMxnoC8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Yes, we don't really care about this corner case.
Thanks for your reviewing.

BR

Gabriel

On 17 December 2014 at 15:01, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
> On Wed, 17 Dec 2014 11:34:46 +0100
> Gabriel FERNANDEZ <gabriel.fernandez@st.com> wrote:
>
>> sti SoCs PCIe IPs are built around DesignWare IP Core.
>> But in these SoCs, PCIe IP doesn't support IO.
>> By default, when no IO space is provided, a default one is assigned.
>>
>> Add an empty IO resource to the bus, and disable IO by default.
>
> As a point of PCI pedantry I don't think this is quite sufficient. PCI
> has a weird corner case where I/O resources are implied rather than
> allocated.
>
> For IDE/SATA you may need to something like
>
>         if (class == PCI_CLASS_STORAGE_IDE) {
>                 u8 progif;
>                 pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
>                 progif |= 5;
>                 pci_write_config_byte(dev, PCI_CLASS_PROG, &progif);
>         }
>
> so that any adapter is kicked out of legacy mode and doesn't get implied
> I/O resources and interrupts. I don't know if that case matters for your
> usage.
>
>
