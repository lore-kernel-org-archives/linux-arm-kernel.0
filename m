From: anup@brainfault.org (Anup Patel)
Date: Fri, 22 Nov 2013 12:34:26 +0530
Subject: [PATCH 2/2] arm: Support for platforms with split GIC cpu
 interface registers.
In-Reply-To: <CAAhSdy0+AFrS8ZVwmM6Sx=qScx6d1DkQtc4+2SB3=PpsJiJDog@mail.gmail.com>
References: <1383300776.4332.3.camel@hastur.hellion.org.uk>
 <1383300809-7527-2-git-send-email-ian.campbell@citrix.com>
 <CAAhSdy0+AFrS8ZVwmM6Sx=qScx6d1DkQtc4+2SB3=PpsJiJDog@mail.gmail.com>
Message-ID: <CAAhSdy28OS+4QvFfEJ9o2MOGb6jS9Tjus_v7tsZTH9ZA3h=nRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 12:24 PM, Anup Patel <anup@brainfault.org> wrote:
> On Fri, Nov 1, 2013 at 3:43 PM, Ian Campbell <ian.campbell@citrix.com> wrote:
>> At least one platform (APM Storm) places the two pages of the GIC cpu interface
>> (and the vcpu side) at non-contiguous locations. Document two additional
>> regions to cover this split and update the corresponding dtsi. Note that Linux
>> (including KVM) does not use any registers in the second page so there is no
>> associated code change here.  Xen will use these new regions, although I've not
>> written the corresponding code yet.
>>
>> The ordering of these new regs is slightly counter intuitive but is inteded to
>> be backward compatible. It is also assumed that all such systems will implement
>> the GIC virtualisation extensions.
>>
>> Add comments to all of the reg examples to help clarify what is going on.
>
> Adding Catalin, Marc Z, and Will D.
>
> I looked up the GIC-400 TRM (more specifically page 33 of
> DDI0471B_gic400_r0p1_trm.pdf) but could not find any info
> on additional page for CPU interface.
>
> Am I looking at the wrong doc?

Never mind, found the GICC_DIR (offset 0x1000) register.

--
Anup

>
> --
> Anup
>
>>
>> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: Kumar Sankaran <ksankaran@apm.com>
>> Cc: Loc Ho <lho@apm.com>
>> Cc: Feng Kan <fkan@apm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/gic.txt | 57 +++++++++++++++++++++------
>>  arch/arm64/boot/dts/apm-storm.dtsi            |  6 ++-
>>  2 files changed, 50 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
>> index ea215e8..00836d9 100644
>> --- a/Documentation/devicetree/bindings/arm/gic.txt
>> +++ b/Documentation/devicetree/bindings/arm/gic.txt
>> @@ -38,7 +38,8 @@ Main node required properties:
>>
>>  - reg : Specifies base physical address(s) and size of the GIC registers. The
>>    first region is the GIC distributor register base and size. The 2nd region is
>> -  the GIC cpu interface register base and size.
>> +  the GIC cpu interface register base and size (See also "Split GIC
>> +  cpu interface", below).
>>
>>  Optional
>>  - interrupts   : Interrupt source of the parent interrupt controller on
>> @@ -56,8 +57,8 @@ Example:
>>                 #interrupt-cells = <3>;
>>                 #address-cells = <1>;
>>                 interrupt-controller;
>> -               reg = <0xfff11000 0x1000>,
>> -                     <0xfff10100 0x100>;
>> +               reg = <0xfff11000 0x1000>,      /* GIC Dist */
>> +                     <0xfff10100 0x100>;       /* GIC CPU */
>>         };
>>
>>
>> @@ -70,9 +71,11 @@ primary interrupt controller).
>>  Required properties:
>>
>>  - reg : Additional regions specifying the base physical address and
>> -  size of the VGIC registers. The first additional region is the GIC
>> -  virtual interface control register base and size. The 2nd additional
>> -  region is the GIC virtual cpu interface register base and size.
>> +  size of the VGIC registers. The first additional region (i.e. third
>> +  overall) is the GIC virtual interface control register base and
>> +  size. The 2nd additional region (i.e. forth overall) is the GIC
>> +  virtual cpu interface register base and size (See also "Split GIC
>> +  cpu interface", below).
>>
>>  - interrupts : VGIC maintenance interrupt.
>>
>> @@ -82,9 +85,41 @@ Example:
>>                 compatible = "arm,cortex-a15-gic";
>>                 #interrupt-cells = <3>;
>>                 interrupt-controller;
>> -               reg = <0x2c001000 0x1000>,
>> -                     <0x2c002000 0x2000>,
>> -                     <0x2c004000 0x2000>,
>> -                     <0x2c006000 0x2000>;
>> -               interrupts = <1 9 0xf04>;
>> +               reg = <0x2c001000 0x1000>,      /* GIC Dist */
>> +                     <0x2c002000 0x2000>,      /* GIC CPU */
>> +                     <0x2c004000 0x2000>,      /* GIC VCPU Control */
>> +                     <0x2c006000 0x2000>;      /* GIC VCPU1 */
>> +               interrupts = <1 9 0xf04>;       /* GIC Maintenence IRQ */
>> +       };
>> +
>> +* Split GIC cpu interface
>> +
>> +  The cpu interfaces (bare-metal in region 2 and virtual in region 4)
>> +  may be spread over two pages, with the GICC_DIR (Deactivate
>> +  Interrupt Register) register falling at the start of the second
>> +  page. If these pages are contiguous then this is described via the
>> +  size of the second and fourth entries as described above
>> +  (e.g. 0x2000 rather than 0x1000).
>> +
>> +  However if the two pages are not contiguous then two additional
>> +  regions are present (5th and 6th) describing the location of the the
>> +  second half of the GIC cpu interface and GIC virtual cpu interface
>> +  respectively.
>> +
>> +  It is assumed that all such systems will implement the GIC
>> +  virtualisation extensions.
>> +
>> +Example:
>> +
>> +       gic: interrupt-controller at 78010000 {
>> +               compatible = "arm,cortex-a15-gic";
>> +               #interrupt-cells = <3>;
>> +               interrupt-controller;
>> +               reg = <0x78010000 0x1000>,      /* GIC Dist */
>> +                     <0x78020000 0x1000>,      /* GIC CPU1 */
>> +                     <0x78040000 0x2000>,      /* GIC VCPU Control */
>> +                     <0x78060000 0x1000>,      /* GIC VCPU1 */
>> +                     <0x78030000 0x1000>,      /* GIC CPU2 */
>> +                     <0x78070000 0x1000>;      /* GIC VCPU2 */
>> +               interrupts = <1 9 0xf04>;       /* GIC Maintenence IRQ */
>>         };
>> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
>> index bfdc578..b5d141a 100644
>> --- a/arch/arm64/boot/dts/apm-storm.dtsi
>> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
>> @@ -82,9 +82,11 @@
>>                 #interrupt-cells = <3>;
>>                 interrupt-controller;
>>                 reg = <0x0 0x78010000 0x0 0x1000>,      /* GIC Dist */
>> -                     <0x0 0x78020000 0x0 0x1000>,      /* GIC CPU */
>> +                     <0x0 0x78020000 0x0 0x1000>,      /* GIC CPU1 */
>>                       <0x0 0x78040000 0x0 0x2000>,      /* GIC VCPU Control */
>> -                     <0x0 0x78060000 0x0 0x2000>;      /* GIC VCPU */
>> +                     <0x0 0x78060000 0x0 0x1000>,      /* GIC VCPU1 */
>> +                     <0x0 0x78030000 0x0 0x1000>,      /* GIC CPU2 */
>> +                     <0x0 0x78070000 0x0 0x1000>;      /* GIC VCPU2 */
>>                 interrupts = <1 9 0xf04>;       /* GIC Maintenence IRQ */
>>         };
>>
>> --
>> 1.8.4.rc3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
