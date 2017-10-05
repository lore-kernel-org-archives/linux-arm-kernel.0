From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Oct 2017 13:56:16 +0200
Subject: [PATCH v3 02/22] dt-bindings: arm: add support for ARM System
 Control and Management Interface(SCMI) protocol
In-Reply-To: <86fc9060-e0da-3dde-899d-1c4055f15386@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-3-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a2-7NJTukWaf3=oB9dC+b3uuOGiN+Kc95FS_YBGGHz3ug@mail.gmail.com>
 <c561b2b9-7146-6262-0e9f-fd6511455518@arm.com>
 <CAK8P3a2Vu1SWjYykyXtzjFVmGjm_pAfA1QuTG_X5CHzmtk+WJw@mail.gmail.com>
 <69fc9095-6961-b861-d2e0-afb58de11d59@arm.com>
 <CAK8P3a3C-xyE-mkj8ERDZHtWbpcOx3Z-gPgHrQHxNVi_3AmAZA@mail.gmail.com>
 <86fc9060-e0da-3dde-899d-1c4055f15386@arm.com>
Message-ID: <CAK8P3a2+tXNpYxot-OFRNeVhrDA=VN4Ui8KhuRynHgcL+Ch9ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 4:47 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 04/10/17 15:17, Arnd Bergmann wrote:
>> On Wed, Oct 4, 2017 at 3:53 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> On 04/10/17 13:35, Arnd Bergmann wrote:
>>>> On Wed, Oct 4, 2017 at 1:07 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

>> There are probably several ways of doing this better, we should see
>> what the best is we can come up with.
>>
>> I think generally speaking we need a way for a mailbox user to
>> know what it should use as the mailbox data here, so it is
>> able to talk to different incompatible mailbox providers.
>>
>> One idea I had is to use a nested mailbox driver, that turns
>> a doorbell or single-register styled mailbox into a variable-length
>> mailbox by adding a memory region, like
>>
>>     mailbox at 1233000 {
>>         compatible = "vendor-hardware-specifc-id";
>>         interrupts = <34>;
>>         reg = <0x1233000 0x100>;
>>         #mbox-cells = <1>;
>>     };
>>
>>     mailbox {
>>            compatible = "shmem-mailbox";
>>            mboxes = <&/mailbox@1233000  25>;
>>            #mbox-cells = <1>;
>>            shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
>>     };
>>
>> This would create one mailbox that only takes a register argument,
>> and another one that can take longer messages based on the first.
>> In your driver, you then refer to the second one and pass the
>> variable-length data into that directly.
>
> 1. IIUC it was intentional not to include shmem as part of mailbox
>    controller binding and was pushed to client drivers as it's generally
>    not part of mailbox IP block. I am not sure if there are any other
>    specific reasons for that, but I may be missing some facts.

Ok, I see.

> 2. I am not sure if we need nested driver/bindings (at-least to begin
>    with). On a platform I don't think both/all modes will be used.
>    I had  proposal for adding doorbell for ARM MHU based on extended
>    bindings, but it was rejected[1]. But I really preferred that over
>    the shim layer I had to add in v3.

Maybe we can come up with a more generic way to do doorbells
on top of mailboxes instead? This sounds like a problem that
would come back with other drivers, so the MHU-specific shim
will not be a permanent solution either.

       Arnd
