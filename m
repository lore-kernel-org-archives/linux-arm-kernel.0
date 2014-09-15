From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 15 Sep 2014 18:58:15 +0800
Subject: [RFC] arm:extend the reserved mrmory for initrd to be page aligned
In-Reply-To: <20140915103013.GB12361@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
 <20140915084616.GX12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491604@CNBJMBX05.corpusers.net>
 <20140915093014.GZ12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491605@CNBJMBX05.corpusers.net>
 <20140915101632.GA12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491606@CNBJMBX05.corpusers.net>
 <20140915103013.GB12361@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB491608@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh, I see,
I don't consider non-of platform kernels,
I will send V2 patch for this .

Thanks

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Monday, September 15, 2014 6:30 PM
To: Wang, Yalin
Cc: 'Will Deacon'; 'linux-kernel at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-mm at kvack.org'; linux-arm-msm at vger.kernel.org
Subject: Re: [RFC] arm:extend the reserved mrmory for initrd to be page aligned

On Mon, Sep 15, 2014 at 06:22:12PM +0800, Wang, Yalin wrote:
> Oh, I see your meaning,
> Yeah , my initrd is a cpio image,
> And it can still work after apply this patch.

Okay, that's what I wanted to know.  However, I believe your patch to be incorrect.  You delete the assignments to initrd_start and initrd_end in arm_memblock_init(), which will result in non-OF platforms having no initrd.

The reason is that OF platforms set initrd_start and initrd_size from the OF code (drivers/of/fdt.c), but ATAG platforms only set our private
phys_* versions.

The reason I went with phys_* stuff was to permit better verification of the addresses passed - that the addresses were indeed memory locations before passing them through something like __va().

--
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up according to speedtest.net.
