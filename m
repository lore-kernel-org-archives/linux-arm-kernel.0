From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Sep 2010 22:06:49 +0100
Subject: [RFC] mmaping with VIVT cache
In-Reply-To: <589851.42712.qm@web120206.mail.ne1.yahoo.com>
References: <589851.42712.qm@web120206.mail.ne1.yahoo.com>
Message-ID: <20100917210649.GA18343@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 17, 2010 at 12:07:50PM -0700, P F wrote:
> From your comment, I take it that there is no kernel API to invalidate the
> cache of a range in a VMA.  Do you think linux-mm would be a more
> appropriate forum to continue investigating?  Any input would be
> appreciated.

That's not really the point.  To implement an API in terms of "it
invalidates a range in a VMA" is absurd when you have a kernel
supporting VIVT, VIVT with an address space tag, VIPT, VIPT with
address space tag, PIPT, etc.  Does it mean you have to invalidate
for every different kind of cache?  If you define it in terms of
"invalidates a range in a VMA" then yes it does - even if a cache
architecture doesn't need it.

It's much better to define APIs in terms of their purpose - such as
"we're tearing down MMU mappings, so flush this range in the VMA".
That allows implementations to say "do I need to do anything when
this operation occurs?  No - I can optimize it away."

The problem we face is that you wouldn't port a Unix-like OS to a
CPU with VIVT caches if you were in a sane state of mind...  It
is the worst for aliasing issues, such as the one you've found.  As
ARM is the only Linux arch which has VIVT caches, we trip over many
of these issues.

However, in this case, architectures using VIPT aliasing caches will
also trip over it - has anyone used this webcam on something like
Sparc or powerpc?  I'm guessing that it'll fail there too...
