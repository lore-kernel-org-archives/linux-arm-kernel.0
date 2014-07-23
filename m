From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 23 Jul 2014 11:42:29 -0600
Subject: [PATCH v7 4/5] PCI: add PCI controller for keystone PCIe h/w
In-Reply-To: <20140722235200.GC27965@google.com>
References: <1405961925-27248-1-git-send-email-m-karicheri2@ti.com>
 <1405961925-27248-5-git-send-email-m-karicheri2@ti.com>
 <20140722223527.GA27965@google.com> <53CEEB1C.9020202@ti.com>
 <20140722235200.GC27965@google.com>
Message-ID: <20140723174228.GB11270@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 05:52:00PM -0600, Bjorn Helgaas wrote:
> If there is a hardware defect, a PCI quirk is a reasonable way to work
> around it, since that's the main purpose of quirks.  fixup_mpss_256()
> is an example of something that sounds superficially similar.

It was my suggestion to engage the PCI-E tuning code. By my
understanding the HW bug is that read response segmentation at the
host bridge does not work - so all read requests from any downstream
device must have responses that fit within a single packet.

This is completely against how the spec envisions things working,
segmentation is a mandatory function. As you point out there is no
parameter bounding the maximum read request size that a completer will
accept.

So, the only fix is that every downstream device must always have a
MRSS set to less than the MPS of the host bridge.

Which means the tuning code must be involved somehow, as that code
controls the MRSS of unrelated devices...

Regards,
Jason
