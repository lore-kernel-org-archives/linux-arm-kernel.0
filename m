From: lho@apm.com (Loc Ho)
Date: Wed, 29 Apr 2015 14:33:28 -0700
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <CAL_Jsq+nhPUxHxrStB9cdy1YzE7tVPFVR1MrWq3Bz-JUa=3Rvg@mail.gmail.com>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <1430259045-19012-3-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <CAL_Jsq+nhPUxHxrStB9cdy1YzE7tVPFVR1MrWq3Bz-JUa=3Rvg@mail.gmail.com>
Message-ID: <CAPw-ZTnLR10Zr_p8L3-1nBZ+jKE1HCwERDmO=S5as2GLqime3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

>>  .../devicetree/bindings/edac/apm-xgene-edac.txt    |  107 ++++++++++++++++++++
>>  1 files changed, 107 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>>
>> diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>> new file mode 100644
>> index 0000000..548299a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
>> @@ -0,0 +1,107 @@
>> +* APM X-Gene SoC EDAC nodes
>> +
>> +EDAC nodes are defined to describe on-chip error detection and correction.
>> +There are four types of EDAC:
>> +
>> +  memory controller    - Memory controller
>> +  PMD (L1/L2)          - Processor module unit (PMD) L1/L2 cache
>> +  L3                   - CPU L3 cache
>> +  SoC                  - SoC IP such as SATA, Ethernet, and etc
>> +
>> +The following section describes the memory controller DT node binding.
>> +
>> +Required properties:
>> +- compatible           : Shall be "apm,xgene-edac-mc".
>
> You are still describing what you want for EDAC driver not what the
> h/w looks like AFAICT.
>

We have 4 memory controller and two memory bridges. Each memory
bridges can handle two memory controllers.

>> +- regmap-pcp           : Regmap of the PCP resource.
>> +- regmap-csw           : Regmap of the CSW resource.
>> +- regmap-mcba          : Regmap of the MCB-A resource.
>> +- regmap-mcbb          : Regmap of the MCB-B resource.
>
> What are these blocks? Regardless, I doubt the linkage here belongs in DT.

The PCP provide the top level interrupt for various status. From that,
one can determine the type of error based on various status bits -
memory error, CPU cache parity memory errors (L1, L2, and L3), and SoC
memory parity errors. The CSW contains the status to indicate whether
an memory bridge is active or not. The MCB A and MCB B are used to
determine an memory controller is active or not. In summary, we have:

CSW, MCB A, and MCB B are used to determine active memory controller
and ignore in-active memory controller.
PCP and the memory controller (reg property) are used to determine the
memory error type and type of error (correctable or un-conrrectable).

If one still needs more clarification, let me know.

>
>> +- reg                  : First resource shall be the MCU resource.
>> +- interrupts            : Interrupt-specifier for MCU error IRQ(s).
>
> What is MCU?

MCU represents the memory controller unit.

>
>> +
>> +The following section describes the L1/L2 DT node binding.
>
> Similar comments for the rest. I would define memory controller
> bindings and EDAC driver, then worry about the rest.

Okay.. As comment in following emails, I will break up the driver into
multiple drivers and focus only on the memory controller driver first.

-Loc
