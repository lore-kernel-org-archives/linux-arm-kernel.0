From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 30 Jun 2017 11:31:16 +0100
Subject: [PATCH 2/9] Documentation: add DT binding for ARM System Control
 and Management Interface(SCMI) protocol
In-Reply-To: <20170628230423.qbxyycqcrgqxyxjh@rob-hp-laptop>
References: <1498492513-29771-1-git-send-email-sudeep.holla@arm.com>
 <1498492513-29771-3-git-send-email-sudeep.holla@arm.com>
 <20170628230423.qbxyycqcrgqxyxjh@rob-hp-laptop>
Message-ID: <46d54581-8ab8-2125-5e09-9d8c240d5dd4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/06/17 00:04, Rob Herring wrote:
> On Mon, Jun 26, 2017 at 04:55:06PM +0100, Sudeep Holla wrote:
>> This patch adds devicetree binding for System Control and Management
>> Interface (SCMI) Message Protocol used between the Application Cores(AP)
>> and the System Control Processor(SCP). The MHU peripheral provides a
>> mechanism for inter-processor communication between SCP's M3 processor
>> and AP.
> 
> "dt-bindings: arm: ..." for the subject.
> 

Fixed locally, will be part of next version.

>>
>> SCP offers control and management of the core/cluster power states,
>> various power domain DVFS including the core/cluster, certain system
>> clocks configuration, thermal sensors and many others.
>>
>> SCMI protocol is developed as better replacement to the existing SCPI
>> which is not flexible and easily extensible.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 175 +++++++++++++++++++++
>>  1 file changed, 175 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/arm,scmi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
>> new file mode 100644
>> index 000000000000..d4565e78a8d7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
>> @@ -0,0 +1,175 @@
>> +System Control and Management Interface (SCMI) Message Protocol
>> +----------------------------------------------------------
>> +
>> +The SCMI is intended to allow agents such as OSPM to manage various functions
>> +that are provided by the hardware platform it is running on, including power
>> +and performance functions.
>> +
>> +This binding is intended to define the interface the firmware implementing
>> +the SCMI as described in ARM document number ARM DUI 0922B ("ARM System Control
>> +and Management Interface Platform Design Document")[0] provide for OSPM in
>> +the device tree.
>> +
>> +Required properties:
>> +
>> +- compatible : shall be "arm,scmi"
>> +- method : The method of calling the SCMI firmware. Only permitted value
>> +	   currently is:
>> +	   "mailbox-doorbell" : When mailbox doorbell is used as a mechanism
>> +				to alert the presence of a messages and/or
>> +				notification
> 
> Isn't this implied by mboxes property?
> 
Yes. But the reason I have added an explicit method is considering other
possible future methods. E.g. SMC is being discussed as one possible
method. And if the function ids become part of some specification, then
only method is sufficient in that case.

Anyways I can drop them if you think it's unnecessary.

[...]

>> +SRAM and Shared Memory for SCMI
>> +-------------------------------
>> +
>> +A small area of SRAM is reserved for SCMI communication between application
>> +processors and SCP.
>> +
>> +The properties should follow the generic mmio-sram description found in [3]
>> +
>> +Each sub-node represents the reserved area for SCMI.
>> +
>> +Required sub-node properties:
>> +- reg : The base offset and size of the reserved area with the SRAM
>> +- compatible : should be "arm,scp-shmem" for Non-secure SRAM based
>> +	       shared memory
> 
> This compatible doesn't match the example.
> 

Ah, sorry for that. Fixed locally as "arm,scmi-shmem" everywhere now and
dropped all juno specific compatibles. I will have a juno specifc
document when it will get used on Juno platform.

-- 
Regards,
Sudeep
