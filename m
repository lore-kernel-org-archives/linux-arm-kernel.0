From: ccross@android.com (Colin Cross)
Date: Tue, 22 May 2012 11:36:23 -0700
Subject: [PATCH v2] RFC: ARM: cache-l2x0: update workaround for PL310
 errata 727915
In-Reply-To: <20120522093410.GC7286@mudshark.cambridge.arm.com>
References: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
 <CAMQu2gy3VTtQhnVVvzgYGhr_vA=vnW=rSBW17yoBTNwkN3wHqQ@mail.gmail.com>
 <20120522085256.GA7286@mudshark.cambridge.arm.com>
 <4FBB5AE8.4000801@ti.com>
 <20120522093410.GC7286@mudshark.cambridge.arm.com>
Message-ID: <CAMbhsRSJADaXBEpFr2Mk3xm0-c2brYiDUAcY8u1rzP-XwycfBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 2:34 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, May 22, 2012 at 10:22:48AM +0100, Santosh Shilimkar wrote:
>> On Tuesday 22 May 2012 02:22 PM, Will Deacon wrote:
>> > I'm not sure I follow. Which version of the PL310 is in OMAP4460? Are you
>> > saying that the current workaround didn't work but the one in this patch
>> > did? Do you have a testcase?
>> >
>> It's r3p1.
>> IIRC, the errata fix I did(debug register) was only for flush
>> (clean & inv) but Colin found in his testing that it's needed
>> for clean_all as well.
>
> Ok, interesting.
>
>> I don't have testcase. Colin might be able to suggest one.
>
> That would be ideal. Then I can take it up with the hardware guys since I'd
> like to confirm we're not just hiding a different bug with those writes.

I was using an omap 4430, triggering l2x0_clean_all from a GPU ioctl
by calling outer_clean_range(0, ULONG_MAX).  The problem was very
reproducible at the time, and using the persistent_trace code I posted
a while back I was able to narrow it down to hanging the cpu (not an
infinite loop) inside cache_wait_way.  It was 100% reproducible just
booting a development version of Android, but not if I called
l2x0_clean_all during boot, so it may depend on cache state or load.

outer_clean_range() will often get called on a 1080p frame, which is
8MB of data.  Even the set/way clean all is likely to be faster than
cleaning 8MB by MVA in a 1MB L2.
