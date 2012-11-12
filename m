From: balbi@ti.com (Felipe Balbi)
Date: Mon, 12 Nov 2012 10:01:34 +0200
Subject: Porting board initialization for fdt
In-Reply-To: <CAE7jHC-Z9wy=5HPzhZZpupcBVn862ERq1LRF9KQ=Ed7BXiDFBA@mail.gmail.com>
References: <CAE7jHC-Z9wy=5HPzhZZpupcBVn862ERq1LRF9KQ=Ed7BXiDFBA@mail.gmail.com>
Message-ID: <20121112080134.GB25465@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 12, 2012 at 12:38:37AM +0200, Constantine Shulyupin wrote:
> What is architecture and the best strategy to port board initialization to fdt?
> 
> Let's see for example omap4_ehci_init and usbhs_bdata @
> arch/arm/mach-omap2/board-omap4panda.c.

before getting rid of platform_data, we need to switch over to proper
frameworks for muxing, clock, etc. In case of EHCI, pinctrl migration is
currently under development by Keshava (in Cc). After that we need to
take a look at platform and see if there are any function pointers in
there, if there are, those need to be removed.

> How to perform board specific initializations?
> Can omap4_ehci_init be converted to probe function of new platform
> driver  omap4_ehci?

yeah, that function is actually wrong. First, that GPIO pin belongs to
the HUB driver, not the EHCI driver.

Second, those clocks belong to the PHY, not EHCI either. Before those
details are cleaned up, we will always have hacky solutions which will
break in one way or another.

When those cleanups are done, conversion to FDT is not a problem at all.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121112/e3af94ee/attachment.sig>
