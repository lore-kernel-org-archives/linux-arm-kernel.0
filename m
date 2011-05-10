From: ospite@studenti.unina.it (Antonio Ospite)
Date: Tue, 10 May 2011 22:02:14 +0200
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
In-Reply-To: <20110509203612.GC21323@opensource.wolfsonmicro.com>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
	<20110509202325.GD16919@n2100.arm.linux.org.uk>
	<20110509203612.GC21323@opensource.wolfsonmicro.com>
Message-ID: <20110510220214.916621d1.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 May 2011 22:36:12 +0200
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, May 09, 2011 at 09:23:25PM +0100, Russell King - ARM Linux wrote:
> 
> > NAK.  This has been proposed before, and rejected.  See the comments
> > against the original proposal:
> 
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6525/1
> 
> Hrm, this looks like the bodge we're doing for !REGULATOR isn't actually
> helping here unless we do a NULL || IS_ERR() in the error check.  The
> ifdefs are certainly fail.
> 

[Adding Linus Walleij to CC as he was the author of a similar NAKed
patch]

I was blindly trusting code already in mainline again, and for that I
apologize, I finally took the time to look at the implementation
of IS_ERR() and test its use, and being IS_ERR(NULL) true it is not what
we want indeed, see the attached test program.

So, I am going to remove the ifdefs anyway but use IS_ERR_OR_NULL();
how does that sound? Am I still missing anything?
Or changing the regulator_get() stub to return an error (-ENOSYS?) might
be worth it?

Thanks Russel for pointing out the issue BTW.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: IS_ERR_regulator_get.c
Type: text/x-csrc
Size: 1590 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110510/12e659f9/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110510/12e659f9/attachment.sig>
