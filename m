From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 21 May 2013 18:27:44 -0400
Subject: [PATCH] ARM: Kirkwood: TS219: Fix crash by double PCIe
 instantiation
In-Reply-To: <1369158108-5603-1-git-send-email-andrew@lunn.ch>
References: <1369158108-5603-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130521222744.GX31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 07:41:48PM +0200, Andrew Lunn wrote:
> When creating the DT based boards-ts219.c the none DT ts219-setup.c
> was used as a template. This includes a lateinit() call to initialize
> the PCIe bus. The code makes use of machine_is_ts219() which is never
> true on DT, so a FIXME was added and the code left as is. This was
> unproblematic until b73690c8f8b5d: "ARM: Kirkwood: Support basic
> hotplug for PCI-E" which changes the way the PCIe bus is
> initialized. The non-DT ts219-setup.c now crashes during boot.  The
> lateinit() call in the DT boards-ts219.c is being called,
> machine_is_ts219() is true and so the PCIe is initialized a second
> time.
> 
> This patch removes the useless, and now clearly dangerous, code from
> boards-ts219.c, making ts219-setup.c work again.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> This can also be tagged for stable 3.9
> 
>  arch/arm/mach-kirkwood/board-ts219.c |   10 ----------
>  1 file changed, 10 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
