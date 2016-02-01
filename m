From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Feb 2016 13:25:57 +0000
Subject: [RFC PATCH] irq/mbigen:Fix the problem of IO remap for
 duplicated physical address in mbigen driver
In-Reply-To: <56AF585E.6050005@huawei.com>
References: <1454327094-7848-1-git-send-email-majun258@huawei.com>
 <20160201115717.GD674@leverpostej> <56AF585E.6050005@huawei.com>
Message-ID: <20160201132557.GG674@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 09:06:38PM +0800, majun (F) wrote:
> 
> 
> ? 2016/2/1 19:57, Mark Rutland ??:
> > On Mon, Feb 01, 2016 at 07:44:54PM +0800, MaJun wrote:
> >> From: Ma Jun <majun258@huawei.com>
> >>
> >> For mbigen module, there is a special case that more than one mbigen 
> >> device nodes use the same reg definition in DTS when these devices
> >> exist in the same mbigen hardware module. 
> >>
> >> mbigen_dev1:intc_dev1 {
> >> 	...
> >> 	reg = <0x0 0xc0080000 0x0 0x10000>;
> >> 	...
> >> };
> >>
> >> mbigen_dev2:intc_dev2 {
> >> 	...
> >> 	reg = <0x0 0xc0080000 0x0 0x10000>;
> >> 	...
> >> };
> > 
> > This doesn't sound right. If they exist in the same place, and have the
> > same reg, they _are_ the same device.
> > 
> > You'll need to explain this better.
> > 
> 
> For a mbigen hardware module which connecte with several devices,
> because these devices has different device ID,
> I need to define a device node for each device in DTS file.
> 
> 	mbigen
> 	|
> ------------------
> | 	| 	|
> dev1 	dev2 	dev3
> 
> Because of register layout,the registers related with these devices
> are put together, I can't split them clearly.
> So, I only make these devices which connect with
> same mbigen hardware module usethe same address.

This sounds like we've either mis-described the mbigen in the binding,
or we're mis-describing the relationship with the devices.

It should not be necessary to describe the same set of registers
repeatedly.

> >>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> -	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
> >> +	mgn_chip->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> > 
> > These two behaving differently doesn't seem correct either...
> 
> The problem is caused by memory region check fail because of
> duplicated address in devm_ioremap_resource().

The check is sensible. Using devm_ioremap rather than
devm_ioremap_resource to avoid the check is not the correct solution.

> For mbigen special case, there is no necessary to do this check.

I'm not sure I fully agree.

Regardless, this is not the right solution; it is fragile at best.

Thanks,
Mark.
