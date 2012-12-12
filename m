From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 12 Dec 2012 09:22:09 +0100
Subject: linker problem with xip kernel and recent toolchains
In-Reply-To: <1355249468.19818.23.camel@hornet>
References: <50BE0CDB.5000704@pengutronix.de>
 <1355230894.19818.1.camel@hornet> <50C7386E.70305@pengutronix.de>
 <1355249468.19818.23.camel@hornet>
Message-ID: <50C83EB1.5050509@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2012 07:11 PM, Pawel Moll wrote:
> On Tue, 2012-12-11 at 13:43 +0000, Marc Kleine-Budde wrote:
>> What about putting the notes section into the read only segment, i.e.
>> the ROM?
> 
> Could you, please, try the change below? It seems to do the job for me.

Works for me. The kernel image links to 640 KiB again.

> 8<-------------------------
> From 01fe7810cfded11aff03d216d2adbcf673e78f65 Mon Sep 17 00:00:00 2001
> From: Pawel Moll <pawel.moll@arm.com>
> Date: Tue, 11 Dec 2012 18:09:14 +0000
> Subject: [PATCH] ARM: vmlinux.lds: Move .notes section next to the rodata
> 
> The .notes, being read-only data by nature, was placed between
> read-write .data and .bss. This was harmful in case of XIP
> images, as it was placed in the RAM range, most likely far
> from the ROM address, inflating the XIP images.
> 
> Moving the .notes at the end of the read-only section
> (consisting of .text, .rodata and unwind info) fixes the problem.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121212/6059476d/attachment.sig>
