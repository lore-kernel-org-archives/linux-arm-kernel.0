From: csd@broadcom.com (Christian Daudt)
Date: Sun, 11 Nov 2012 05:34:45 -0800
Subject: [PATCH] Add support for generic BCM SoC chipsets
In-Reply-To: <509C7771.9020400@wwwdotorg.org>
References: <1352391196-9984-1-git-send-email-csd@broadcom.com>
 <509C7771.9020400@wwwdotorg.org>
Message-ID: <509FA975.6060203@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-11-08 07:24 PM, Stephen Warren wrote:
> On 11/08/2012 09:13 AM, Christian Daudt wrote:
>> In order to start upstreaming Broadcom SoC support, create
>> a starting hierarchy, arch and dts files.
>> The first support SoC family that is planned is the
>>   BCM281XX (BCM28145/28150/28155) family of dual A9 mobile SoC cores
>> This code is just the skeleton code for get the machine upstreamed. It
>> has been made MULTIPLATFORM compatible.
> Christian,
>
> Is the intent for this to support other BCM SoCs in the future, such as
> the bcm2835 in the Raspberry Pi, and the mach-bcm476x which Domenico
> Andreoli recently sent patches for? It'd be awesome if Broadcom could
> provide MMC and USB drivers for the bcm2835 for example.
Yes and no :) The intent is to support other BCM SoCs in the future, but 
Broadcom has a fair number of ARM based SoCs. My primary focus is on the 
ones from my group within Broadcom (mobile SoCs), but the plan is to 
bring in others as feasible, and collaborate with other upstreaming work 
being done for BCM SoCs.
  As for bcm2835 MMC and USB, we will be upstreaming MMC and USB 
bcm281xx as part of this effort and while I haven't checked the bcm2835 
guts (it comes from a different team within Broadcom) I suspect it might 
share the same IP blocks, which would make it fairly easy to extend our 
work to add 2835 support. Stay tuned !

>>   arch/arm/boot/dts/capri-brt.dts |   32 +++++++++++
>>   arch/arm/boot/dts/capri.dtsi    |   50 +++++++++++++++++
> What does the name "capri" refer to? I assume it's a code-name for the
> SoC/series. My inclination is that naming those files bcm28145.dtsi and
> bcm28145-brt.dts (or 28150/28155 as appropriate) might be a little more
> obvious to people unfamiliar with the code-names.
Yes, capri is a code name. I've gone back and forth on this one. I think 
I'll change it to bcm281xx.dtsi and  bcm28160-brt.dts, which then refers 
to the family for the dtsi and the specific chip for the dts.
>> diff --git a/arch/arm/boot/dts/capri-brt.dts b/arch/arm/boot/dts/capri-brt.dts
>> +/ {
>> +	model = "Capri BRT board";
>> +	compatible = "bcm,capri";
> The individual board file's compatible property should contain both a
> board-specific value and the generic SoC value. This allows the SoC
> support in the kernel to match on the generic SoC compatible value, yet
> still allow the kernel to match the board-specific value in case any
> quirks are required. For example,
>
> 	compatible = "bcm,brt", "bcm,capri";
>
> (assuming that "brt" is the full board name)
I will change this based on the above convention i.e.:
  compatible = "bcm, bcm28160-brt", "bcm, bcm281xx";

>> +	interrupt-parent =<&gic>;
> That's already in capri.dtsi; there's no advantage to repeating it.
ok, removed.

>> +	memory {
>> +		device_type = "memory";
> That property already exists in skeleton.dtsi, which is included via
> capri.dtsi.
ok, removed.

>> diff --git a/arch/arm/boot/dts/capri.dtsi b/arch/arm/boot/dts/capri.dtsi
>> +	gic: interrupt-controller at 3ff00100 {
>> +		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> The commit description says it's an A9 not an A15.
changed.

>> +	uart at 3e000000 {
>> +		compatible = "snps,dw-apb-uart";
> You probably want to include SoC-specific compatible values for all the
> IP blocks too.
I don't follow this part. Do you mean to replace that line with 
something like 'compatible = "snps,sw-apb-uart", "bcm, bcm28x11-uart"' ? 
If so, I don't think that that is necessary - right now there is nothing 
BCM specific about this.
> There need to be device tree bindings written to describe to contents of
> all these device-tree files; see Documentation/devicetree/bindings/.
Added a bcm281xx description.
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> +config ARCH_BCM
>> +	bool "Broadcom SoC" if ARCH_MULTI_V7
>> +	depends on MMU
>> +	select CPU_V7
>> +	select ARM_GIC
>> +	select GENERIC_GPIO
>> +	select GPIO_BCM
>> +	select ARCH_REQUIRE_GPIOLIB
>> +	select GENERIC_TIME
>> +	select GENERIC_CLOCKEVENTS
>> +	select TICK_ONESHOT
>> +	select ARM_ERRATA_754322
>> +	select ARM_ERRATA_764369 if SMP
>> +	select SPARSE_IRQ
> Those select statements should be alphabetically sorted.
done

>> diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
>> +
>> +
>> +
>> +
>> +
> Nit: A couple of instances of multiple newlines, but not a big deal.
>
done.

  thanks,
    csd

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121111/a8648aa2/attachment-0001.html>
