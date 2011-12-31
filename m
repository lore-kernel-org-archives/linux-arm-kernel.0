From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 31 Dec 2011 16:43:38 +0100
Subject: [PATCH v2] MTD/GPMI bugfix : reset the BCH module when it is not
 MX23
In-Reply-To: <4EFE7236.10609@freescale.com>
References: <1325233646-3343-1-git-send-email-b32955@freescale.com>
 <20111230143658.GA9141@pengutronix.de>
 <4EFE7236.10609@freescale.com>
Message-ID: <20111231154338.GA27544@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 31, 2011 at 10:23:50AM +0800, Huang Shijie wrote:

> > On Fri, Dec 30, 2011 at 04:27:26PM +0800, Huang Shijie wrote:
> >> In MX28, if we do not reset the BCH module. The BCH module may
> >> becomes unstable when the board reboots for several thousands times.
> > Do you have more details when and why this happens? What happens on MX23 then?
> In one customer's 3G router which uses the MX28:
> [0] NAND boot mode, mount the UBIFS in the NAND partition.
> [1] We used the gpmi_reset_block(r->bch_regs, true) to init the BCH module.
> [2] The board will automatically reboot again after it booted by NAND
> boot mode.
> [3] After reboot more then thousands times(cost nearly one day), the BCH
> mode became UNSTABLE,
> the data read out was not right, so the system could not mount the UBIFS.
> 
> After we use gpmi_reset_block(r->bch_regs, false) to init the BCH
> module, the bug never happens.

Yes, I undestood that. I was curious _why_ this happens, for example, because
of a bug in the rom-code or such. This would then lead to the question if this
can be fixed by some other means. Because currently it looks like this to me:
If you would do the above scenario of booting 10000 times on a MX23, then BCH
could enter the same unstable state (can it?). Since we cannot reset BCH due to
bug 2847, we have a serious problem, because NAND won't work until the next
power-cycle? I am curious if my assumptions are true and we have a serious
problem on the MX23.

> Yes, this is the bug 2847 from the mx23's errata.

OK, thanks.

Kind regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111231/dda562e2/attachment-0001.sig>
