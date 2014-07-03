From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jul 2014 18:52:58 +0100
Subject: [PATCH] arm: Make sure memory starting at physical address 0
 is reserved.
In-Reply-To: <1404409205-7368-1-git-send-email-alcooperx@gmail.com>
References: <1404409205-7368-1-git-send-email-alcooperx@gmail.com>
Message-ID: <20140703175258.GB32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 01:40:05PM -0400, Al Cooper wrote:
> Some older hardware, like USB OHCI, cannot DMA to physical address
> zero. This change makes sure that the first PAGESIZE block of memory
> starting at zero is reserved so it can't end up in any free
> memory pool.

I really don't like this approach.  The assumption here is that DMA
address zero on a peripheral is the same as physical address zero.
That isn't always the case.

What if DMA address zero corresponds with the first byte of RAM, but
the first byte of RAM is at 0x80000000?

I believe there's even some cases where the first byte of RAM is not
what the kernel sees as the first byte of RAM (because people want
to hide the first half of RAM from the kernel for a DSP or similar.)

What I'm saying is I don't think there's a nice simple solution to
this.  We probably need the DT reserved memory support to handle
this.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
