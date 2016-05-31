From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 31 May 2016 14:40:24 +0100
Subject: [PATCH] drivers: char: mem: Check {read,write}_kmem() addresses
In-Reply-To: <20160531130821.GV19428@n2100.arm.linux.org.uk>
References: <5e293c103f0a86f512d71f17091a55e9746e711f.1464698496.git.robin.murphy@arm.com>
 <20160531130821.GV19428@n2100.arm.linux.org.uk>
Message-ID: <574D9448.7080206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/16 14:08, Russell King - ARM Linux wrote:
> On Tue, May 31, 2016 at 01:52:45PM +0100, Robin Murphy wrote:
>> Arriving at read_kmem() with an offset representing a bogus kernel
>> address (e.g. 0 from a simple "cat /dev/kmem") leads to copy_to_user
>> faulting on the kernel-space read.
>>
>> x86_64 happens to get away with this since the optimised implementation
>> uses "rep movs*", thus the user write (which is allowed to fault) and
>> the kernel read are the same instruction, the kernel-side fault falls
>> into the userspace fixup handler and a chain of events transpires
>> leading to returning the expected -EFAULT. On other architectures,
>> though, the read is not covered by the fixup entry for the write, and we
>> get a straightforward "Unable to hande kernel paging request..." dump.
>>
>> The more typical use-case of mmap_kmem() already validates the address
>> with pfn_valid() as one might expect, so let's make that consistent
>> across {read,write}_kem() too.
>>
>> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> I'm not sure if this warrants going to stable or not, as it's really
>> just making an existing failure case more graceful and less confusing.
>
> Returning -EFAULT because the kernel-side address (iow, file offset) is
> invalid is not particularly nice:
>
> NAME
>         read - read from a file descriptor
>
> ERRORS
>         EFAULT buf is outside your accessible address space.
>
> Latest POSIX has:
>
> ENXIO
> 	A request was made of a nonexistent device, or the
> 	request was outside the capabilities of the device.
>
> which to me looks like a better error code to return, as file offsets
> which are not valid can be interpreted as being "outside the
> capabilities of the device".  EFAULT has always on Linux meant that
> the user passed an invalid userspace buffer.

Good point - seems I failed to twig that the error code in the x86 case 
is still effectively falling out of the "fault with the user address" 
path. ENXIO indeed sounds more reasonable, thanks.

Robin.
