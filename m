From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Sep 2014 11:30:13 +0100
Subject: [RFC] arm:extend the reserved mrmory for initrd to be page aligned
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB491606@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
 <20140915084616.GX12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491604@CNBJMBX05.corpusers.net>
 <20140915093014.GZ12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491605@CNBJMBX05.corpusers.net>
 <20140915101632.GA12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491606@CNBJMBX05.corpusers.net>
Message-ID: <20140915103013.GB12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 06:22:12PM +0800, Wang, Yalin wrote:
> Oh, I see your meaning,
> Yeah , my initrd is a cpio image,
> And it can still work after apply this patch.

Okay, that's what I wanted to know.  However, I believe your patch to
be incorrect.  You delete the assignments to initrd_start and initrd_end
in arm_memblock_init(), which will result in non-OF platforms having
no initrd.

The reason is that OF platforms set initrd_start and initrd_size from
the OF code (drivers/of/fdt.c), but ATAG platforms only set our private
phys_* versions.

The reason I went with phys_* stuff was to permit better verification
of the addresses passed - that the addresses were indeed memory locations
before passing them through something like __va().

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
