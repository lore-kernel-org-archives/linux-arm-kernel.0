From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 7 Jul 2016 14:25:24 +0800
Subject: [PATCH V2 03/10] Documentation: dt-bindings: firmware: tegra: add
 bindings of the BPMP
In-Reply-To: <CAAVeFuJwhQ=L803W7K+e5_VUKrfB2NyCz+WMR91QuvKgmv1ofw@mail.gmail.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-4-josephl@nvidia.com>
 <CAAVeFuJwhQ=L803W7K+e5_VUKrfB2NyCz+WMR91QuvKgmv1ofw@mail.gmail.com>
Message-ID: <577DF5D4.4010008@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 07:42 PM, Alexandre Courbot wrote:
> On Tue, Jul 5, 2016 at 6:04 PM, Joseph Lo <josephl@nvidia.com> wrote:
>> The BPMP is a specific processor in Tegra chip, which is designed for
>> booting process handling and offloading the power management, clock
>> management, and reset control tasks from the CPU. The binding document
>> defines the resources that would be used by the BPMP firmware driver,
>> which can create the interprocessor communication (IPC) between the CPU
>> and BPMP.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> Changes in V2:
>> - update the message that the BPMP is clock and reset control provider
>> - add tegra186-clock.h and tegra186-reset.h header files
>> - revise the description of the required properties
>> ---
>>   .../bindings/firmware/nvidia,tegra186-bpmp.txt     |  77 ++
>>   include/dt-bindings/clock/tegra186-clock.h         | 940 +++++++++++++++++++++
>>   include/dt-bindings/reset/tegra186-reset.h         | 217 +++++
>>   3 files changed, 1234 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>>   create mode 100644 include/dt-bindings/clock/tegra186-clock.h
>>   create mode 100644 include/dt-bindings/reset/tegra186-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>> new file mode 100644
>> index 000000000000..4d0b6eba56c5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
>> @@ -0,0 +1,77 @@
>> +NVIDIA Tegra Boot and Power Management Processor (BPMP)
>> +
>> +The BPMP is a specific processor in Tegra chip, which is designed for
>> +booting process handling and offloading the power management, clock
>> +management, and reset control tasks from the CPU. The binding document
>> +defines the resources that would be used by the BPMP firmware driver,
>> +which can create the interprocessor communication (IPC) between the CPU
>> +and BPMP.
>> +
>> +Required properties:
>> +- name : Should be bpmp
>> +- compatible
>> +    Array of strings
>> +    One of:
>> +    - "nvidia,tegra186-bpmp"
>> +- mboxes : The phandle of mailbox controller and the mailbox specifier.
>> +- shmem : List of the phandle of the TX and RX shared memory area that
>> +         the IPC between CPU and BPMP is based on.
>> +- #clock-cells : Should be 1.
>> +- #reset-cells : Should be 1.
>> +
>> +This node is a mailbox consumer. See the following files for details of
>> +the mailbox subsystem, and the specifiers implemented by the relevant
>> +provider(s):
>> +
>> +- Documentation/devicetree/bindings/mailbox/mailbox.txt
>> +- Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>> +
>> +This node is a clock and reset provider. See the following files for
>> +general documentation of those features, and the specifiers implemented
>> +by this node:
>> +
>> +- Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +- include/dt-bindings/clock/tegra186-clock.h
>> +- Documentation/devicetree/bindings/reset/reset.txt
>> +- include/dt-bindings/reset/tegra186-reset.h
>> +
>> +The shared memory bindings for BPMP
>> +-----------------------------------
>> +
>> +The shared memory area for the IPC TX and RX between CPU and BPMP are
>> +predefined and work on top of sysram, which is an SRAM inside the chip.
>> +
>> +See "Documentation/devicetree/bindings/sram/sram.txt" for the bindings.
>> +
>> +Example:
>> +
>> +hsp_top0: hsp at 03c00000 {
>> +       ...
>> +       #mbox-cells = <1>;
>> +};
>> +
>> +sysram at 30000000 {
>> +       compatible = "nvidia,tegra186-sysram", "mmio-ram";
>
> Shouldn't the second compatible be "mmio-sram"?
>
> If so, then you have the same typo in tegra186.dtsi as well.
>

Good catch, will fix.

Thanks,
-Joseph
