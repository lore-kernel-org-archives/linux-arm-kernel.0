From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 3 Dec 2012 10:02:24 -0500
Subject: [PATCH v4 13/14] KVM: ARM: Handle guest faults in KVM
In-Reply-To: <20121203130627.GA20074@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154342.2836.9669.stgit@chazy-air>
 <20121119150737.GE3205@mudshark.cambridge.arm.com>
 <CANM98qLNMTw5DGBJLPhXrMs_p5mvphxiEisrz4pLnMFpmm_eCQ@mail.gmail.com>
 <20121203130627.GA20074@mudshark.cambridge.arm.com>
Message-ID: <CANM98qJ74tOEb7_mHJjUhHpkiziORR-ZMYk21yLF_fG9GM88ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 3, 2012 at 8:06 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Nov 30, 2012 at 09:40:37PM +0000, Christoffer Dall wrote:
>> On Mon, Nov 19, 2012 at 10:07 AM, Will Deacon <will.deacon@arm.com> wrote:
>> >
>> > Why are PIPT caches affected by this? The virtual address is irrelevant.
>> >
>>
>> The comment is slightly misleading, and I'll update it. Just so we're
>> clear, this is the culprit:
>>
>> 1. guest uses page X, containing instruction A
>> 2. page X gets swapped out
>> 3. host uses page X, containing instruction B
>> 4. instruction B enters i-cache at page X's cache line
>> 5. page X gets swapped out
>> 6. guest swaps page X back in
>> 7. guest executes instruction B from cache, should execute instruction A
>
> Ok, that's clearer. Thanks for the explanation.
>
>> The point is that with PIPT we can flush only that page from the
>> icache using the host virtual address, as the MMU will do the
>> translation on the fly. In the VIPT we have to nuke the whole thing
>> (unless we .
>
> Unless we what? Could we flush using the host VA + all virtual aliases
> instead?
>
you'd have to know all the virtual addresses of the guest(s) mapping
that physical page and then flush all the aliases of those addresses,
which we don't know at this time.

What we can do (down the road) is to mark the pages as XN, and catch
the fault, get the virtual fault address, and then flush that single
page.

The tradeoffs need to be measured before implementing this imho, and
is an optimization we can add later.

-Christoffer
