From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 23 Nov 2009 22:28:30 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B08055C.3000408@45mercystreet.com>
Message-ID: <20091123222830.GA5598@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Toby Douglass wrote:
> Load-linked/conditional-store architectures solve ABA by having the 
> store fail if the destination has been touched since the load was performed.
> 
> Currently, the code appears to violate this, by repeating the CAS 
> *anyway*.  In fact, the appropriate behaviour would seem to be *not* to 
> loop, but rather, to issue the ldrex/strex *once*, and indicate to the 
> user if the store succeed or failed.

I believe Catalin's explained why it does not work even doing
LDREX/STREX once, because the thread can pause before the LDREX.  So
you must begin fetching pointers after the LDREX.

(At least I think so.  I'm prepared to be shown to be wrong :-)

If you're writing code intended for other LL/SC architectures too, and
following Catalin's suggestion to put LDR between LDREX and STREX,
then you might have to check if the other architectures permit loads
between the LL and SC.

> This requires a prototype change, because the return value is the 
> original value of the destination and so is unable to indicate, when 
> returning that value, if it is returned from a successful or 
> unsuccessful swap.

Nonetheless, such a prototype change might be an improvement anyway.

Some platforms provide compare_and_swap_bool() operations, which do as
you describe: Compare, conditionally store, and return bool to indicate
success.  No loop.

That could be an improvement for some algorithms, because often if the
store doesn't happen, the *inputs* to compare_and_swap() need to be
recalculated anyway before another try is likely to succeed.  What's
the point in having code which expands to two loops:

    do {
       old = get_something;
       new = calc_something;

       /* oldval = compare_and_swap(ptr, old, new); */
       do {
           __asm__("LL/SC" : (failed), (oldval) : (ptr), (old), (new));
       } while (failed && oldval == old);

    } while (oldval != old);

When it can often be a smaller loop, which probably executes a little
faster too in various cases:

    do {
       old = get_something;
       new = calc_something;

       /* oldval = compare_and_swap_bool(ptr, old, new); */
       __asm__("LL/SC" : (failed), (oldval) : (ptr), (old), (new));

    } while (failed);

-- Jamie
