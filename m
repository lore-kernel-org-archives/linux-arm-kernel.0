From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Nov 2009 15:59:26 +0000
Subject: CAS implementation may be broken
In-Reply-To: <20091123222830.GA5598@shareable.org>
References: <20091123222830.GA5598@shareable.org>
Message-ID: <1259078366.16239.14.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-11-23 at 22:28 +0000, Jamie Lokier wrote:
> Toby Douglass wrote:
> > Load-linked/conditional-store architectures solve ABA by having the
> > store fail if the destination has been touched since the load was performed.
> >
> > Currently, the code appears to violate this, by repeating the CAS
> > *anyway*.  In fact, the appropriate behaviour would seem to be *not* to
> > loop, but rather, to issue the ldrex/strex *once*, and indicate to the
> > user if the store succeed or failed.
> 
> I believe Catalin's explained why it does not work even doing
> LDREX/STREX once, because the thread can pause before the LDREX.  So
> you must begin fetching pointers after the LDREX.
> 
> (At least I think so.  I'm prepared to be shown to be wrong :-)
> 
> If you're writing code intended for other LL/SC architectures too, and
> following Catalin's suggestion to put LDR between LDREX and STREX,
> then you might have to check if the other architectures permit loads
> between the LL and SC.

That's a good point. ARM doesn't allow this either, though probably
current implementations don't have any problem with it. From the ARM ARM
A3.4.5:

        An implementation might clear an exclusive monitor between the
        LDREX and the STREX, without any application-related cause. For
        example, this might happen because of cache evictions. Code
        written for such an implementation must avoid having any
        *explicit memory accesses* or cache maintenance operations
        between the LDREX and STREX instructions

So on some future implementations it could live-lock.

-- 
Catalin
