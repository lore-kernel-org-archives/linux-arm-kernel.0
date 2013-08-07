From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 07 Aug 2013 19:28:29 +0200
Subject: [PATCH] ARM: at91/dt: split sam9x5 peripheral definitions
In-Reply-To: <20130807180854.41b4bedb@skate>
References: <1375870466-1093-1-git-send-email-b.brezillon@overkiz.com>
 <20130807180854.41b4bedb@skate>
Message-ID: <520283BD.9060002@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

Sorry for the noise, this mail was filtered by LKML and LAKML beacause 
thunderbird
added HTML contents.

On 07/08/2013 18:08, Thomas Petazzoni wrote:
> Dear Boris BREZILLON,
>
> On Wed,  7 Aug 2013 12:14:26 +0200, Boris BREZILLON wrote:
>> This patch splits the sam9x5 peripheral definitions into:
>> - a common base for all sam9x5 SoCs (at91sam9x5.dtsi)
>> - several optional peripheral definitions which will be included by specific
>>    sam9x5 SoCs (at91sam9x5_'periph name'.dtsi)
>>
>> This provides a better representation of the real hardware (drop unneeded
>> dt nodes) and avoids future peripheral id conflict (lcdc and isi both use
>> peripheral id 25).
>>
>> Signed-off-by: Boris BREZILLON<b.brezillon@overkiz.com>
>> ---
>>   arch/arm/boot/dts/at91sam9g25.dtsi       |    2 +
>>   arch/arm/boot/dts/at91sam9g35.dtsi       |    1 +
>>   arch/arm/boot/dts/at91sam9x25.dtsi       |   24 ++---------
>>   arch/arm/boot/dts/at91sam9x35.dtsi       |    1 +
>>   arch/arm/boot/dts/at91sam9x5.dtsi        |   67 ------------------------------
>>   arch/arm/boot/dts/at91sam9x5_macb0.dtsi  |   56 +++++++++++++++++++++++++
>>   arch/arm/boot/dts/at91sam9x5_macb1.dtsi  |   44 ++++++++++++++++++++
>>   arch/arm/boot/dts/at91sam9x5_usart3.dtsi |   51 +++++++++++++++++++++++
>>   8 files changed, 158 insertions(+), 88 deletions(-)
>>   create mode 100644 arch/arm/boot/dts/at91sam9x5_macb0.dtsi
>>   create mode 100644 arch/arm/boot/dts/at91sam9x5_macb1.dtsi
>>   create mode 100644 arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> Hum, do we really want to have .dtsi files per peripheral? I might have
> overlooked this, but I think it's the first time we would have this in
> arch/arm/boot/dts.
It's not one .dtsi file for each available peripheral but for each 
**optional**
peripheral (those which are not available for all sam9x5 SoCs).

For example:

macb0 is available in this SoCs:
- 9g25
- 9g35
- 9x25
- 9x35
and not available in 9g15 SoC.

And we have different combinatory for each of the optional devices.

IMHO, defining the unneeded dt nodes in the common sam9x5.dtsi is a bad 
idea, because
the dtb footprint will be bigger for SoC which does not have the 
optional peripherals
and the dt hardware representation will be false.

I see two options to solve this issue:
  1) define a .dtsi file describing the optional peripherals and include 
these .dtsi in the SoC.dtsi file
      (as I proposed, but maybe the names  are not appropriate)
  2) copy the peripheral definitions in each SoC .dtsi file

I prefer option 1) as it's safer than copying the definition (update of 
dtsi is easier and there is no
risk to introduce a new bug when copying definitions).

Please, tell me if you see other options, or if you think this "issue" 
should not be solved.

Best Regards,

Boris
> Thomas
