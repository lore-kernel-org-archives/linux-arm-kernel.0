From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Feb 2016 11:43:41 +0000
Subject: [RFC PATCH] irq/mbigen:Fix the problem of IO remap for
 duplicated physical address in mbigen driver
In-Reply-To: <56B08431.3000200@huawei.com>
References: <1454327094-7848-1-git-send-email-majun258@huawei.com>
 <20160201115717.GD674@leverpostej> <56AF585E.6050005@huawei.com>
 <20160201132557.GG674@leverpostej> <56B08431.3000200@huawei.com>
Message-ID: <20160202114340.GA28839@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 06:25:53PM +0800, majun (F) wrote:
> Hi Mark:
> 
> ? 2016/2/1 21:25, Mark Rutland ??:
> > On Mon, Feb 01, 2016 at 09:06:38PM +0800, majun (F) wrote:
> >>
> >>
> >> ? 2016/2/1 19:57, Mark Rutland ??:
> >>> On Mon, Feb 01, 2016 at 07:44:54PM +0800, MaJun wrote:
> >>>> From: Ma Jun <majun258@huawei.com>
> >>>>
> >>>> For mbigen module, there is a special case that more than one mbigen 
> >>>> device nodes use the same reg definition in DTS when these devices
> >>>> exist in the same mbigen hardware module. 
> >>>>
> >>>> mbigen_dev1:intc_dev1 {
> >>>> 	...
> >>>> 	reg = <0x0 0xc0080000 0x0 0x10000>;
> >>>> 	...
> >>>> };
> >>>>
> >>>> mbigen_dev2:intc_dev2 {
> >>>> 	...
> >>>> 	reg = <0x0 0xc0080000 0x0 0x10000>;
> >>>> 	...
> >>>> };
> >>>
> >>> This doesn't sound right. If they exist in the same place, and have the
> >>> same reg, they _are_ the same device.
> >>>
> >>> You'll need to explain this better.
> >>>
> >>
> >> For a mbigen hardware module which connecte with several devices,
> >> because these devices has different device ID,
> >> I need to define a device node for each device in DTS file.
> >>
> >> 	mbigen
> >> 	|
> >> ------------------
> >> | 	| 	|
> >> dev1 	dev2 	dev3
> >>
> >> Because of register layout,the registers related with these devices
> >> are put together, I can't split them clearly.
> >> So, I only make these devices which connect with
> >> same mbigen hardware module usethe same address.
> > 
> > This sounds like we've either mis-described the mbigen in the binding,
> > or we're mis-describing the relationship with the devices.
> > 
> 
> Sorry, I didn't express myself clearly.
> 
> For example, a mbigen hardware module can support several peripheral devices
> with different device ID.
> 
> |-----------------------|-
> |	mbigen		|
> |-----------------------|-
>  |       |        |
> dev1    dev2     dev3
> 
> To simplify the mbigen drvier,
> I didn't use the whole mbigen module as a mbgien device, but use
> the register collections(vector, trigger type,status etc.) corresponding
> to a peripheral device as a mbigen device.
> So, mbigen device is a logical conception or logical device.

>From the above, it sounds like the DT representation is not an accurate
representation of the hardware. We should describe the _whole_ mbigen,
not portions thereof. Trying to describe it piecemeal leads to problems
like this one.

I don't understand the rationale for describing the mbigen as separate
nodes. Above you mention that we "need to define a device node for each
device", but I don't see why that's necessary. Why do you believe we
need an mbigen node per client device?

As far as I can tell, we should be able to map an arbitrary
interrupt-specifier to a particular MSI (complete with device id) within
the mbigen driver. We just need to define the full set of MSIs the
mbigen owns.

> Now, a mbigen hardware module contains several logical mbigen device.
> 
> -------------------------------
> |mgn_dev1  mgn_dev2  mgn_dev3 |
> |-----------------------------|
>    |          |        |
> dev1	    dev2      dev3
> 
> So,mgn_dev1, mgn_dev2 and mgn_dev3 exist in same mbigen hardware module,
> and,they use the same reg address region,that is adress of mbigen hardware module.
> 
> For this case, I think the question is can we map an reg address
> region more than one time?

As above, I think we've mis-described the hardware. Rather than making
things simpler, this has resulted in problems like this one.

We should not map a reg region more than once. Even if it's technically
possible to do so, I do not believe that would be the right solution
here. Implicitly sharing resources (e.g. portions of the mbigen control
registers) is inevitably going to lead to more problems later on.

Mark.
