From: eric@anholt.net (Eric Anholt)
Date: Fri, 20 Mar 2015 10:38:51 -0700
Subject: [PATCH 3/4 v4] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <CABb+yY0qN4KcZ9kc6eurSUWPn38f2keKe4FB2efKBAVjREcZbg@mail.gmail.com>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <1426213936-4139-3-git-send-email-eric@anholt.net>
 <5507A095.5090805@wwwdotorg.org> <87619xq414.fsf@eliezer.anholt.net>
 <550BA6B4.3030604@wwwdotorg.org>
 <CABb+yY0qN4KcZ9kc6eurSUWPn38f2keKe4FB2efKBAVjREcZbg@mail.gmail.com>
Message-ID: <87r3sjk1qs.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar <jassisinghbrar@gmail.com> writes:

> On Fri, Mar 20, 2015 at 10:18 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 03/18/2015 05:28 PM, Eric Anholt wrote:
>>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>>
>>>> On 03/12/2015 08:32 PM, Eric Anholt wrote:
>>>>> diff --git a/drivers/mailbox/bcm2835-mailbox.c
>>>>> b/drivers/mailbox/bcm2835-mailbox.c
>>>>
>>>>> +#define MBOX_MSG(chan, data28)             (((data28) & ~0xf) | ((chan) &
>>>>> 0xf)) +#define MBOX_CHAN(msg)                       ((msg) & 0xf) +#define
>>>>> MBOX_DATA28(msg)            ((msg) & ~0xf)
>>>>
>>>> Even the concept of storing channel IDs in the LSBs feels like it
>>>> might be RPi-firmware-specific rather than HW-specific?
>>>
>>> I guess?  If we found another firmware protocol, we could have
>>> that device's dt just specify a different compatible string.  But
>>> in the absence of another firmware to talk to, I'm not sure what
>>> you want here.
>>
>> I would expect the mailbox driver to expose a single channel that just
>> transports 32-bit values, since the HW doesn't impose any kind of
>> structure on the values it transports AFAIK. Clients of the mailbox
>> driver would formulate the messages they send through the mailox using
>> the macros above.
>>
> Yes, it should be so.

I'm getting pretty frustrated here.

So, if I build a global client serializing requests and stop presenting
channels, what exactly is the generic mailbox infrastructure gaining me?
I don't need add_to_rbuf.  I don't need tpoll_txdone.  I don't need
tx_tick.  I don't need peek_data.  I don't need channels.  It doesn't
even handle waiting on requests for me, and I keep having to do it in
clients.  There's nothing left that the generic code is doing for me.

If I have to do any more changes ot this driver (we're at 27 hours of
just my work on it so far...), I'd rather go back to the trivial driver
we had before that simply, obviously did what we wanted.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150320/c18c25a5/attachment.sig>
