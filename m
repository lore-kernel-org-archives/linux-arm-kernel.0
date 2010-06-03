From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 3 Jun 2010 16:27:04 +0800
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <20100603080043.GC336@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<AANLkTim-U76fy_N6bfhJ0BFihDrW1YEcJXDyEqtajc8c@mail.gmail.com>
	<20100603080043.GC336@pengutronix.de>
Message-ID: <AANLkTik7NEywnBFz6ul7jNKkiDfX5wS-3BP8F1Cyyw5r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hi Eric,
>
> On Thu, Jun 03, 2010 at 03:43:30PM +0800, Eric Miao wrote:
>> On Thu, Jun 3, 2010 at 3:36 PM, Eric Miao <eric.miao@canonical.com> wrote:
>> > Several facts:
>> >
>> > 1. ZRELADDR in most cases can be auto detected by maksing PC with
>> > ? 0xf000_0000 if the zImage is placed within the first 256MiB from
>> > ? the memory start, which is a sane assumption except for:
>> >
>> > ? - when ARCH_MX1 or ARCH_SHARK is defined
>> > ? - when ARCH_U300 is defined (U300 really is strange when defining
>> > ? ? PHYS_OFFSET and ZRELADDR)
>> > ? - or when ZBOOT_ROM is defined
>> >
>>
>> And maybe we could restrict the assumption to 128MB, so that MX1
>> and SHARK can be included as well.
> I used 128 MiB, too. ?When I did it I found "problems" for s3c2400 and
> at91. ?For the latter physoffset depended on .config.
>

Yeah, there are some platforms really makes me scratching my head.
For the problem of PHYS_OFFSET actually, not necessarily ZRELADDR.
(I've again reviewed your previous patches, and think maybe we can
possibly work together to bring them to the list again)

1. S3C2400 PHYS_OFFSET == 0x0c00_0000 which is on a 64MB boundary.
I guess we can simply drop support for such platforms. Restricting the
assumption to even smaller is not fair for most other platforms.

2. AT91 is actually much better.

3. The most weird platform must be U300, that PHYS_OFFSET is really
something variable. Depending on a somewhat access processor (I guess
it's a communication processor/MODEM). While for U300, I guess a proper
way for it to do is to declare a high enough TEXT_OFFSET and use .fixup
to reserve a range of memory for the access processor if possible.

Yet we don't have to support those platforms. The complex of the problem
is really: how to support as many platforms as possible yet still leave a
smooth migration path, and a fall-back way for those silicon simply just
cannot do auto detection at run-time, and the different boot method:
ZROM/XIP (and possibly bootp)
