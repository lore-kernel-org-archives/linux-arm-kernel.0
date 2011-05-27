From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 May 2011 19:04:56 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <20110527180456.GR24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 04:14:18PM +0200, Joakim BECH wrote:
> write(a, reg1); // Setup hardware
> write(a, reg2); // Setup hardware
> write(a, reg3); // Write bulk data
> write(a, reg3); // Write bulk data ...
> 
> Some of you wrote that the only way to be sure that the data has been
> written is to read the value after writing it. Here we have another problem.
> Since it's a cryptographic device some registers on the hardware are
> write-only, and some registers are actually implemented as a stack in the
> hardware itself. If you write a value to a register it will be pushed onto a
> stack in the hardware and if you read the same register you pop the value
> from the stack in the hardware.

Whichever interface you use on ARM, you will get the writes occuring in
order provided the registers are local to each other.  What you can't
guarantee is the relative ordering of those writes with respect to other
memory accesses, nor when the writes will actually hit the hardware.

(There is hardware which has weird partitioning and allows writes to the
same _device_ to bypass each other and I personally consider this insane.)

> Do you understand my problems and do you have any suggestions for me how to
> handle it? The initial problem, looking at using __raw_writel, was actually
> to improve performance. I noticed about 50% better throughput when I was
> using __raw_writel/readl instead writel/readl, but Linus warned me about the
> problems he mentioned in the initial message in this thread.

If you're writing a stream of data to a register, rather than coding a
for() loop and writel/readl, use readsl or writesl.  These pre-calculate
the cookie->address conversion, and then just get on with writing the
stream to the register.  They don't intersperse a barrier either (and
we don't currently add any barrier to them as we don't expect there to
be any ordering issues with memory accesses.)
