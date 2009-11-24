From: trd@45mercystreet.com (Toby Douglass)
Date: Tue, 24 Nov 2009 17:34:38 +0100
Subject: CAS implementation may be broken
In-Reply-To: <20091123222830.GA5598@shareable.org>
References: <20091123222830.GA5598@shareable.org>
Message-ID: <4B0C0B1E.9070902@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Lokier wrote:
> Toby Douglass wrote:
>> Load-linked/conditional-store architectures solve ABA by having the 
>> store fail if the destination has been touched since the load was performed.
>>
>> Currently, the code appears to violate this, by repeating the CAS 
>> *anyway*.  In fact, the appropriate behaviour would seem to be *not* to 
>> loop, but rather, to issue the ldrex/strex *once*, and indicate to the 
>> user if the store succeed or failed.
> 
> I believe Catalin's explained why it does not work even doing
> LDREX/STREX once, because the thread can pause before the LDREX.  So
> you must begin fetching pointers after the LDREX.

Yes.  I'm now getting around to digesting the posts after Catalin's and 
I see here people have already pointed out the things I worked out =-)

> (At least I think so.  I'm prepared to be shown to be wrong :-)

Well - it doesn't save you - you could LDREX, then LDR - and *then* 
pause.  Then the freelist completely changes, but the original element 
is moved back to the top.  Then you continue.  You fail to swap, since 
the destination has changed...ah, wait!  it *does* save you.  Of course, 
you're dead if you loop again, so you need to exit at this point.

Now I'm wondering what I was thinking before, in my earlier email to the 
list...!

> If you're writing code intended for other LL/SC architectures too, and
> following Catalin's suggestion to put LDR between LDREX and STREX,
> then you might have to check if the other architectures permit loads
> between the LL and SC.

As Catalin has pointed out, this in fact is not allowed on ARM.  So it 
doesn't save us (well, me :-) after all and in fact I look stuffed, as 
far as LL/SC is concerned; I have to use double-word LDREX and a 
pointer-counter pair.

So LL/SC on ARM is not an ABA solution.  It merely is a RISC-style 
implementation of what on CISC is a single instruction.

>> This requires a prototype change, because the return value is the 
>> original value of the destination and so is unable to indicate, when 
>> returning that value, if it is returned from a successful or 
>> unsuccessful swap.
> 
> Nonetheless, such a prototype change might be an improvement anyway.
> 
> Some platforms provide compare_and_swap_bool() operations, which do as
> you describe: Compare, conditionally store, and return bool to indicate
> success.  No loop.

Ah, well, I also like to receive the original value of the destination, 
if the CAS had to load it, since I'm going to have to load it again 
myself in most cases.

In the case where the CAS fails because the compare fails, the freshly 
loaded destination value is useful.

In the case where the CAS fails because the destination is touched by 
another thread, the freshly loaded destination is almost never useful 
(unless it was modified by the other thread to be the same value).

> That could be an improvement for some algorithms, because often if the
> store doesn't happen, the *inputs* to compare_and_swap() need to be
> recalculated anyway before another try is likely to succeed.

Exactly!

In fact, this is what happens in *every* algorithm I'm implemented (a 
grand total of two, mind you, stack and queue, but I know it also 
happens for the singly linked list).
