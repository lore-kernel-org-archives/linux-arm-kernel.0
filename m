From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 31 Mar 2014 20:51:54 +0200
Subject: [PATCH] asm-generic: allow generic unaligned access if the arch
 supports it
In-Reply-To: <20140331183618.GY7528@n2100.arm.linux.org.uk>
References: <1395942387-14177-1-git-send-email-ard.biesheuvel@linaro.org>
 <201403281914.20201.arnd@arndb.de>
 <CAKv+Gu_9yD1jWhxkPxSUbwjJk4QxPNXBR=EXfmfCgzD1Pdig2g@mail.gmail.com>
 <20140331095941.GA29871@arm.com>
 <CAKv+Gu_05nmZrQxwELXae4tiK=-MpjUjmEKrULdg+6YuC-DW8Q@mail.gmail.com>
 <20140331172436.GL29871@arm.com>
 <CAKv+Gu9RATUkhya0zytS8FbSM8=49xwNg0m24Xp1LtCWoarDRQ@mail.gmail.com>
 <20140331183618.GY7528@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu9TkLSivLuJH-oWnK0xpFb4jrhYDx6bTZBKUSmSJftCbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 March 2014 20:36, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Mar 31, 2014 at 08:22:43PM +0200, Ard Biesheuvel wrote:
>> On 31 March 2014 19:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > It actually affects arch/arm as well which selects
>> > HAVE_EFFICIENT_UNALIGNED_ACCESS for v6/v7 and uses the generic
>> > unaligned.h
>> >
>>
>> Oops, my bad. I did a quick 'find -name unaligned.h' but misread 'arc'
>> for 'arm'.
>>
>> @Russell: ARM is a user of asm-generic/unaligned.h, and I proposed a
>> patch to asm-generic that switches to unaligned accesses if
>> HAVE_EFFICIENT_UNALIGNED_ACCESS is set by the arch. This should affect
>> a fair amount of code living under net/ and drivers/ that don't test
>> for the Kconfig symbol but expect get_unaligned_xx/put_unaligned_xx to
>> turn into something suitable depending on the arch. Any objections?
>
> I'm not sure what you're talking about here, or what change you're
> proposing.  Without any kind of frame of reference, I can't comment.
> Sorry.
>

My apologies. I assumed the mail thread including a link to the patch
would be clear enough.

Currently, asm-generic's version of unaligned.h (defining stuff like
get_unaligned() and put_unaligned()) unconditionally defaults to the
most cautious method of performing unaligned memory accesses, even if
the Kconfig symbol HAVE_EFFICIENT_UNALIGNED_ACCESS is defined.
However, in that case, it makes sense to use a definition for
get_unaligned()/put_unaligned() that lets the hardware perform the
unaligned accesses instead.

So that is what I proposed here

http://marc.info/?l=linux-arch&m=139594237116121&w=2

and in the mail exchange that followed, I stated that arm64 should be
the only arch affected by this change. However, I didn't look
carefully enough and, as Catalin pointed out, ARM will also be
affected by it.

So that is why I redirected this thread to you: would you object to
changing asm-generic/unaligned.h so that calls to
get_aligned()/put_aligned() on ARM v6/v7 will let the CPU perform the
unaligned access?

Regards,
Ard.
