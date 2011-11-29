From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 29 Nov 2011 18:06:18 +0000
Subject: [PATCH] ARM: errata: Remove SMP dependency for erratum 751472
In-Reply-To: <20111129173537.GJ9581@n2100.arm.linux.org.uk>
References: <1322586763-12791-1-git-send-email-dave.martin@linaro.org>
 <20111129173537.GJ9581@n2100.arm.linux.org.uk>
Message-ID: <20111129180618.GB2872@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 05:35:37PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 29, 2011 at 05:12:43PM +0000, Dave Martin wrote:
> > -	cmp	r6, #0x30			@ present prior to r3p0
> > +	ALT_UP_B(1f)
> > +	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0
> 
> Why not look at the definition of these before you (ab)use them?

Sorry -- I did look, but it looks like I confused myself afterwards, because
of the way the instruction to skip the SMP block has to be inserted in
between the first and second instructions of the block being skipped,
rather than at the start (as would happen in a conditional branch).

Do you have any concerns about that other than the ALT_SMP/UP being the
wrong way around?


One thing which strikes me about ALT_UP_B() is that the likely use is
to skip over the SMP case code (which may consist of many instructions).
This means that if the SMP code is not there at all (as in a UP kernel)
no branch is necessary.  But the definition is more conservative, so
that we're left with a branch jumping to the next instruction even in a
UP kernel.  The effect is that we really can branch to anywhere with
ALT_UP_B() -- a potentially useful feature, but one which we don't
currently appear to make use of.

An alternative would be for the ALT_UP_B() actually to disappear in a
UP kernel.  So far as I can see, such an implementation would be
compatible with all existing uses of this macro.  What do you think?

Cheers
---Dave
