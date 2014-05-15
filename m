From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 15 May 2014 11:53:07 -0600
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI
 I/O memory type
In-Reply-To: <20140515153430.GM27594@arm.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140515155130.193c3181@free-electrons.com>
 <20140515142924.GI27594@arm.com> <4972763.mtuLYh6sDH@wuerfel>
 <20140515153430.GM27594@arm.com>
Message-ID: <20140515175307.GA12259@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 04:34:30PM +0100, Will Deacon wrote:

> > How can a write be non-posted on the PCI bus if it's posted on AXI?
> 
> From the point-of-view of the CPU it would be posted, but the PCI bus would
> see an unposted write (so I imagine there would be write buffering at the
> host controller). However, I worry that I'm missing your point :)

It is worth being a bit careful with language here, from an AXI
perspective there is not really such thing as a posted write. 

All writes are explicitly ack'd upon 'completion', however the memory
type influences when that is allowed to happen.

For PCI IO writes the AXI memory type from the CPU must be 'Device
Non-bufferable' (AWCACHE = 0), which will require the AXI ACK to be
generated only once the PCI target returns an IOWr completion TLP.

For PCI Memory writes the AXI memory type from the CPU could be
'Device Non-bufferable' but it would be best if it is 'Device
Bufferable' (AWCACHE = 1).

The latter allows more performance by permitting any AXI bridge in the
path to ack the write early. This is as close as AXI gets to 'posted
writes'

It is very important that the page tables in the CPU properly select
the right AXI Memory Type for each space.

Somewhere there should be a table describing how the CPU page table
attributes map into AXI *CACHE/Memory Type signaling selectors.

Beyond that, as Will points out, a DSB as part of the outl might be
required to spin the cpu and prevent pipelining.

AFAIK, to duplicate x86 semantics an outl/inl must spin the CPU until
it completes at the target, and the CPU must not pipeline outl/inl
operations: outl();  outl(); produces 1 IOWr TLP, waits for
completion, then produces another.

Jason
