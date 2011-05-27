From: joakim.xx.bech@stericsson.com (Joakim BECH)
Date: Fri, 27 May 2011 16:14:18 +0200
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
Message-ID: <C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, I'm one of the reasons Linus wrote this question.

I get a bit confused about the feedback in this issue. Listening to Russel
and Arnd I get the impression to not even think about using __raw_writel.
But from Catalin's answer I got the impression it's indeed possible to use
__raw_writel on an ARM architecture and I'm writing to such a device. Could
you please clarify this?

In my particular setup I'm writing a driver that is talking to a crypto
hardware and the architecture is ARM. The hardware is mapped as io-mapped
memory in our driver. Our main problem is to program the hardware, by
writing to certain registers in order and when the hardware is ready to
accept input, we will write the bulk-data to the same register over and over
again until there is no more data. I.e. in principle we do like this (a bit
simplified).

write(a, reg1); // Setup hardware
write(a, reg2); // Setup hardware
write(a, reg3); // Write bulk data
write(a, reg3); // Write bulk data ...

Some of you wrote that the only way to be sure that the data has been
written is to read the value after writing it. Here we have another problem.
Since it's a cryptographic device some registers on the hardware are
write-only, and some registers are actually implemented as a stack in the
hardware itself. If you write a value to a register it will be pushed onto a
stack in the hardware and if you read the same register you pop the value
from the stack in the hardware.

Do you understand my problems and do you have any suggestions for me how to
handle it? The initial problem, looking at using __raw_writel, was actually
to improve performance. I noticed about 50% better throughput when I was
using __raw_writel/readl instead writel/readl, but Linus warned me about the
problems he mentioned in the initial message in this thread.

// Joakim B
