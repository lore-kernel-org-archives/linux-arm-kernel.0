From: csd@broadcom.com (Christian Daudt)
Date: Tue, 13 Nov 2012 11:02:24 -0800
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <50A1D06A.2010000@wwwdotorg.org>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
 <50A1D06A.2010000@wwwdotorg.org>
Message-ID: <50A29940.7050400@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-11-12 08:45 PM, Stephen Warren wrote:
> On 11/11/2012 07:57 AM, Christian Daudt wrote:
>> In order to start upstreaming Broadcom SoC support, create
>> a starting hierarchy, arch and dts files.
>> The first support SoC family that is planned is the
>> BCM281XX (BCM28145/28150/28155/28160) family of dual A9 mobile SoC cores
>> This code is just the skeleton code for get the machine upstreamed. It
>> has been made MULTIPLATFORM compatible.
>> Next steps
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> +dtb-$(CONFIG_ARCH_BCM) += capri-brt.dtb
> I think that needs to be renamed too.
done
>
>> diff --git a/arch/arm/boot/dts/bcm281xx.dtsi b/arch/arm/boot/dts/bcm281xx.dtsi
>> +/ {
>> +	model = "BCM281xx SoC";
>> +	compatible = "bcm,bcm281xx";
> I think this should list the specific SoC rather than (or perhaps in
> addition to) a wildcard.
The idea here is that bcm281xx contains the family-wide definitions, and 
once there are multiple boards that use the same specific chip then I'd 
create a chip-specific dtsi file. So eventually it'd be:
bcm281xx.dtsi - for the family

bcm28145.dtsi
bcm28155.dtsi
... for chip-specific

and
bcm28160-brt.dts
... for board specific.

But to simplify I'm just starting with bcm281xx and bcm28160-brt


> Out of curiosity though, what kind of differences exist between the
> various SoCs this wildcard is intended to cover;
> bcm28145/28150/28155/28160? Are they simply package/pinout differences,
> or something more involved?
It mostly revolves around single or dual memory controller, and POP or 
external DDR. I've only used internal names prior to upstreaming, and it 
turns out that my understanding of the numbering is not quite right, so 
I'll be adjusting the patchset a bit before sending the next version out.

>> +	uart at 3e000000 {
>> +		compatible = "snps,dw-apb-uart";
> As I mentioned in my earlier reply, I think this should indicate the
> specific instantiation of the IP too; something like
> bcm,bcm28160-dw-apb-uart.
ok. added.
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> +	help
>> +	  This enables support for system based on Broadcom SoCs.
>> +          It currently supports BCM28145/28150/28155/28160 chips.
> The indentation looks a little odd there.
fixed.

>> diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
>> +static const char * const capri_dt_compat[] = { "bcm,capri", NULL, };
> I think that needs to be updated too.
fixed.
>
