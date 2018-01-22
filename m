From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 22 Jan 2018 14:00:37 +0100
Subject: [net-next: PATCH v4 0/7] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180118132322.GE2690@kwain>
References: <1516278704-17141-1-git-send-email-mw@semihalf.com>
 <20180118132322.GE2690@kwain>
Message-ID: <CAPv3WKeqEd6Hcy0NdPpiVVA1ioUYY4zs_0zai2gwkCPtM1yaJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

There's a discussion about the ACPI vs generic MDIO/PHY change under
initial version of the patchset, however the patches in question were
for now abandoned from further re-sends.

As the v4 has had no objections until now and:
- patches 1-2 were Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
- mvpp2 patches (5-7) were Tested-by: Antoine Tenart
<antoine.tenart@free-electrons.com>
- entire series was  Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
Do you see any chance that it lands in net-next before the coming
merge window? It would be really much appreciated.

Thanks,
Marcin


2018-01-18 14:23 GMT+01:00 Antoine Tenart <antoine.tenart@free-electrons.com>:
> Hi Marcin,
>
> I tested the series on a MacchiatoBin to ensure the mvpp2 DT support was
> still working. I was able to use all supported ports as before, and saw
> no issue.
>
> For all mvpp2 patches, you can add:
>
> Tested-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>
> Thanks!
> Antoine
>
> On Thu, Jan 18, 2018 at 01:31:37PM +0100, Marcin Wojtas wrote:
>> Hi,
>>
>> I quickly resend the series, thanks to Antoine Tenart's remark,
>> who spotted !CONFIG_ACPI compilation issue after introducing
>> the new fwnode_irq_get() routine. Please see the details in the changelog
>> below and the 3/7 commit log.
>>
>> mvpp2 driver can work with the ACPI representation, as exposed
>> on a public branch:
>> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/marvell-armada-wip
>> It was compiled together with the most recent Tianocore EDK2 revision.
>> Please refer to the firmware build instruction on MacchiatoBin board:
>> http://wiki.macchiatobin.net/tiki-index.php?page=Build+from+source+-+UEFI+EDK+II
>>
>> ACPI representation of PP2 controllers (withouth PHY support) can
>> be viewed in the github:
>> * MacchiatoBin:
>> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/71ae395da1661374b0f07d1602afb1eee56e9794/Platforms/Marvell/Armada/AcpiTables/Armada80x0McBin/Dsdt.asl#L201
>>
>> * Armada 7040 DB:
>> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/71ae395da1661374b0f07d1602afb1eee56e9794/Platforms/Marvell/Armada/AcpiTables/Armada70x0/Dsdt.asl#L131
>>
>> I will appreciate any comments or remarks.
>>
>> Best regards,
>> Marcin
>>
>> Changelog:
>> v3 -> v4:
>> * 3/7
>>     - add new macro (ACPI_HANDLE_FWNODE) and fix
>>       compilation with !CONFIG_ACPI
>>     - extend commit log and mention usability of fwnode_irq_get
>>       for the child nodes as well
>>
>> v2 -> v3:
>> * 1/7, 2/7
>>     - Add Rafael's Acked-by's
>> * 3/7, 4/7
>>     - New patches
>> * 6/7, 7/7
>>     - Update driver with new helper routines usage
>>     - Improve commit log.
>>
>> v1 -> v2:
>> * Remove MDIO patches
>> * Use PP2 ports only with link interrupts
>> * Release second region resources in mvpp2 driver (code moved from
>>   mvmdio), as explained in details in 5/5 commit message.
>>
>> Marcin Wojtas (7):
>>   device property: Introduce fwnode_get_mac_address()
>>   device property: Introduce fwnode_get_phy_mode()
>>   device property: Introduce fwnode_irq_get()
>>   device property: Allow iterating over available child fwnodes
>>   net: mvpp2: simplify maintaining enabled ports' list
>>   net: mvpp2: use device_*/fwnode_* APIs instead of of_*
>>   net: mvpp2: enable ACPI support in the driver
>>
>>  drivers/base/property.c              | 104 ++++++++--
>>  drivers/net/ethernet/marvell/mvpp2.c | 206 ++++++++++++--------
>>  include/linux/acpi.h                 |   3 +
>>  include/linux/property.h             |  11 ++
>>  4 files changed, 232 insertions(+), 92 deletions(-)
>>
>> --
>> 2.7.4
>>
>
> --
> Antoine T?nart, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
