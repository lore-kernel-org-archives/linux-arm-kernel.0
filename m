From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 09 May 2011 11:59:54 +0100
Subject: [PATCH v5 02/19] ARM: LPAE: add ISBs around MMU enabling code
In-Reply-To: <20110509103242.GQ27807@n2100.arm.linux.org.uk>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1304859098-10760-3-git-send-email-catalin.marinas@arm.com>
	<20110508214101.GO27807@n2100.arm.linux.org.uk>
	<1304936539.7658.31.camel@e102109-lin.cambridge.arm.com>
	<20110509103242.GQ27807@n2100.arm.linux.org.uk>
Message-ID: <1304938794.7658.56.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-09 at 11:32 +0100, Russell King - ARM Linux wrote:
> On Mon, May 09, 2011 at 11:22:19AM +0100, Catalin Marinas wrote:
> > Alternatively an exception return would do as well (like movs pc, lr)
> > but I think we still add some code for setting up the SPSR.
> 
> That gives us a way out of both of these without introducing any CPU
> specific code.  We can setup the SPSR before this block of code, and
> call it with two movs pc, reg instructions which will provide the
> necessary synchronization.

We still need an ISB before enabling the MMU to make sure that the TTBR
changing is visible. We may run with the MMU enabled (in the identity
mapping) before the exception return but with random data in TTBR.

-- 
Catalin
