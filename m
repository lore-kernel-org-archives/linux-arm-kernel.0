From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 14:35:08 +0200
Subject: [PATCH v3 02/22] dt-bindings: arm: add support for ARM System
 Control and Management Interface(SCMI) protocol
In-Reply-To: <c561b2b9-7146-6262-0e9f-fd6511455518@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-3-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a2-7NJTukWaf3=oB9dC+b3uuOGiN+Kc95FS_YBGGHz3ug@mail.gmail.com>
 <c561b2b9-7146-6262-0e9f-fd6511455518@arm.com>
Message-ID: <CAK8P3a2Vu1SWjYykyXtzjFVmGjm_pAfA1QuTG_X5CHzmtk+WJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 1:07 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Arnd,
>
> Thanks for taking a look at this.
>
> On 04/10/17 11:50, Arnd Bergmann wrote:
>> On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> +
>>> +The SCMI is intended to allow agents such as OSPM to manage various functions
>>> +that are provided by the hardware platform it is running on, including power
>>> +and performance functions.
>>> +
>>> +This binding is intended to define the interface the firmware implementing
>>> +the SCMI as described in ARM document number ARM DUI 0922B ("ARM System Control
>>> +and Management Interface Platform Design Document")[0] provide for OSPM in
>>> +the device tree.
>>> +
>>> +Required properties:
>>> +
>>> +The scmi node with the following properties shall be under the /firmware/ node.
>>> +
>>> +- compatible : shall be "arm,scmi"
>>> +- mboxes: List of phandle and mailbox channel specifiers. It should contain
>>> +         exactly one or two mailboxes, one for transmitting messages("tx")
>>> +         and another optional for receiving the notifications("rx") if
>>> +         supported.
>>> +- mbox-names: shall be "tx" or "rx"
>>
>> The example below does not have the mbox-names property. If you require
>> exactly two mailboxes, why do you need the names anyway?
>>
>
> Good question. I can drop it, but would like to keep in case we need to
> extend it in future. We can always use then to identify.

I don't think it's necessary, as long you always need to have the first two,
but it doesn't hurt either.

Just make the description match the example.

>> However, your example does have a #addresss-cells/#size-cells
>> property that are not documented here. Please add them here as either
>> optional or required, and describe what the permitted values are and
>> how the address is interpreted.
>>
>
> Ah right, I didn't notice that. I will add it. It was added to provide
> the protocol number in "reg" property.
...
>> How does the OS identify the fact that a subnode uses the clock binding?
>> Do you need to look for the #clock-cells property, or is this based on the
>> unit address?
>>
>
> Yes it depends on #clock-cells property. That's the main reason for
> adding #clock-cells

I'm still unclear on this. Do you mean we look for a subnode with
reg=<0x14> and then assume it's a clock node and require the
 #clock-cells to be there, or do we look through the sub-nodes to
find one with the #clock-cells property and then look up the 'reg'
property to find out which protocol number to use?

>>> +- shmem : List of phandle pointing to the shared memory(SHM) area as per
>>> +         generic mailbox client binding.
>>> +
>>> +See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
>>> +about the generic mailbox controller and client driver bindings.
>>> +
>>> +The mailbox is the only permitted method of calling the SCMI firmware.
>>> +Mailbox doorbell is used as a mechanism to alert the presence of a
>>> +messages and/or notification.
>>
>> This looks odd: why not make the message itself part of the mailbox
>> protocol here, and leave the shmem as a implementation detail of the
>> mailbox driver?
>>
>
> I am not sure if I follow you here. But generally shmem can be memory
> carved out of anything in the system and it's dependent on the protocol
> and the remote firmware rather than the mailbox hardware itself.

I think the problem is the way we use the mailbox API in Linux, which
is completely abstract at the moment: it could be a pure doorbell, a
single-register for a data, some structured memory, or a
variable-length message. The assumption today is that the mailbox
user and the mailbox driver agree on the interpretation of that
void pointer.

This breaks down here, as you require the message to be a
variable-length message in a fixed physical location, but assume that
the mailbox serves only as a doorbell.

The solution might be to extend the mailbox API slightly, to
have explicit support for variable-length messages, and implement
support for that in either mailbox drivers or as an abstraction
on top of doorbell-type mailboxes.

      Arnd
