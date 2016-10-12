From: vigneshr@ti.com (Vignesh R)
Date: Wed, 12 Oct 2016 16:30:28 +0530
Subject: [PATCH RESEND] ARM: dts: keystone-k2*: Increase SPI Flash
 partition size for U-Boot
In-Reply-To: <20161010143144.GB1041@n2100.armlinux.org.uk>
References: <20161010141141.21333-1-vigneshr@ti.com>
 <20161010143144.GB1041@n2100.armlinux.org.uk>
Message-ID: <c3be6bfc-9cfa-bcd8-5988-ee8bdd9fa506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 10 October 2016 08:01 PM, Russell King - ARM Linux wrote:
> On Mon, Oct 10, 2016 at 07:41:41PM +0530, Vignesh R wrote:
>> U-Boot SPI Boot image is now more than 512KB for Keystone2 devices and
>> cannot fit into existing partition. So, increase the SPI Flash partition
>> for U-Boot to 1MB for all Keystone2 devices.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>
>> This was submitted to v4.9 merge window but was never picked up:
>> https://patchwork.kernel.org/patch/9135023/
> 
> I think you need to explain why it's safe to change the layout of the
> flash partitions like this.
> 
> - What is this "misc" partition?
> 

This partition seems to exists from the very beginning.  I believe, this
is just a spare area of flash that can be used as per end-user
requirement. Either to store a small filesystem or kernel. Copying
Murali who added above partition if he has any input here.

> - Why is it safe to move the "misc" partition in this way?
> 
> - Do users need to do anything with data stored in the "misc" partition
>   when changing kernels?
> 

MTD layer will take care of most abstractions (like start address etc).
Will add a note in commit message informing about the reduction in size
of the partition.

> If the "misc" partition is simply unused space on the flash device, why
> list it in DT?
> 

If the unused space is not listed in the DT, then there is no /dev/mtdX
node created for the unused section. User will then have to manually
edit DT, in order to get the node and mount it. Instead, lets make it
available by default.

-- 
Regards
Vignesh
