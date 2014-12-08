From: meuleman@broadcom.com (Hante Meuleman)
Date: Mon, 8 Dec 2014 13:47:38 +0000
Subject: using DMA-API on ARM
In-Reply-To: <F51492713EF10846800D8C0ED37A7DCE01901765@SJEXCHMB15.corp.ad.broadcom.com>
References: <5481794E.4050406@broadcom.com>
 <20141205094507.GP11285@n2100.arm.linux.org.uk>
 <20141205122423.GK1630@arm.com>
 <F51492713EF10846800D8C0ED37A7DCE019016E1@SJEXCHMB15.corp.ad.broadcom.com>
 <20141205132332.GS11285@n2100.arm.linux.org.uk>
 <F51492713EF10846800D8C0ED37A7DCE01901765@SJEXCHMB15.corp.ad.broadcom.com>
Message-ID: <F51492713EF10846800D8C0ED37A7DCE01902076@SJEXCHMB15.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Still using outlook, but will limit the line length, I hope that works for the
moment. Attached is a log with the requested information, it is a little
bit non-standard though. The dump code from the mm was copied in
the driver and called from there, mapping the prints back to our local
printf, but it should produce the same. I did this because I didn't realize
the table is static.

Some background on the test setup: I'm using a Broadcom reference 
design AP platform with an BRCM 4708 host SOC. For the AP router 
platform the opensource packet OpenWRT was used. Some small
modifications were made to get it to work on our HW. Only one core
is enabled for the moment (no time to figure out how to enable the
other one). Openwrt was configured to use kernel 3.18-rc2 and 
the brcmfmac of the compat-wireless code was updated with our 
latest code (minor patches, which have been submitted already). 
The device used is 43602 pcie device. Some modifications to the build
system were made to enable PCIE. The test is to connect with a 
client to the AP and run iperf (TCP). The test can run for many hours
without a problem, but sometimes fails very quickly.

The log: first the ring allocation info is printed. Starting at
16.124847, ring 2, 3 and 4 are rings used for device to host. In this
log the failure is on a read of ring 3. Ring 3 is 1024 entries of each
16 bytes. The next thing printed is the kernel page tables. Then some 
OpenWRT info and the logging of part of the connection setup. Then at 
1780.130752 the logging of the failure starts. The sequence number is 
modulo 253 with ring size of 1024 matches an "old" entry (read 40, 
expected 52). Then the different pointers are printed followed by 
the kernel page table. The code does then a cache invalidate on the 
dma_handle and the next read the sequence number is correct.

Regards,
Hante



Please wrap your message - replying to a message which looks like this in
my editor is far from easy, and gives me much more work to /manually/
reformat it before I can reply to it:

On Fri, Dec 05, 2014 at 12:56:45PM +0000, Hante Meuleman wrote:
> The problem is with data coming from device, so DMA from device to host. The $
>
> However: this indicates that dma_alloc_coherent on an ARM target may result i$
>
> Regards,
> Hante

Thanks.

On Fri, Dec 05, 2014 at 12:56:45PM +0000, Hante Meuleman wrote:
> However: this indicates that dma_alloc_coherent on an ARM target may
> result in a memory buffer which can be cached which conflicts with
> the API of this function.

If the memory has an alias which is cacheable, it is possible for cache
lines to get allocated via that alias, even if the alias has no explicit
accesses to it.

This is something which I've been going on for quite literally /years/ -
mismatched cache attributes can cause unpredictable behaviour.  I've had
a lot of push back from people who are of the opinion that "if it works
for me, then there isn't a problem" and I eventually gave up fighting
the battle, especially as the ARM architecture people weakened my
reasoning behind it by publishing a relaxation of the "no differing
attributes" issue.  This was particularly true of those who wanted to
use ioremap() on system memory - and cases such as
dma_init_coherent_memory().

So, I never fixed this problem in the original DMA allocator code; I
basically gave up with it.  It's a latent bug which did need to be fixed,
and is still present today in the non-CMA case.

The symptoms which you are reporting sound very much like this kind of
problem - the virtual address for the memory returned by
dma_alloc_coherent() will not be cacheable memory - it will have been
remapped using map_vm_area().  However, there could very well be a fully
cacheable lowmem mapping of that memory, which if a read (speculative or
otherwise) will bring a cache line in, and because the caches are VIPT
or PIPT, that cache line can be hit via the non-cacheable mapping too.

What I /really/ need is more evidence of this to tell those disbelievers
where to stick their flawed arguments. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: cache_fail_dmesg.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/b16580d5/attachment-0001.txt>
