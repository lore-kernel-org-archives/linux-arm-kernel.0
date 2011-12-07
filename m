From: ben@decadent.org.uk (Ben Hutchings)
Date: Wed, 07 Dec 2011 06:02:27 +0000
Subject: Bug#651215: Kernel fails to boot on NSLU2
In-Reply-To: <20111206194048.12063.82586.reportbug@vrnul03074nb.vr-netze.vrnet>
References: <20111206194048.12063.82586.reportbug@vrnul03074nb.vr-netze.vrnet>
Message-ID: <1323237747.18450.7.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-06 at 20:40 +0100, Jochen Friedrich wrote:
> Package: linux-image-3.1.0-1-ixp4xx
> Severity: normal
> 
> While 3.0.0-6 booted OK on NSLU2 platform, 3.1.0-1 or -4 fails to do so.
> 
> Boot log:
[...]
> [    0.000000] Linux version 3.1.0-1-ixp4xx (Debian 3.1.4-1) (waldi at debian.org)
> (gcc version 4.6.2 (Debian 4.6.2-4) ) #1 Wed Nov 30 06:35:38 UTC 2011
> [    0.000000] CPU: XScale-IXP42x Family [690541f1] revision 1 (ARMv5TE),
> cr=0000397f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: Linksys NSLU2
[...]
> [    3.269860] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    3.350596] PCI: enabling device 0000:00:01.2 (0140 -> 0142)
> [    3.356553] ehci_hcd 0000:00:01.2: EHCI Host Controller
> [    3.452053] ehci_hcd 0000:00:01.2: new USB bus registered, assigned bus
> number 1
> [    3.459646] ehci_hcd 0000:00:01.2: coherent DMA mask 0x3ffffff is smaller
> than system GFP_DMA mask 0xffffffff
> [    3.570085] ehci_hcd 0000:00:01.2: coherent DMA mask 0x3ffffff is smaller
> than system GFP_DMA mask 0xffffffff
> [    3.680189] ehci_hcd 0000:00:01.2: coherent DMA mask 0x3ffffff is smaller
> than system GFP_DMA mask 0xffffffff
> (repeated over and over)

I assume that this has something to do with:

commit 650320181a08b64d4421c65c639cf47ad8cc2cd6
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Mon Jul 18 15:05:10 2011 -0400

    ARM: change ARM_DMA_ZONE_SIZE into a variable

commit 7553ee777b513c3bc8f45bb9fc75fb1bbc584ba1
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Tue Jul 5 22:28:09 2011 -0400

    ARM: mach-ixp4xx: move from ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size

It's clear that the DMA zone size is supposed to be 64 MB on this
machine and I don't see why the DMA mask hasn't propagated correctly.
Any idea, Nicholas?

Ben.

-- 
Ben Hutchings
Absolutum obsoletum. (If it works, it's out of date.) - Stafford Beer
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111207/44fa3d7e/attachment-0001.sig>
