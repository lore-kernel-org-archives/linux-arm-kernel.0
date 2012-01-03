From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 3 Jan 2012 12:11:14 +0100
Subject: [PATCH v2] MTD/GPMI bugfix : reset the BCH module when it is
 not MX23
In-Reply-To: <CAMiH66Fwh-su6ucLDMM7hhCjH7MJPeavt1u4O=_jWn5w=DyfKA@mail.gmail.com>
References: <1325233646-3343-1-git-send-email-b32955@freescale.com>
 <20111230143658.GA9141@pengutronix.de>
 <4EFE7236.10609@freescale.com>
 <20111231154338.GA27544@pengutronix.de>
 <CAMiH66HsFn4+6-whEC6G-qSPda3+3pBzd50i7iHh9Pg9TXHTXw@mail.gmail.com>
 <20120101223335.GA3756@pengutronix.de>
 <CAMiH66Fwh-su6ucLDMM7hhCjH7MJPeavt1u4O=_jWn5w=DyfKA@mail.gmail.com>
Message-ID: <20120103111114.GA9083@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang,

> I will do the MX23 test, when i am free. It really costs lot of time :(

My point is like this: I wondered if you really found out _why_ the MX28
has this problem, e.g. "There is a case where the rom code does <x>, and
when the NAND then does <y> the BCH goes to state <z> which requires a
soft reset of the ip-core." If you had been at that point, it should be
quite easy to check if this can happen on MX23, too, I think.

If you don't know the cause of the problem in that detail because the
problem is hardly reproducable, well, that can happen, too. I fully
understand that. I don't want to enforce the time-consuming test on you
(would be interesting, though), but then at least the comments need
proper updates, so people are informed. From my understanding of the
situation, it could look like this:

===

Due to Errata #2847 of the MX23, the BCH cannot be soft reset on this
chip, otherwise it will lock up. So we skip resetting BCH on the MX23.
On the other hand, the MX28 needs the reset, because one case has been
seen where the BCH produced ECC errors constantly after 10000
consecutive reboots. The latter case has not been seen on the MX23 yet,
still we don't if it could happen there as well.

===

What do you think?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120103/d2606a4c/attachment.sig>
