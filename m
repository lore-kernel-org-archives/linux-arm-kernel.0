From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 6 Dec 2012 10:52:13 +0100
Subject: [PATCH] mtd: nand: gpmi: reset BCH earlier, too, to avoid NAND
 startup problems
In-Reply-To: <50BFFFE8.8040002@freescale.com>
References: <1354740362-20412-1-git-send-email-w.sang@pengutronix.de>
 <50BFFFE8.8040002@freescale.com>
Message-ID: <20121206095213.GA2589@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 06, 2012 at 10:16:08AM +0800, Huang Shijie wrote:
> ? 2012?12?06? 04:46, Wolfram Sang ??:
> > correctly after warm rebooting, so the kernel could not find the UBI or
> which Soc do you meet this issue? the mx23 or mx28?

MX28.

> It's bad news to me. I ever thought the BCH-reset-issue is gone.
> I ever tested many times in mx28(> 10000 times) with freescale's uboot.

Did you power-cycle between each test or reboot? I still need to test if
this really makes a difference, but I think the issue shows more often
when only rebooting.

> I guest you are not use the freescale's uboot. The uboot also will reset
> the BCH/GPMI.

I just checked its sources. It also has this flaw. GPMI and BCH need to
be reset at the same time, i.e. before first commands are sent to the
NAND (although they don't need ECC).

I use barebox, but that isn't of importance here. If I don't fix
barebox, I see NAND issues in barebox or the kernel. If I fix barebox, I
still see issues in the kernel, but not in barebox anymore.

The setup needs to be done properly to ensure a consistent state at the
beginning, especially when somebody used the NAND before (ROM code,
bootloader). Fixing the bootloader alone is not enough.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121206/904554a2/attachment.sig>
