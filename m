From: arend@broadcom.com (Arend van Spriel)
Date: Mon, 8 Dec 2014 17:22:44 +0100
Subject: using DMA-API on ARM
In-Reply-To: <2863746.4sUSEYqahB@wuerfel>
References: <5481794E.4050406@broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01901765@SJEXCHMB15.corp.ad.broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01902076@SJEXCHMB15.corp.ad.broadcom.com>
 <2863746.4sUSEYqahB@wuerfel>
Message-ID: <5485D054.7090109@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/14 16:01, Arnd Bergmann wrote:
> On Monday 08 December 2014 13:47:38 Hante Meuleman wrote:
>> Still using outlook, but will limit the line length, I hope that works for the
>> moment. Attached is a log with the requested information, it is a little
>> bit non-standard though. The dump code from the mm was copied in
>> the driver and called from there, mapping the prints back to our local
>> printf, but it should produce the same. I did this because I didn't realize
>> the table is static.
>>
>> Some background on the test setup: I'm using a Broadcom reference
>> design AP platform with an BRCM 4708 host SOC.
>
> I think you are using the wrong dtb file, the log says this is
> a "Buffalo WZR-1750DHP", not the reference design.

That router is close enough to the reference design.

>> For the AP router
>> platform the opensource packet OpenWRT was used. Some small
>> modifications were made to get it to work on our HW. Only one core
>> is enabled for the moment (no time to figure out how to enable the
>> other one). Openwrt was configured to use kernel 3.18-rc2 and
>> the brcmfmac of the compat-wireless code was updated with our
>> latest code (minor patches, which have been submitted already).
>> The device used is 43602 pcie device. Some modifications to the build
>> system were made to enable PCIE. The test is to connect with a
>> client to the AP and run iperf (TCP). The test can run for many hours
>> without a problem, but sometimes fails very quickly.
>
> The bcm4708 platform is maintained by Hauke Mehrtens, adding him to Cc.

Thanks. While going through the DTS files I intended to add him as well ;-)

> In your log, I see this message:
>
> [    0.000000] PL310 OF: cache setting yield illegal associativity
> [    0.000000] PL310 OF: -1069781724 calculated, only 8 and 16 legal
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x4e130001
>
> Evidently the cache controller information in DT is incorrect and
> the setup may be wrong as a consequence, which may explain cache
> coherency problems.

While staring at the DTS files I suspect there are some parts still 
missing. I have attached them for reference. Catalin pointed us to a 
patch in the l2 cache [1]. We have not tried that yet.

> Can you verify that the AUX_CTRL value is the same one you see
> in a working kernel?
>
>> The log: first the ring allocation info is printed. Starting at
>> 16.124847, ring 2, 3 and 4 are rings used for device to host. In this
>> log the failure is on a read of ring 3. Ring 3 is 1024 entries of each
>> 16 bytes. The next thing printed is the kernel page tables. Then some
>> OpenWRT info and the logging of part of the connection setup. Then at
>> 1780.130752 the logging of the failure starts. The sequence number is
>> modulo 253 with ring size of 1024 matches an "old" entry (read 40,
>> expected 52). Then the different pointers are printed followed by
>> the kernel page table. The code does then a cache invalidate on the
>> dma_handle and the next read the sequence number is correct.
>
> How do you invalidate the cache? A dma_handle is of type dma_addr_t
> and we don't define an operation for that, nor does it make sense
> on an allocation from dma_alloc_coherent(). What happens if you
> take out the invalidate?

dma_sync_single_for_cpu(, DMA_FROM_DEVICE) which ends up invalidating 
the cache (or that is our suspicion).

> Can you post the patch that you use (both platform and driver) relative
> to the snapshot of the the mainline kernel you are basing on?
>
> 	Arnd
>

Regards,
Arend

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6529/1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: bcm-dt-files.tar.bz2
Type: application/x-bzip2
Size: 2139 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/43560d5e/attachment.bz2>
