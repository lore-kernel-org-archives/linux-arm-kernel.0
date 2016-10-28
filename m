From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 28 Oct 2016 09:47:40 -0600
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
 <20161027143937.GC6818@obsidianresearch.com>
 <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
Message-ID: <20161028154740.GC10441@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 01:06:08PM +0200, Matthias Brugger wrote:

> The only case we don't check is, if count == 0. If we check that here, we
> can get rid of the count <= 4 check.

You don't think

  if (count == 0 || buf[3] = 'x')
 
looks weird and wrong? I do.

> >The count <= 4 should stay here since it is primarily guarding against
> >read past the buffer in the if.
> 
> If you insist in doing this check, it should be count < 4, because we check
> the first four elements of buf, or do I miss something?

count = 4 and count = 0 are both invalid. A bitstream consisting of
only the sync word is also going to fail programming.

As Michal said, the actual min bitstream length is probably >> 50 bytes

Jason
