From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 5 Oct 2017 06:20:17 -0700
Subject: [PATCH v3 02/22] dt-bindings: arm: add support for ARM System
 Control and Management Interface(SCMI) protocol
In-Reply-To: <CAK8P3a2Vu1SWjYykyXtzjFVmGjm_pAfA1QuTG_X5CHzmtk+WJw@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-3-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a2-7NJTukWaf3=oB9dC+b3uuOGiN+Kc95FS_YBGGHz3ug@mail.gmail.com>
 <c561b2b9-7146-6262-0e9f-fd6511455518@arm.com>
 <CAK8P3a2Vu1SWjYykyXtzjFVmGjm_pAfA1QuTG_X5CHzmtk+WJw@mail.gmail.com>
Message-ID: <CABb+yY2Td+FubKJDedgbpnFCag608VZ2RAhW0qKoJ_9Jjh_k7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 5:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Oct 4, 2017 at 1:07 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 04/10/17 11:50, Arnd Bergmann wrote:
>>> On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

>
>>>> +- shmem : List of phandle pointing to the shared memory(SHM) area as per
>>>> +         generic mailbox client binding.
>>>> +
>>>> +See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
>>>> +about the generic mailbox controller and client driver bindings.
>>>> +
>>>> +The mailbox is the only permitted method of calling the SCMI firmware.
>>>> +Mailbox doorbell is used as a mechanism to alert the presence of a
>>>> +messages and/or notification.
>>>
>>> This looks odd: why not make the message itself part of the mailbox
>>> protocol here, and leave the shmem as a implementation detail of the
>>> mailbox driver?
>>>
>>
>> I am not sure if I follow you here. But generally shmem can be memory
>> carved out of anything in the system and it's dependent on the protocol
>> and the remote firmware rather than the mailbox hardware itself.
>
> I think the problem is the way we use the mailbox API in Linux, which
> is completely abstract at the moment: it could be a pure doorbell, a
> single-register for a data, some structured memory, or a
> variable-length message. The assumption today is that the mailbox
> user and the mailbox driver agree on the interpretation of that
> void pointer.
>
The way controllers and remote firmwares are paired there is no other
way to write reusable code.

> This breaks down here, as you require the message to be a
> variable-length message in a fixed physical location, but assume that
> the mailbox serves only as a doorbell.
>
That is a valid usecase, already supported. There's an optional
callback provided by the api to fill SHMEM
mbox_chan->mbox_client->tx_prepare()

Data passing via SHMEM is purely optional because some controllers
have deep fifos to carry data while some platforms may not have any
region of memory shared between Linux and the remote firmware.

Thanks.
