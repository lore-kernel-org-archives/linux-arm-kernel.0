From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 11 Mar 2010 11:39:41 +0100
Subject: [PATCH 1/2] mx1: fix build when DEBUG_LL is enabled
In-Reply-To: <e5558b1571cff8472994ed51622339fd9e517f5e.1268129163.git.baruch@tkos.co.il>
References: <e5558b1571cff8472994ed51622339fd9e517f5e.1268129163.git.baruch@tkos.co.il>
Message-ID: <20100311103940.GA19320@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 09, 2010 at 12:12:04PM +0200, Baruch Siach wrote:
> Commit "mx1: prefix SOC specific defines with MX1_ and deprecate old names"
> redefined the IO_ADDRESS macro in a way that is incompatible with
> debug-macro.S. Reintroduce AVIC_IO_ADDRESS, and use it in debug-macro.S.
This feels wrong.  Can you please instead fix IMX_IO_ADDRESS?

Something like:

	#ifdef __ASSEMBLY__
	#define IOREG(x) (x)
	#else
	#define IOREG(x) ((void __force __iomem *)(x))
	#endif

	#define IMX_IO_ADDRESS(addr, module) IOREG(\
	...

could work.  Don't know if the cast to unsigned long works in assembler.
Maybe it's unneeded?  Don't remember.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
