From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Oct 2009 23:57:58 +0100
Subject: [WARNING] pxamci: 'pxa2xx-mci.0' does not have a release()
	function.
In-Reply-To: <20091023003631.1331a60a.ospite@studenti.unina.it>
References: <20091023003631.1331a60a.ospite@studenti.unina.it>
Message-ID: <20091022225758.GA9106@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 12:36:31AM +0200, Antonio Ospite wrote:
> Hi,
> 
> I get this warning on shutdown. How to fix it properly?
> 
> FYI, in my setup pxa2xx_spi is the parent for pxamci, set using
> this patch:
> http://git.openezx.org/openezx.git?a=commitdiff;h=0ffd85ad8faea3456d4ecf5f63ae65aca26fff21

This sounds like it's the cause of the problem - from the backtrace, it
looks like SPI expects the children of the SPI device to be its own
responsibility to maintain.

Hence, because you've made pxamci a child of SPI, SPI is trying to
unregister and release the pxamci device.
