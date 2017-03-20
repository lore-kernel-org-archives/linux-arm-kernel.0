From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 20 Mar 2017 10:28:12 +0000
Subject: [PATCH 1/3] arm64: enable pci resource mapping using sysfs
In-Reply-To: <20170320102403.GC17263@arm.com>
References: <1489598266.86622.12.camel@infradead.org>
 <20170315175353.GA29452@leverpostej>
 <1489605496.4195.182.camel@infradead.org> <20170320102403.GC17263@arm.com>
Message-ID: <1490005692.5036.8.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-03-20 at 10:24 +0000, Will Deacon wrote:
> 
> Just to be clear here: I'm not against exposing the proc interface if
> something actually needs it, but all the requests we've had for this have
> been concerned only with the sysfs API. So I'd rather start with just that,
> instead of exposing both and have new software written to the proc interface,
> which we certainly want to discourage.

The point is that they are tied together. An architecture provides its
pci_mmap_page_range() function and sets HAVE_PCI_MMAP, and then the
*generic* code in drivers/pci will use it from both places.

Although as noted, there is a third userspace API in drivers/vfio which
does this *without* any arch-specific code (using pgprot_noncached(),
and failing to set up the VMA correctly on HAVE_IOREMAP_PROT platforms.

I was looking at cleaning that whole mess up, but got distracted by
kdump-on-CPU-1 failures. If I'm going to blame that on firmware, I'll
get back to PCI mmap this week... :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/5f0a1750/attachment.bin>
