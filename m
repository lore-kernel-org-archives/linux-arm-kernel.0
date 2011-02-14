From: andreiw@motorola.com (Andrei Warkentin)
Date: Mon, 14 Feb 2011 16:25:48 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102142122.54766.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102131839.08517.arnd@arndb.de>
	<AANLkTin=bkzvdQXoWUKRfX8Xs=4bXnxWf88TUG+VvjPD@mail.gmail.com>
	<201102142122.54766.arnd@arndb.de>
Message-ID: <AANLkTinPtiwXmtRy9qS2zZXwuhQDOyO-H8-wmF=fSNnJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 2:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> As I mentioned, I am checking with T right now on whether we can use
>> suggestion (1) or
>> suggestion (2) or if they need to be combined. The documentation we
>> got was open to interpretation and the patch created from that did
>> both.
>> You mentioned that writing in reverse is not a good idea. Could you
>> elaborate why? I would guess because you're always causing a write
>> into a different AU (on these Toshiba cards), causing extra GC on
>> every write?
>
> Probably both the reliable write and writing small blocks in reverse
> order will cause any card to do something that is different from
> what it does on normal 64kb (or larger) aligned accesses.
>
> There are multiple ways how this could be implemented:
>
> 1. Have one exception cache for all "special" blocks. This would normally
> ? be for FAT32 subdirectory updates, which always write to the same
> ? few blocks. This means you can do small writes efficiently anywhere
> ? on the card, but only up to a (small) fixed number of block addresses.
> ? If you overflow the table, the card still needs to go through an
> ? extra PE for each new entry you write, in order to free up an entry.
>
> 2. Have a small number of AUs that can be in a special mode with efficient
> ? small writes but inefficient large writes. This means that when you
> ? alternate between small and large writes in the same AU, it has to go
> ? through a PE on every switch. Similarly, if you do small writes to
> ? more than the maximum number of AUs that can be held in this mode, you
> ? get the same effect. This number can be as small as one, because that
> ? is what FAT32 requires.
>
> In both cases, you don't actually have a solution for the problem, you just
> make it less likely for specific workloads.

Aha, ok. By the way, I did find out that either suggestion works. So
I'll pull out the reversing portion of the patch. No need to
overcomplicate :).
