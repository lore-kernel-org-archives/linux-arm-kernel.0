From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 21 Jan 2015 16:32:41 +0100
Subject: [PATCH 3/5] PCI: st: Provide support for the sti PCIe controller
In-Reply-To: <20150112184349.GB2776@google.com>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1418812486-12394-4-git-send-email-gabriel.fernandez@linaro.org>
 <20150112184349.GB2776@google.com>
Message-ID: <CAG374jB6HEUmA3MmB+uY1fxhLPE_4AjgG5z29X=S+rb5vuArtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn Helgaas,

On 12 January 2015 at 19:43, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Dec 17, 2014 at 11:34:44AM +0100, Gabriel FERNANDEZ wrote:
>> sti pcie is built around a Synopsis Designware PCIe IP.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> ---
>>  drivers/pci/host/Kconfig  |   5 +
>>  drivers/pci/host/Makefile |   1 +
>>  drivers/pci/host/pci-st.c | 713 ++++++++++++++++++++++++++++++++++++++++++++++
>
> Hi Gabriel,
>
> Can you add a MAINTAINERS update so I know who should ack changes to this
> driver?

yes no problem

>
>>  3 files changed, 719 insertions(+)
>>  create mode 100644 drivers/pci/host/pci-st.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index c4b6568..999d2b9 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -102,4 +102,9 @@ config PCI_LAYERSCAPE
>>       help
>>         Say Y here if you want PCIe controller support on Layerscape SoCs.
>>
>> +config PCI_ST
>> +     bool "ST STiH41x PCIe controller"
>> +     depends on ARCH_STI
>> +     select PCIE_DW
>
> Please add help text here.
>

okay

>> +static int st_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>> +                              unsigned int devfn, int where, int size,
>> +                              u32 *val)
>> +{
>> +     u32 data;
>> +     u32 bdf;
>> +     struct st_pcie *pcie = to_st_pcie(pp);
>> +     int is_root_bus = pci_is_root_bus(bus);
>> +     int retry_count = 0;
>> +     int ret;
>> +     void __iomem *addr;
>> +
>> +     /*
>> +      * Prerequisite
>> +      * PCI express devices will respond to all config type 0 cycles, since
>> +      * they are point to point links. Thus to avoid probing for multiple
>> +      * devices on the root, dw-pcie already check for us if it is on the
>> +      * root bus / other slots. Also, dw-pcie checks for the link being up
>> +      * as we will hang if we issue a config request and the link is down.
>> +      * A switch will reject requests for slots it knows do not exist.
>> +      */
>> +     bdf = bdf_num(bus->number, devfn, is_root_bus);
>> +     addr = pcie->config_area + config_addr(where,
>> +                     bus->parent->number == pp->root_bus_nr);
>> +retry:
>> +     /* Set the config packet devfn */
>> +     writel_relaxed(bdf, pp->dbi_base + FUNC0_BDF_NUM);
>> +     readl_relaxed(pp->dbi_base + FUNC0_BDF_NUM);
>> +
>> +     ret = dw_pcie_cfg_read(addr, where, size, &data);
>> +
>> +     /*
>> +      * This is intended to help with when we are probing the bus. The
>> +      * problem is that the wrapper logic doesn't have any way to
>> +      * interrogate if the configuration request failed or not.
>> +      * On the ARM we actually get a real bus error.
>> +      *
>> +      * Unfortunately this means it is impossible to tell the difference
>> +      * between when a device doesn't exist (the switch will return a UR
>> +      * completion) or the device does exist but isn't yet ready to accept
>> +      * configuration requests (the device will return a CRS completion)
>
> We do have CRS support in the Linux PCI core, so I guess this comment means
> that the ST host bridge doesn't handle CRS correctly?
>

yes, it is.

>> +      *
>> +      * The result of this is that we will miss devices when probing.
>> +      *
>> +      * So if we are trying to read the dev/vendor id on devfn 0 and we
>> +      * appear to get zero back, then we retry the request.  We know that
>> +      * zero can never be a valid device/vendor id. The specification says
>> +      * we must retry for up to a second before we decide the device is
>> +      * dead. If we are still dead then we assume there is nothing there and
>> +      * return ~0
>> +      *
>> +      * The downside of this is that we incur a delay of 1s for every pci
>> +      * express link that doesn't have a device connected.
>
> That sounds pretty bad and I assume is a consequence of CRS handling being
> broken in hardware.
>
>> +      */
>> +     if (((where & ~3) == 0) && devfn == 0 && (data == 0 || data == ~0)) {
>> +             if (retry_count++ < 1000) {
>> +                     mdelay(1);
>> +                     goto retry;
>> +             } else {
>> +                     *val = ~0;
>> +                     return PCIBIOS_DEVICE_NOT_FOUND;
>> +             }
>> +     }
>> +
>> +     *val = data;
>> +     return ret;
>> +}
>
>> +MODULE_LICENSE("GPLv2");
>
> See license_is_gpl_compatible().  This string needs to be "GPL v2", not
> "GPLv2" to avoid tainting the kernel.
>

okay

> Bjorn


Thanks for reviewing

BR

Gabriel
