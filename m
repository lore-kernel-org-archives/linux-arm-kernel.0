From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Oct 2011 09:51:14 +0100
Subject: [PATCH 13/26] ARM: pxa: use correct __iomem annotations
In-Reply-To: <CAMPhdO_CGvoc8GZQS3TWpv0gqOXhmHyEbamcQr28K5iLgOBnuw@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-14-git-send-email-arnd@arndb.de>
	<CAMPhdO_CGvoc8GZQS3TWpv0gqOXhmHyEbamcQr28K5iLgOBnuw@mail.gmail.com>
Message-ID: <20111007085114.GE21464@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 04:11:01PM +0800, Eric Miao wrote:
> To be honest, I'd really like to keep the *_VIRT_BASE definitions to be
> type independent.
> 
> And have the actual register definitions to be casted to void __iomem *
> when being defined, e.g.
> 
> #define APBC_REG(x)	IOMEM(APBC_VIRT_BASE + (x))
> 
> #define APBC_UART1	APBC_REG(0x000)
> 
> Arnd, do we have some standard guidelines on this for all SoCs
> to follow? As I know, it's currently still being a mess.

It makes much more sense for the base address to be correctly typed (even
though it does mean a cast in the map_desc tables).  It avoids type
problems if someone does readl(APBC_VIRT_BASE + reg) somewhere, and
also avoids type problems should someone decide to pass the base address
around.
