From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Mar 2012 14:09:12 +0100
Subject: ARM11MPcore: tlb_ops_need_broadcast causes deadlock
In-Reply-To: <loom.20120325T135816-592@post.gmane.org>
References: <274124B9C6907D4B8CE985903EAA19E91B2D579066@SI-MBX06.de.bosch.com>
 <20120323173055.GC16225@mudshark.cambridge.arm.com>
 <loom.20120325T135816-592@post.gmane.org>
Message-ID: <20120325130912.GF5611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2012 at 12:08:47PM +0000, Peter Waechtler wrote:
> But Will, is that tlb_flush necessary at all? The ARM has only 3 permission
> bits in the page table (APX and AP0 and AP1). The young/accessed bit is done
> via software.

Yes it most definitely is, because setting a page to be young means we
must receive a subsequent fault to make it 'old' again.  This means we
must set the page to be inaccessible to get that fault, and flush the
TLBs across all CPUs so that any CPU accessing that page receives a
fault.
