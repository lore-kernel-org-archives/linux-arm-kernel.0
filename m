From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 May 2011 16:02:42 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <20110527150242.GB14035@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 03:14:18PM +0100, Joakim BECH wrote:
> I get a bit confused about the feedback in this issue. Listening to Russel
> and Arnd I get the impression to not even think about using __raw_writel.
> But from Catalin's answer I got the impression it's indeed possible to use
> __raw_writel on an ARM architecture and I'm writing to such a device. Could
> you please clarify this?

I would advise for using either writel() or writel_relaxed(), depending
on your needs but not using the __raw_writel() directly. (even though on
little endian configurations it is the same as the relaxed variant). The
latter is the raw implementation used by the other accessors.

I think Arnd's point was that the writel_relaxed() variant may be even
more relaxed on other architectures than it is on ARM. I can't talk
about them.

> In my particular setup I'm writing a driver that is talking to a crypto
> hardware and the architecture is ARM. The hardware is mapped as io-mapped
> memory in our driver. Our main problem is to program the hardware, by
> writing to certain registers in order and when the hardware is ready to
> accept input, we will write the bulk-data to the same register over and over
> again until there is no more data. I.e. in principle we do like this (a bit
> simplified).
> 
> write(a, reg1); // Setup hardware
> write(a, reg2); // Setup hardware
> write(a, reg3); // Write bulk data
> write(a, reg3); // Write bulk data ...
> 
> Some of you wrote that the only way to be sure that the data has been
> written is to read the value after writing it.

The question is - why do you need to make sure that the data has been
written? To me it looks like you only care about register access
ordering.

Writing the device registers will always be done in program order, so
your data in reg3 will be written after you set up the hardware via reg1
and reg2. The reading back isn't needed and you could even use the
relaxed accessors.

There are exceptions depending on your device. If the specs explicitly
ask for certain delay between writing reg1/reg2 and pushing the data in
reg3, than you have need take this into account (using either udelay or
some read back from the device).

> Here we have another problem.
> Since it's a cryptographic device some registers on the hardware are
> write-only, and some registers are actually implemented as a stack in the
> hardware itself. If you write a value to a register it will be pushed onto a
> stack in the hardware and if you read the same register you pop the value
> from the stack in the hardware.

As I said above, you don't need to do this. The read back is usually
needed for things like clearing an error state at the device and then
enabling the IRQ for that device at the GIC level (though this
particular case isn't that simple).

Another example is cancelling some DMA transfer before you start
modifying the data in RAM. Here you need to makes sure that the device
actually stopped after the write to a register and a common scenario is
to read back from the device.

But *note* that from a bus (PCI etc.) perspective it does not need to be
the same register on that device.  From a device perspective (like
required delays etc.), it should be specified in the specs.

> Do you understand my problems and do you have any suggestions for me how to
> handle it? The initial problem, looking at using __raw_writel, was actually
> to improve performance. I noticed about 50% better throughput when I was
> using __raw_writel/readl instead writel/readl, but Linus warned me about the
> problems he mentioned in the initial message in this thread.

I would say just use the writel_relaxed/readl_relaxed variants unless
you have DMA transfers (but it looks more like PIO from your example).

-- 
Catalin
