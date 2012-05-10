From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 10 May 2012 12:37:29 -0700
Subject: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
In-Reply-To: <20120510172918.13418.64781.stgit@dusk>
References: <20120510172449.13418.66815.stgit@dusk>
 <20120510172918.13418.64781.stgit@dusk>
Message-ID: <20120510193729.GE20494@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 11:29:19AM -0600, Paul Walmsley wrote:
> During kernel init, the AM3505/AM3517 UART4 cannot complete its softreset:
> 
> omap_hwmod: uart4: softreset failed (waited 10000 usec)
> 
> This also results in another warning later in the boot process:
> 
> omap_hwmod: uart4: enabled state can only be entered from initialized, idle, or disabled state
> 
> >From empirical observation, the AM35xx UART4 IP block requires either
> uart1_fck or uart2_fck to be enabled while UART4 resets.  Otherwise
> the reset will never complete.  So this patch adds uart1_fck as an
> optional clock for UART4 and adds the appropriate hwmod flag to cause
> uart1_fck to be enabled during the reset process.  (The choice of
> uart1_fck over uart2_fck was arbitrary.)
> 
> Unfortunately this observation raises many questions.  Is it necessary
> for uart1_fck or uart2_fck to be controlled with uart4_fck for the
> UART4 to work correctly?  What exactly do the AM35xx UART4 clock
> tree and the related PRCM idle management FSMs look like?  If anyone
> has the ability to answer these questions through empirical functional
> testing, or hardware information from the AM35xx designers, it would
> be greatly appreciated.
> 
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Kyle Manna <kyle.manna@fuel7.com>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Ranjith Lohithakshan <ranjithl@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by: Mark A. Greer <mgreer@animalcreek.com>
(on an am3517evm)

Mark
