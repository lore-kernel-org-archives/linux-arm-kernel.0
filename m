From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Jun 2017 14:10:33 -0500
Subject: [PATCH 1/3] Documentation: DT: add Keystone DSP remoteproc binding
In-Reply-To: <39a18ffb-cd33-29a7-c3e9-f8e2e6d3432b@ti.com>
References: <20170526165317.23164-1-s-anna@ti.com>
 <20170526165317.23164-2-s-anna@ti.com>
 <20170531191231.5qt2lfv73p572gmd@rob-hp-laptop>
 <884f5585-eac2-57b2-a2be-879bf23f2e00@ti.com>
 <20170605172648.6xonnkvbwmd3cehg@rob-hp-laptop>
 <39a18ffb-cd33-29a7-c3e9-f8e2e6d3432b@ti.com>
Message-ID: <CAL_Jsq+85CSNRC0JzVHrJQM9wUfeQk9kBrT8jEFRBPE9OX95Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 1:21 PM, Suman Anna <s-anna@ti.com> wrote:
> Hi Rob,
>
>>>
>>> On 05/31/2017 02:12 PM, Rob Herring wrote:
>>>> On Fri, May 26, 2017 at 11:53:15AM -0500, Suman Anna wrote:
>>>>> Add the device tree bindings document for the Texas Instrument's
>>>>> Keystone 2 DSP remoteproc devices.
>>>>>
>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>>> Signed-off-by: Sam Nelson <sam.nelson@ti.com>
>>>>> ---
>>>>>  .../bindings/remoteproc/ti,keystone-rproc.txt      | 132 +++++++++++++++++++++
>>>>>  1 file changed, 132 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
>>>>> new file mode 100644
>>>>> index 000000000000..f1ba88edd00d
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt
>>>>> @@ -0,0 +1,132 @@
>>>>> +TI Keystone DSP devices
>>>>> +=======================
>>>>> +
>>>>> +Binding status: Unstable - Subject to changes for using multiple memory regions
>>>>
>>>> I don't really see what would be unstable here. memory-region is easily
>>>> extended to multiple entries.
>>>
>>> OK will drop this line.
>>>
>>>>
>>>>> +
>>>>> +The TI Keystone 2 family of SoCs usually have one or more (upto 8) TI DSP Core
>>>>> +sub-systems that are used to offload some of the processor-intensive tasks or
>>>>> +algorithms, for achieving various system level goals.
>>>>> +
>>>>> +These processor sub-systems usually contain additional sub-modules like L1
>>>>> +and/or L2 caches/SRAMs, an Interrupt Controller, an external memory controller,
>>>>> +a dedicated local power/sleep controller etc. The DSP processor core in
>>>>> +Keystone 2 SoCs is usually a TMS320C66x CorePac processor.
>>>>> +
>>>>> +DSP Device Node:
>>>>> +================
>>>>> +Each DSP Core sub-system is represented as a single DT node. Each node has a
>>>>> +number of required or optional properties that enable the OS running on the
>>>>> +host processor (ARM CorePac) to perform the device management of the remote
>>>>> +processor and to communicate with the remote processor.
>>>>> +
>>>>> +Required properties:
>>>>> +--------------------
>>>>> +The following are the mandatory properties:
>>>>> +
>>>>> +- compatible:             Should be one of the following,
>>>>> +                      "ti,k2hk-dsp" for DSPs on Keystone 2 66AK2H/K SoCs
>>>>> +                      "ti,k2l-dsp" for DSPs on Keystone 2 66AK2L SoCs
>>>>> +                      "ti,k2e-dsp" for DSPs on Keystone 2 66AK2E SoCs
>>>>> +
>>>>> +- reg:                    Should contain an entry for each value in 'reg-names'.
>>>>> +                  Each entry should have the memory region's start address
>>>>> +                  and the size of the region, the representation matching
>>>>> +                  the parent node's '#address-cells' and '#size-cells' values.
>>>>> +
>>>>> +- reg-names:              Should contain strings with the following names, each
>>>>> +                  representing a specific internal memory region, and
>>>>> +                  should be defined in this order,
>>>>> +                       "l2sram", "l1pram", "l1dram"
>>>>> +
>>>>> +- label:          Should contain a string identifying the DSP instance
>>>>> +                  within the SoC. Should be the string "dsp" followed by
>>>>> +                  the instance number. Eg: "dsp0", "dsp1",..."dsp7" etc
>>>>
>>>> Why does a user need to know or care?
>>>
>>> This is used to distinguish the exact DSP instance from others since the
>>> DT node name is a generic "dsp". One of the uses is to be able to
>>> construct a firmware name within the driver using this label.
>>
>> firmware-name doesn't work for you?
>
> Has the stance changed w.r.t coding up the firmware-name in DT now? My
> understanding was that this has to be coded up in the driver from a
> previous related discussion on this [1]. I am more than happy to move
> the firmware name into DT for all remoteprocs if that is an accepted
> solution now.

There's not a hard and fast rule. For FPGAs at least it made sense to
use firmware-name.

>> It was obvious that you are using this to number instances. Why do you
>> care which instance is which? For example, I want dsp0 because it has X
>> or runs at XXMHz, etc. If each instance is different (i.e. not a pool of
>> DSPs), then you should describe the difference some way.
>
> Well, I am not exactly using the label to number the instance, it is a
> possibility outside of using it to encode the firmware name. The
> partitioning is really upto the application/SoC s/w system integration
> aspects.  Most of the times, you are not running identical software on
> these DSPs or other remote processors. For example, you might have one
> DSP running an OpenCL stack, another DSP dedicated for audio
> post-processing etc.
>
> That said, I do have a need for numbering the instances. This is needed
> usually for constructing a destination address to encode the processor
> when using a common Inter-Processor Communication API across all
> processors (Linux or otherwise). Pre-DT, I have used the platform device
> id for this on Linux behaving as the master processor. For DT, my
> preferred solution for that is an alias. If an alias is not acceptable,
> then I still have to provide an equivalent functionality through a
> driver-specific scheme.

I would prefer aliases over labels here. It may make sense to just
have a property for the desitination address (or some offset). Or
perhaps a list of IPC targets and the index to that list is the
instance.

Rob
