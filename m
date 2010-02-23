From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 11:10:36 +0000
Subject: [PATCH 1/4] ARM: Change the mandatory barriers implementation
In-Reply-To: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
References: <20100223110105.11048.8143.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100223111036.GA10501@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 11:01:05AM +0000, Catalin Marinas wrote:
> -#define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> -#define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> -#define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> +#define mb()		dsb()
> +#define rmb()		dmb()
> +#define wmb()		dsb()

What is the reason for getting rid of the arch_is_coherent() bit here
and imposing non-compiler barriers on everything?  I'd assume that
Lennert knew what he was doing with Xscale3.

This also breaks ARMv3 since you now issue a mcr for the write buffer
on architectures which have no write buffer.
