From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 15 Sep 2014 17:07:53 +0800
Subject: [RFC] arm:extend the reserved mrmory for initrd to be page aligned
In-Reply-To: <20140915084616.GX12361@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
 <20140915084616.GX12361@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB491604@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I tested it on my phone,
>From log:
<4>[    0.000000] INITRD unalign phys address:0x02000000+0x0022fb0e
<4>[    0.000000] INITRD aligned phys address:0x02000000+0x00230000

<4>[    0.579474] free_initrd_mem: free pfn:8192---8752

The tail address is not aligned for most initrd image,
This page will not be freed and lost .

This patch have a limitation that the tail page's not used
Part should not be reserved by any other driver,
And must be memory .
This is true for most bootloaders ,
And we will print error if it is false .

Thanks


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Monday, September 15, 2014 4:46 PM
To: Wang, Yalin
Cc: 'Will Deacon'; 'linux-kernel at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-mm at kvack.org'; linux-arm-msm at vger.kernel.org
Subject: Re: [RFC] arm:extend the reserved mrmory for initrd to be page aligned

On Mon, Sep 15, 2014 at 01:11:14PM +0800, Wang, Yalin wrote:
> this patch extend the start and end address of initrd to be page 
> aligned, so that we can free all memory including the un-page aligned 
> head or tail page of initrd, if the start or end address of initrd are 
> not page aligned, the page can't be freed by free_initrd_mem() function.

Have you tested this patch?  If so, how thorough was your testing?

--
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up according to speedtest.net.
