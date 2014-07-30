From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 30 Jul 2014 14:05:13 -0600
Subject: [PATCH v7 4/5] PCI: add PCI controller for keystone PCIe h/w
In-Reply-To: <53D948D4.6080603@ti.com>
References: <1405961925-27248-1-git-send-email-m-karicheri2@ti.com>
 <1405961925-27248-5-git-send-email-m-karicheri2@ti.com>
 <20140722223527.GA27965@google.com> <53CEEB1C.9020202@ti.com>
 <20140722235200.GC27965@google.com>
 <20140723174228.GB11270@obsidianresearch.com>
 <53D948D4.6080603@ti.com>
Message-ID: <20140730200513.GA11918@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 03:34:44PM -0400, Murali Karicheri wrote:

> ? Maximum remote read request size of 256 bytes

The PCI spec simply does not permit a completer to impose this
limitation.

See spec 2.3.1.1

It is not an option to error a read request because it is too
long. All requests must be completed. All completions must be segmented
according to the RCB and Max_Payload_Size.

> completion packets. So it seems to be able to segment up to maximum
> 256 bytes of read request. Where do I find the requirement in PCI
> spec that "read response segmentation at the host bridge does not
> work" ?

You just said it. Segmenting up to only 256 bytes is not a limitation
the completer can impose. Such a device is non-conformant.

> >So, the only fix is that every downstream device must always have a
> >MRSS set to less than the MPS of the host bridge.
> 
> Why this can't be the default behavior in the PCI core? Any cons?

It increases read request traffic and read response latency on the bus
for large transfers.

The MRSS is intented as a performance tuning knob, it is not something
that ever needs to be set properly for correct bus operation.

Jason
