From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 4 Oct 2017 15:47:55 +0100
Subject: [PATCH v3 02/22] dt-bindings: arm: add support for ARM System
 Control and Management Interface(SCMI) protocol
In-Reply-To: <CAK8P3a3C-xyE-mkj8ERDZHtWbpcOx3Z-gPgHrQHxNVi_3AmAZA@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-3-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a2-7NJTukWaf3=oB9dC+b3uuOGiN+Kc95FS_YBGGHz3ug@mail.gmail.com>
 <c561b2b9-7146-6262-0e9f-fd6511455518@arm.com>
 <CAK8P3a2Vu1SWjYykyXtzjFVmGjm_pAfA1QuTG_X5CHzmtk+WJw@mail.gmail.com>
 <69fc9095-6961-b861-d2e0-afb58de11d59@arm.com>
 <CAK8P3a3C-xyE-mkj8ERDZHtWbpcOx3Z-gPgHrQHxNVi_3AmAZA@mail.gmail.com>
Message-ID: <86fc9060-e0da-3dde-899d-1c4055f15386@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/10/17 15:17, Arnd Bergmann wrote:
> On Wed, Oct 4, 2017 at 3:53 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 04/10/17 13:35, Arnd Bergmann wrote:
>>> On Wed, Oct 4, 2017 at 1:07 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>>>>
>>>> Yes it depends on #clock-cells property. That's the main reason for
>>>> adding #clock-cells
>>>
>>> I'm still unclear on this. Do you mean we look for a subnode with
>>> reg=<0x14> and then assume it's a clock node and require the
>>>  #clock-cells to be there,
>>
>> Yes that's how it's used. Presence of subnode with reg=0x14 indicates
>> clock protocol and #clock-cells to indicate that it's clock provider
>> expecting 1 parameter from consumer which is the clock identifier.
>>
>> or do we look through the sub-nodes to
>>> find one with the #clock-cells property and then look up the 'reg'
>>> property to find out which protocol number to use?
>>>
>>
>> Not this way. Do you see any issues ?
> 
> We normally don't assume that a particular unit address implies
> a specific function. Conventionally that would be done by matching
> the "compatible" property instead.
> 
> What you do clearly works, but it's surprising to the reader.
> 
> 
>>> I think the problem is the way we use the mailbox API in Linux, which
>>> is completely abstract at the moment: it could be a pure doorbell, a
>>> single-register for a data, some structured memory, or a
>>> variable-length message. The assumption today is that the mailbox
>>> user and the mailbox driver agree on the interpretation of that
>>> void pointer.
>>>
>>
>> Unfortunately true.
>>
>>> This breaks down here, as you require the message to be a
>>> variable-length message in a fixed physical location, but assume that
>>> the mailbox serves only as a doorbell.
>>>
>>
>> Yes.
>>
>>> The solution might be to extend the mailbox API slightly, to
>>> have explicit support for variable-length messages, and implement
>>> support for that in either mailbox drivers or as an abstraction
>>> on top of doorbell-type mailboxes.
>>>
>> I got the concept. But are you also suggesting that in bindings it shmem
>> should be associated with mailbox controller rather than client ?
> 
> There are probably several ways of doing this better, we should see
> what the best is we can come up with.
> 
> I think generally speaking we need a way for a mailbox user to
> know what it should use as the mailbox data here, so it is
> able to talk to different incompatible mailbox providers.
> 
> One idea I had is to use a nested mailbox driver, that turns
> a doorbell or single-register styled mailbox into a variable-length
> mailbox by adding a memory region, like
> 
>     mailbox at 1233000 {
>         compatible = "vendor-hardware-specifc-id";
>         interrupts = <34>;
>         reg = <0x1233000 0x100>;
>         #mbox-cells = <1>;
>     };
> 
>     mailbox {
>            compatible = "shmem-mailbox";
>            mboxes = <&/mailbox@1233000  25>;
>            #mbox-cells = <1>;
>            shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
>     };
> 
> This would create one mailbox that only takes a register argument,
> and another one that can take longer messages based on the first.
> In your driver, you then refer to the second one and pass the
> variable-length data into that directly.

1. IIUC it was intentional not to include shmem as part of mailbox
   controller binding and was pushed to client drivers as it's generally
   not part of mailbox IP block. I am not sure if there are any other
   specific reasons for that, but I may be missing some facts.

2. I am not sure if we need nested driver/bindings (at-least to begin
   with). On a platform I don't think both/all modes will be used.
   I had  proposal for adding doorbell for ARM MHU based on extended
   bindings, but it was rejected[1]. But I really preferred that over
   the shim layer I had to add in v3.

--
Regards,
Sudeep

[1] https://patchwork.kernel.org/patch/9745683/
