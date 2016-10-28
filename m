From: mbrugger@suse.com (Matthias Brugger)
Date: Fri, 28 Oct 2016 18:36:06 +0200
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161028154740.GC10441@obsidianresearch.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
 <20161027143937.GC6818@obsidianresearch.com>
 <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
 <20161028154740.GC10441@obsidianresearch.com>
Message-ID: <5ea0e77e-11c5-b4f7-00a9-9c5425ffac5a@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/10/16 17:47, Jason Gunthorpe wrote:
> On Fri, Oct 28, 2016 at 01:06:08PM +0200, Matthias Brugger wrote:
>
>> The only case we don't check is, if count == 0. If we check that here, we
>> can get rid of the count <= 4 check.
>
> You don't think
>
>   if (count == 0 || buf[3] = 'x')
>
> looks weird and wrong? I do.
>

That wasn't what I meant. Apart it looks quite wrong, because when the 
count is zero buf[3] points to anything but a valid value.

>>> The count <= 4 should stay here since it is primarily guarding against
>>> read past the buffer in the if.
>>
>> If you insist in doing this check, it should be count < 4, because we check
>> the first four elements of buf, or do I miss something?
>
> count = 4 and count = 0 are both invalid. A bitstream consisting of
> only the sync word is also going to fail programming.
>
> As Michal said, the actual min bitstream length is probably >> 50 bytes
>

Sure but we are checking here that the bitstream passed to the kernel is 
correct. I was thinking of something like:

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index c2fb4120bd62..46a38772e7ee 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -184,12 +184,26 @@ static int zynq_fpga_ops_write_init(struct 
fpga_manager *mgr, u32 flags,

  	priv = mgr->priv;

+	/* All valid bitstreams are multiples of 32 bits */
+	if (!count || (count % 4) != 0)
+		return -EINVAL;
+
