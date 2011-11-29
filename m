From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Nov 2011 22:00:48 +0000
Subject: [PATCH] ARM: errata: Remove SMP dependency for erratum 751472
In-Reply-To: <20111129180618.GB2872@localhost.localdomain>
References: <1322586763-12791-1-git-send-email-dave.martin@linaro.org>
 <20111129173537.GJ9581@n2100.arm.linux.org.uk>
 <20111129180618.GB2872@localhost.localdomain>
Message-ID: <20111129220048.GO9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 06:06:18PM +0000, Dave Martin wrote:
> One thing which strikes me about ALT_UP_B() is that the likely use is
> to skip over the SMP case code (which may consist of many instructions).
> This means that if the SMP code is not there at all (as in a UP kernel)
> no branch is necessary.

It's there to solve the case in the IRQ entry code, where it's use is
already bounded by a #ifdef CONFIG_SMP.

> An alternative would be for the ALT_UP_B() actually to disappear in a
> UP kernel.  So far as I can see, such an implementation would be
> compatible with all existing uses of this macro.  What do you think?

That sounds dangerous, adding unexpected behaviour to the code.  For
example:

#ifdef CONFIG_SMP
        /*
         * XXX
         *
         * this macro assumes that irqstat (r2) and base (r6) are
         * preserved from get_irqnr_and_base above
         */
        ALT_SMP(test_for_ipi r0, r2, r6, lr)
        ALT_UP_B(9997f)
        movne   r1, sp
        adrne   lr, BSYM(1b)
        bne     do_IPI
#endif

If the surrounding ifdef goes away, and the ALT_UP_B() ends up being
optimized to nothing, then we no longer skip over this code.  So no,
it's not compatible with existing uses.
