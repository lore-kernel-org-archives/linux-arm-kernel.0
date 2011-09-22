From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Sep 2011 21:14:56 +0100
Subject: [PATCH] ARM: futex: preserve oldval in SMP __futex_atomic_op
In-Reply-To: <alpine.LFD.2.00.1109221449470.12663@xanadu.home>
References: <1316716500-25376-1-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1109221449470.12663@xanadu.home>
Message-ID: <20110922201456.GA10140@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 08:09:41PM +0100, Nicolas Pitre wrote:
> On Thu, 22 Sep 2011, Will Deacon wrote:
> 
> > The SMP implementation of __futex_atomic_op clobbers oldval with the
> > status flag from the exclusive store. This causes it to always read as
> > zero when performing the FUTEX_OP_CMP_* operation.
> > 
> > This patch updates the ARM __futex_atomic_op implementations to take a
> > tmp argument, allowing us to store the strex status flag without
> > overwriting the register containing oldval.
> > 
> > Cc: stable at kernel.org
> > Reported-by: Minho Ben <mhban@samsung.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks Nicolas, I'll put this into the patch system tomorrow.

> > ---
> > 
> > Following up on:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/066348.html
> > 
> > it turns out that we don't need to use named arguments after all,
> > although it might be nice to add that as a later patch. For now, I'm
> > trying to keep this as small as possible for -stable.
> 
> Agreed that named arguments would make this code more obvious, 
> especially with the insn argument of __futex_atomic_op() which uses 
> numbered registers away from the actual inline asm statement where it is 
> used.

Yup, I'll post this as a separate patch in the future.

> I'm a bit worried that the LTP tests still passed though.  In theory it 
> shouldn't have worked at all except if you were lucky with test values.

Urgh, I just looked at the implementation of the tests I ran; all they do is
check that the {set,get}_robust_list system calls return -1 when passed
invalid argument combinations. No wonder they passed...

Will
