From: ivan.djelic@parrot.com (Ivan Djelic)
Date: Tue, 19 Jul 2011 08:48:02 +0200
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <20005.7506.283476.184839@ipc1.ka-ro>
References: <20004.12663.29494.339601@ipc1.ka-ro>
	<20110718145635.GA24419@parrot.com>
	<20005.7506.283476.184839@ipc1.ka-ro>
Message-ID: <20110719064802.GA5788@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 06:59:46AM +0100, Lothar Wa?mann wrote:
> I'm writing a JFFS2 image file that is padded with 0xff to eraseblock
> size to flash (either from the bootloader or with the nandwrite
> utility from Linux).
> When mounting the filesystem everything is OK until the first file is
> being written. A subsequent read of the affected flash page gives ECC
> errors.
> 
> JFFS2 is giving out the first all-FF page in the last used block for
> creating the new file. Since that block has a non-FF ECC pattern, the
> ECC information is being corrupted on write.

OK, thanks for the clarification. So the problem only happens on partially
programmed blocks in the JFFS2 image, that end up fully programmed on the
device because of the 0xff padding.

I think the cleaner solution is to use a non-padded image and avoid programming
pages with 0xff in the last used block; programming nand pages multiple times
should be avoided if possible, as it is not supported on all (especially the
most recent) devices.

BR,

--
Ivan
