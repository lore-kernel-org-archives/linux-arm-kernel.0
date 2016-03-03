From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 3 Mar 2016 23:27:11 +0100
Subject: DWord alignment on ARMv7
Message-ID: <56D8BA3F.7050508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, (now sending to linux-arm-kernel)

I'm using btrfs on am ARMv7 and it turns out, that the kernel has to
fixup a lot of kernel originated alignment issues.

See /proc/cpu/alignment (~4h of uptime):
> System: 22304815 (btrfs_get_token_64+0x13c/0x148 [btrfs])

For example, when compiling the kernel on a btrfs volume the counter
increases by 100...1000 per second.

The function shown "btrfs_get_token_64()" is defined here:
> http://lxr.free-electrons.com/source/fs/btrfs/struct-funcs.c#L53
...it already uses get_unaligned_leXX accessors.

Quoting a comment in arch/arm/mm/alignment.c:

         * ARMv6 and later CPUs can perform unaligned accesses for
         * most single load and store instructions up to word size.
         * LDM, STM, LDRD and STRD still need to be handled.

But on a 32bit ARMv7 64bits are not word-sized.

Is the exception and fixup overhead neglectable? Do we have to introduce
something like HAVE_EFFICIENT_UNALIGNED_64BIT_ACCESS?

regards,
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
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160303/78229449/attachment-0001.sig>
