From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 6 Mar 2018 10:54:39 +0100
Subject: [PATCH 1/2] dt-bindings: mailbox: add STMicroelectronics STM32
 IPCC binding
In-Reply-To: <20180306005729.odhf4g5br7tfrq35@rob-hp-laptop>
References: <1519824270-7134-1-git-send-email-fabien.dessenne@st.com>
 <1519824270-7134-2-git-send-email-fabien.dessenne@st.com>
 <20180306005729.odhf4g5br7tfrq35@rob-hp-laptop>
Message-ID: <CA+M3ks51PxJ_MBFcwKoLhVvBR0j8d_sY6uVkxjNEvP3Atvj4qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-06 1:57 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Wed, Feb 28, 2018 at 02:24:29PM +0100, Fabien Dessenne wrote:
>> Add a binding for the STMicroelectronics STM32 IPCC block exposing a
>> mailbox mechanism between two processors.
>>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>  .../devicetree/bindings/mailbox/stm32-ipcc.txt     | 48 ++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt b/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
>> new file mode 100644
>> index 0000000..2321689
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
>> @@ -0,0 +1,48 @@
>> +* STMicroelectronics STM32 IPCC (Inter-Processor Communication Controller)
>> +
>> +The IPCC block provides a non blocking signaling mechanism to post and
>> +retrieve messages in an atomic way between two processors.
>> +It provides the signaling for N bidirectionnal channels. The number of channels
>> +(N) can be read from a dedicated register.
>> +
>> +Required properties:
>> +- compatible:   Must be "st,stm32-ipcc"
>
> Kind of generic. There's only 1 version of h/w across all stm32 parts?
>

We can check the version in one of the hardware block register.
I guess in this case we can have this kind of generic compatible, right ?

Benjamin

>> +- reg:          Register address range (base address and length)
>> +- st,proc_id:   Processor id using the mailbox (0 or 1)
>
> s/_/-/
>
>
>> +- clocks:       Input clock
>> +- interrupt-names: List of names for the interrupts described by the interrupt
>> +                   property. Must contain the following entries:
>> +                   - "rx"
>> +                   - "tx"
>> +- interrupts:   Interrupt specifiers for "rx channel occupied" and "tx channel
>> +                free"
>> +- #mbox-cells:  Number of cells required for the mailbox specifier. Must be 1.
>> +                The data contained in the mbox specifier of the "mboxes"
>> +                property in the client node is the mailbox channel index.
>> +
>> +Optional properties:
>> +- wakeup-source: Flag to indicate whether this device can wake up the system
>
>> +- interrupts:    Wakeup interrupt used to wake up the system.
>> +- interrupt-names: "wakeup" for the wakeup interrupt.
>
> Make these required. "wakeup-source" alone determines if you use it.
>
>> +
>> +
>> +
>> +Example:
>> +     ipcc: mailbox at 4c001000 {
>> +             compatible = "st,stm32-ipcc";
>> +             #mbox-cells = <1>;
>> +             reg = <0x4c001000 0x400>;
>> +             st,proc_id = <0>;
>> +             interrupts-extended = <&intc GIC_SPI 100 IRQ_TYPE_NONE>,
>> +                                   <&intc GIC_SPI 101 IRQ_TYPE_NONE>,
>> +                                   <&aiec 62 1>;
>> +             interrupt-names = "rx", "tx", "wakeup";
>> +             clocks = <&rcc_clk IPCC>;
>> +             wakeup-source;
>> +     }
>> +
>> +Client:
>> +     mbox_test {
>> +             ...
>> +             mboxes = <&ipcc 0>, <&ipcc 1>;
>> +     };
>> --
>> 2.7.4
>>
