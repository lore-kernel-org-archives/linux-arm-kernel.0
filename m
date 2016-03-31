From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Mar 2016 15:14:13 +0100
Subject: [PATCH 2/4] scatterlist: add sg_alloc_table_from_buf() helper
In-Reply-To: <1459427384-21374-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459427384-21374-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160331141412.GK19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 02:29:42PM +0200, Boris Brezillon wrote:
> sg_alloc_table_from_buf() provides an easy solution to create an sg_table
> from a virtual address pointer. This function takes care of dealing with
> vmallocated buffers, buffer alignment, or DMA engine limitations (maximum
> DMA transfer size).

Please note that the DMA API does not take account of coherency of memory
regions other than non-high/lowmem - there are specific extensions to
deal with this.

What this means is that having an API that takes any virtual address
pointer, converts it to a scatterlist which is then DMA mapped, is
unsafe.

It'll be okay for PIPT and non-aliasing VIPT cache architectures, but
for other cache architectures this will hide this problem and make
review harder.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
