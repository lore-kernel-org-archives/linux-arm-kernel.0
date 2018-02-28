From: samuel@sholland.org (Samuel Holland)
Date: Wed, 28 Feb 2018 11:51:59 -0600
Subject: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
In-Reply-To: <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
Message-ID: <d9e14058-6ffb-e54a-1565-f228342ee1f0@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/28/18 03:16, Jassi Brar wrote:
> On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
> ....
> 
>> +/*
>> + * The message box hardware provides 8 unidirectional channels. As the mailbox
>> + * framework expects them to be bidirectional
>>
> That is incorrect. Mailbox framework does not require a channel to be
> TX and RX capable.

Sorry, it would be more accurate to say that the intended mailbox _client_
expects the channels to be bidirectional.

> You should expose each channel as per its physical capability, let the
> client configure it for direction (if its bidirectional) and acquire
> separate channels for RX and TX if it needs to.

Is there any way for the mailbox framework to inform the client that a channel
is uni/bidirectional? Or if the channel supports RX/TX specifically? I couldn't
find any.

It looks like all of the clients assume one case or the other, based on the
hardware they were initially designed to support. For example arm_scpi expects
one channel per client, while ti_sci and st_remoteproc expect two separate RX
and TX channels per client.

Since there's no API for the client to know the hardware properties, modifying
arm_scpi to support unidirectional mailbox channels would break support for all
existing bidirectional mailboxes.

To expose the physical channels individually, there would need to be an API to:
a) Determine if a mailbox channel supports unidirectional or bidirectional
   operation.
b) If a channel is unidirectional, determine which direction(s) it supports.
c) If a unidirectional channel supports both directions, configure which
   direction it should run in.

Since that API doesn't currently exist, I wrote the driver to match what the
intended client expected (as all other mailbox controller drivers currently do).

> Cheers!

Regards,
Samuel
