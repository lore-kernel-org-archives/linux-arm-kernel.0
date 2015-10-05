From: lho@apm.com (Loc Ho)
Date: Mon, 5 Oct 2015 13:41:58 -0700
Subject: [PATCH RFC] apei: xgene: Add ACPI APEI support for X-Gene
In-Reply-To: <20151002075411.GB16538@pd.tnic>
References: <1443747112-24814-1-git-send-email-lho@apm.com>
 <20151002075411.GB16538@pd.tnic>
Message-ID: <CAPw-ZTn5stnEobMH018oLPn3nDO1uweVeVs=Otg3-6cXBWLz6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

>> Add ACPI APEI support for X-Gene platform. This patch requires [1] to
>> configiure and build.
>>
>> [1] http://marc.info/?l=linux-kernel&m=143955588312730&w=2
>>
>> Signed-off-by: Tuan Phan <tphan@apm.com>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> ---
>>  drivers/edac/Kconfig      |    7 +++
>>  drivers/edac/Makefile     |    2 +
>>  drivers/edac/xgene_apei.c |  120 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 129 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/edac/xgene_apei.c
>>
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index ef25000..f489852 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -390,4 +390,11 @@ config EDAC_XGENE
>>         Support for error detection and correction on the
>>         APM X-Gene family of SOCs.
>>
>> +config EDAC_XGENE_APEI
>> +     tristate "APM X-Gene SoC APEI"
>> +     depends on ACPI_APEI && (ARM64 || COMPILE_TEST)
>> +     help
>> +       APEI interface support for error detection and correction on the
>> +       APM X-Gene family of SOCs.
>> +
>>  endif # EDAC
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
>> index dbf53e0..27dbae1 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -70,3 +70,5 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)               += octeon_edac-pci.o
>>  obj-$(CONFIG_EDAC_ALTERA_MC)         += altera_edac.o
>>  obj-$(CONFIG_EDAC_SYNOPSYS)          += synopsys_edac.o
>>  obj-$(CONFIG_EDAC_XGENE)             += xgene_edac.o
>> +obj-$(CONFIG_EDAC_XGENE_APEI)                += xgene_apei.o
>> +
>> diff --git a/drivers/edac/xgene_apei.c b/drivers/edac/xgene_apei.c
>> new file mode 100644
>> index 0000000..6ec416f
>> --- /dev/null
>> +++ b/drivers/edac/xgene_apei.c
>> @@ -0,0 +1,120 @@
>> +/*
>> + * AppliedMicro X-Gene APEI Driver
>> + *
>> + * Copyright (c) 2015, Applied Micro Circuits Corporation
>> + * Author: Tuan Phan <tphan@apm.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + *
>> + * This driver provides the interrupt hook up with the UEFI FW for the X-Gene
>> + * SoC processor under the following conditions:
>> + *
>> + * 1. No interrupt GPIO available or don't want to use one and no EL3 support
>> + * 2. With EL3 support, but no mean to interrupt the Linux OS that an event
>> + *    has occurred.
>
> Why is this an x-gene-specific driver and not a generic, APEI one, like
> ghes_edac? I'd like to see a single ARM64 APEI/GHES/whatever driver
> which is programmed against the spec - no vendor-specific stuff. And I
> don't see anything vendor-specific below except xgene_apei_acpi_match
> which can be part of the generic driver.
>

Yes... We can make this generic. The only non-generic is the way the
interrupt is cleared. As of right now, the method of clearing the
interrupt is by writing back the same value as read. This would be
fine for most. But to ensure 100% coverage, would an AML method be
better or needed?

-Loc
