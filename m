From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Apr 2012 16:52:32 +0100
Subject: [PATCH v2 3/4] ARM: mm: truncate memory banks to fit in 4GB
 space for classic MMU
In-Reply-To: <alpine.LFD.2.02.1204111038130.16314@xanadu.home>
References: <1334154639-13869-1-git-send-email-will.deacon@arm.com>
 <1334154639-13869-4-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1204111038130.16314@xanadu.home>
Message-ID: <20120411155232.GA24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:44:22AM -0400, Nicolas Pitre wrote:
> On Wed, 11 Apr 2012, Will Deacon wrote:
> 
> > If a bank of memory spanning the 4GB boundary is added on a !CONFIG_LPAE
> > kernel then we will hang early during boot since the memory bank will
> > have wrapped around to zero.
> > 
> > This patch truncates memory banks for !LPAE configurations when the end
> > address is not representable in 32 bits.
> > 
> > Cc: Nicolas Pitre <nico@fluxnic.net>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Now what if start = 1G and size = 5G? The size variable is an unsigned 
> long, meaning that right now the size might be truncated to 1G.

There's a solution to that which is quite easy to do: convert the bank
information to PFNs instead of addresses.  That will probably eliminate
some corner cases with partial pages which would be desirable too.
