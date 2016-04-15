From: vigneshr@ti.com (R, Vignesh)
Date: Fri, 15 Apr 2016 20:38:07 +0530
Subject: [PATCH 2/2] ARM: dts: dra7x: Support QSPI MODE-0 operation at
 64MHz
In-Reply-To: <20160414171215.GA9860@rob-hp-laptop>
References: <1460629101-24309-1-git-send-email-vigneshr@ti.com>
 <1460629101-24309-3-git-send-email-vigneshr@ti.com>
 <20160414171215.GA9860@rob-hp-laptop>
Message-ID: <571103D7.8060407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/14/2016 10:42 PM, Rob Herring wrote:
> On Thu, Apr 14, 2016 at 03:48:21PM +0530, Vignesh R wrote:
>> According to Data Manual(SPRS915P) of AM57x, TI QSPI controller on
>> DRA74(rev 1.1+)/DRA72 EVM can support up to 64MHz in MODE-0, whereas
>> MODE-3 is limited to 48MHz. Hence, switch to MODE-0 for better
>> throughput.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  Documentation/devicetree/bindings/spi/ti_qspi.txt | 7 +++++++
>>  arch/arm/boot/dts/dra7-evm.dts                    | 6 ++----
>>  arch/arm/boot/dts/dra72-evm.dts                   | 6 ++----
>>  3 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
>> index cc8304aa64ac..50b14f6b53a3 100644
>> --- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
>> +++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
>> @@ -19,6 +19,13 @@ Optional properties:
>>  - syscon-chipselects: Handle to system control region contains QSPI
>>  		      chipselect register and offset of that register.
>>  
>> +NOTE: TI QSPI controller requires different pinmux and IODelay
>> +paramaters for Mode-0 and Mode-3 operations, which needs to be set up by
>> +the bootloader (U-Boot). Default configuration only supports Mode-0
>> +operation. Hence, "spi-cpol" and "spi-cpha" DT properties cannot be
>> +specified in the slave nodes of TI QSPI controller without appropriate
>> +modification to bootloader.
> 
> But these properties are properties of what the slave device supports, 
> right? I don't see how you can change them based on the controller.

Yeah, although these are properties of slave device, they indicate what
clock phase and clock polarity(mode) should the controller use to
communicate with slave. AFAIK, most slave normally support Mode 0 and
Mode 3 operation. If "spi-cpol" and "spi-cpha" are defined then
communication is Mode 3 else (if both properties are absent) its Mode 0.
SPI controller driver then uses the appropriate clock polarity and clock
phase.
Depending on controller capabilities, slave capabilities and board
specific constraints either Mode 0 or Mode 3 is chosen(not both).
The above NOTE is to indicate that its _not possible_ to use spi slave
that strictly require mode-3(indicated by defining "spi-cpol" and
"spi-cpha" DT properties) with ti-qspi controller without appropriate
modification to bootloader. In other words Mode-3 slaves are not
supported by TI QSPI driver with upstream U-Boot.

-- 
Regards
Vignesh
