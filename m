From: eric@anholt.net (Eric Anholt)
Date: Wed, 04 Mar 2015 10:28:00 -0800
Subject: [PATCH 02/10] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <54F675F1.60205@wwwdotorg.org>
References: <1425329684-23968-1-git-send-email-eric@anholt.net>
 <1425329684-23968-3-git-send-email-eric@anholt.net>
 <54F675F1.60205@wwwdotorg.org>
Message-ID: <871tl48vnz.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 03/02/2015 01:54 PM, Eric Anholt wrote:
>> From: Lubomir Rintel <lkundrak@v3.sk>
>> 
>> Implement BCM2835 mailbox support as a device registered with the
>> general purpose mailbox framework. Implementation based on commits by
>> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
>> implementation.
>
>> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
>
>> +/* Mailboxes */
>> +#define ARM_0_MAIL0	0x00
>> +#define ARM_0_MAIL1	0x20
>> +
>> +/*
>> + * Mailbox registers. We basically only support mailbox 0 & 1. We
>> + * deliver to the VC in mailbox 1, it delivers to us in mailbox 0. See
>> + * BCM2835-ARM-Peripherals.pdf section 1.3 for an explanation about
>> + * the placement of memory barriers.
>> + */
>> +#define MAIL0_RD	(ARM_0_MAIL0 + 0x00)
>> +#define MAIL0_POL	(ARM_0_MAIL0 + 0x10)
>> +#define MAIL0_STA	(ARM_0_MAIL0 + 0x18)
>> +#define MAIL0_CNF	(ARM_0_MAIL0 + 0x1C)
>> +#define MAIL1_WRT	(ARM_0_MAIL1 + 0x00)
>
> That implies there are more mailboxes. I wonder if we should
> parameterize which to use via some DT properties? I guess we can defer
> that though; we can default to the current values and add properties
> later if we want to use something else.

BCM2835-ARM-Peripherals.pdf:

"Default the interrupts from doorbell 0,1 and mailbox 0 go to the ARM
this means that these resources should be written by the GPU and read by
the ARM. The opposite holds for doorbells 2, 3 and mailbox 1."

I don't see any references to more mailboxes than 0 and 1.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/0aa1d5b5/attachment.sig>
