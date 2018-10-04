From: bp@alien8.de (Borislav Petkov)
Date: Thu, 4 Oct 2018 17:15:55 +0200
Subject: [PATCH v6 00/18] APEI in_nmi() rework
In-Reply-To: <c04d1b78-122b-d7f2-5a75-3d9c56386b11@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180925124526.GD23986@zn.tnic>
 <c04d1b78-122b-d7f2-5a75-3d9c56386b11@arm.com>
Message-ID: <20181004151555.GN1864@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 06:50:38PM +0100, James Morse wrote:

...

> The non-ghes HEST entries have a "number of records to pre-allocate" too, we
> could make this memory pool something hest.c looks after, but I can't see if the
> other error sources use those values.

Thanks for the detailed analysis!

> Hmmm, The size is capped to 64K, we could ignore the firmware description of the
> memory requirements, and allocate SZ_64K each time. Doing it per-GHES is still
> the only way to avoid allocating nmi-safe memory for irqs.

Right, so I'm thinking a lot simpler: allocate a pool which should
be large enough to handle all situations and drop all that logic
which recomputes and reallocates pool size. Just a static thing which
JustWorks(tm).

For a couple of reasons:

 - you state it above: all those synchronization issues are gone with a
 prellocated pool

 - 64K per-GHES pool is nothing if you consider the machines this thing
 runs on - fat servers with lotsa memory. And RAS there *is* important.
 And TBH 64K is nothing even on a small client sporting gigabytes of
 memory.

 - code is a lot simpler and cleaner - you don't need all that pool
 expanding and shrinking. I mean, I'm all for smarter solutions if they
 have any clear advantages warranting the complication but this is a
 lot of machinery just so that we can save a couple of KBs. Which, as a
 whole, sounds just too much to me.

But this is just me.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
