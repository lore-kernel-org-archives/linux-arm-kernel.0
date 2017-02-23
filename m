From: steven.lin1@broadcom.com (Steve Lin)
Date: Thu, 23 Feb 2017 08:38:55 -0500
Subject: [PATCH 1/1] ARM: dts: BCM953012HR: Initial Checkin
In-Reply-To: <68373798-376d-43d9-85cb-c6af7c6fa302@gmail.com>
References: <1487798092-8631-1-git-send-email-steven.lin1@broadcom.com>
 <68373798-376d-43d9-85cb-c6af7c6fa302@gmail.com>
Message-ID: <CA+Jmh7Ha0CTmTQnexz7oga2m54paKxbqZ+yF5orbEH72Ffi3Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Resending in plaintext - forgot to disable html in my mail client -
apologies if you receive 2 copies *

Rafal & Rob,

I will spin a v2 with the cleanups Rob suggested and the uart/nand
changes Rafal suggested.  Thanks!

Rafal, to answer your question about having similar partitions on both
flash devices, that is something that I believe we do on our reference
platforms to demonstrate to customers using either flash for storing
their kernel image, rootfs, etc.  See for example bcm958625k.dts where
we also have similar partition names for nand and spi flash.

Thanks,
Steve

On Thu, Feb 23, 2017 at 4:37 AM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> On 02/22/2017 10:14 PM, Steve Lin wrote:
>>
>> Initial version of DTS to support Broadcom BCM953012HR Northstar
>> HR platform, similar to, but not the same as existing 953012K.
>>
>> Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
>> ---
>>  arch/arm/boot/dts/Makefile        |   1 +
>>  arch/arm/boot/dts/bcm953012hr.dts | 115
>> ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 116 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/bcm953012hr.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 01d178a..c64ca3d 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -94,6 +94,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
>>         bcm94708.dtb \
>>         bcm94709.dtb \
>>         bcm953012er.dtb \
>> +       bcm953012hr.dtb \
>>         bcm953012k.dtb
>>  dtb-$(CONFIG_ARCH_BCM_53573) += \
>>         bcm47189-tenda-ac9.dtb
>> diff --git a/arch/arm/boot/dts/bcm953012hr.dts
>> b/arch/arm/boot/dts/bcm953012hr.dts
>> new file mode 100644
>> index 0000000..c332277
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/bcm953012hr.dts
>> @@ -0,0 +1,115 @@
>> +/*
>> + *  BSD LICENSE
>> + *
>> + *  Copyright(c) 2017 Broadcom
>> + *
>> + *  Redistribution and use in source and binary forms, with or without
>> + *  modification, are permitted provided that the following conditions
>> + *  are met:
>> + *
>> + *    * Redistributions of source code must retain the above copyright
>> + *      notice, this list of conditions and the following disclaimer.
>> + *    * Redistributions in binary form must reproduce the above copyright
>> + *      notice, this list of conditions and the following disclaimer in
>> + *      the documentation and/or other materials provided with the
>> + *      distribution.
>> + *    * Neither the name of Broadcom nor the names of its contributors
>> + *      may be used to endorse or promote products derived from this
>> + *      software without specific prior written permission.
>> + *
>> + *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
>> + *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
>> + *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
>> + *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
>> + *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
>> + *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>> + *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
>> + *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
>> + *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
>> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>> + *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "bcm4708.dtsi"
>> +
>> +/ {
>> +       model = "NorthStar HR (BCM953012HR)";
>> +       compatible = "brcm,bcm953012hr", "brcm,brcm53012", "brcm,bcm4708";
>> +
>> +       aliases {
>> +               serial0 = &uart0;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       memory {
>> +               reg = <0x80000000 0x10000000>;
>> +       };
>> +};
>> +
>> +&uart0 {
>> +       status = "okay";
>> +};
>
>
> You don't need this.
> 7b790d3b2943 ("ARM: dts: BCM5301X: Enable UART by default for BCM4708(1),
> BCM4709(4) & BCM53012")
>
>
>> +&nand {
>> +       nandcs at 0 {
>> +               compatible = "brcm,nandcs";
>> +               reg = <0>;
>> +               nand-on-flash-bbt;
>> +
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +
>> +               nand-ecc-strength = <4>;
>> +               nand-ecc-step-size = <512>;
>
>
> Can you just include bcm5301x-nand-cs0-bch4.dtsi?
>
>
>> +
>> +               partition at 0 {
>> +                       label = "nboot";
>> +                       reg = <0x00000000 0x00200000>;
>> +                       read-only;
>> +               };
>> +               partition at 200000 {
>> +                       label = "nenv";
>> +                       reg = <0x00200000 0x00400000>;
>> +               };
>> +               partition at 600000 {
>> +                       label = "nsystem";
>> +                       reg = <0x00600000 0x00a00000>;
>> +               };
>> +               partition at 1000000 {
>> +                       label = "nrootfs";
>> +                       reg = <0x01000000 0x07000000>;
>> +               };
>
>
> These could go to &nandcs with above dtsi include.
>
>
>> +       };
>> +};
>> +
>> +&spi_nor {
>> +       status = "okay";
>> +       spi-max-frequency = <62500000>;
>> +       m25p,default-addr-width = <3>;
>> +
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +
>> +       partition at 0 {
>> +               label = "boot";
>> +               reg = <0x00000000 0x000d0000>;
>> +       };
>> +       partition at d000 {
>> +               label = "env";
>> +               reg = <0x000d0000 0x00030000>;
>> +       };
>> +       partition at 100000 {
>> +               label = "system";
>> +               reg = <0x00100000 0x00600000>;
>> +       };
>> +       partition at 700000 {
>> +               label = "rootfs";
>> +               reg = <0x00700000 0x00900000>;
>> +       };
>> +};
>
>
> This is a bit uncommon for me to have the same partitions on both flash
> device.
> Can you provide some extra description of this setup, please?
>
