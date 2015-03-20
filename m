From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 20 Mar 2015 10:42:35 +0530
Subject: [PATCH 3/4 v4] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <550BA6B4.3030604@wwwdotorg.org>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <1426213936-4139-3-git-send-email-eric@anholt.net>
 <5507A095.5090805@wwwdotorg.org>
 <87619xq414.fsf@eliezer.anholt.net>
 <550BA6B4.3030604@wwwdotorg.org>
Message-ID: <CABb+yY0qN4KcZ9kc6eurSUWPn38f2keKe4FB2efKBAVjREcZbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 10:18 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 03/18/2015 05:28 PM, Eric Anholt wrote:
>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>
>>> On 03/12/2015 08:32 PM, Eric Anholt wrote:
>>>> diff --git a/drivers/mailbox/bcm2835-mailbox.c
>>>> b/drivers/mailbox/bcm2835-mailbox.c
>>>
>>>> +#define MBOX_MSG(chan, data28)             (((data28) & ~0xf) | ((chan) &
>>>> 0xf)) +#define MBOX_CHAN(msg)                       ((msg) & 0xf) +#define
>>>> MBOX_DATA28(msg)            ((msg) & ~0xf)
>>>
>>> Even the concept of storing channel IDs in the LSBs feels like it
>>> might be RPi-firmware-specific rather than HW-specific?
>>
>> I guess?  If we found another firmware protocol, we could have
>> that device's dt just specify a different compatible string.  But
>> in the absence of another firmware to talk to, I'm not sure what
>> you want here.
>
> I would expect the mailbox driver to expose a single channel that just
> transports 32-bit values, since the HW doesn't impose any kind of
> structure on the values it transports AFAIK. Clients of the mailbox
> driver would formulate the messages they send through the mailox using
> the macros above.
>
Yes, it should be so.

> I'm not sure whether the mailbox core allows multiple clients for the
> same mailbox channel though? This HW appears to require it.
>
There were tradeoffs to granting shared vs exclusive access, we chose
latter. The platform could have a global client that serializes
requests and dispatch received data to exact destination rather than
mbox core iterating over all users of the channel. Some platform may
require to execute 2 or more commands 'atomically', which would be
messy if channels are shared.
