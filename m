From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Feb 2016 11:16:03 +0000
Subject: [RFC PATCH] irq/mbigen:Fix the problem of IO remap for
 duplicated physical address in mbigen driver
In-Reply-To: <56B16698.6050509@huawei.com>
References: <1454327094-7848-1-git-send-email-majun258@huawei.com>
 <20160201115717.GD674@leverpostej> <56AF585E.6050005@huawei.com>
 <20160201132557.GG674@leverpostej> <56B08431.3000200@huawei.com>
 <20160202114340.GA28839@leverpostej> <56B16698.6050509@huawei.com>
Message-ID: <20160203111602.GA1234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 10:31:52AM +0800, majun (F) wrote:
> 
> 
> ? 2016/2/2 19:43, Mark Rutland ??:
> > On Tue, Feb 02, 2016 at 06:25:53PM +0800, majun (F) wrote:
> >> To simplify the mbigen drvier,
> >> I didn't use the whole mbigen module as a mbgien device, but use
> >> the register collections(vector, trigger type,status etc.) corresponding
> >> to a peripheral device as a mbigen device.
> >> So, mbigen device is a logical conception or logical device.
> > 
> >>From the above, it sounds like the DT representation is not an accurate
> > representation of the hardware. We should describe the _whole_ mbigen,
> > not portions thereof. Trying to describe it piecemeal leads to problems
> > like this one.
> > 
> > I don't understand the rationale for describing the mbigen as separate
> > nodes. Above you mention that we "need to define a device node for each
> > device", but I don't see why that's necessary. Why do you believe we
> > need an mbigen node per client device?
> > 
> > As far as I can tell, we should be able to map an arbitrary
> > interrupt-specifier to a particular MSI (complete with device id) within
> > the mbigen driver. We just need to define the full set of MSIs the
> > mbigen owns.
> > 
> 
> mbigen device is a interrupt controller, it is also a ITS device for ITS module.
> So, we need to register the each mbigen device to ITS with a unique ID.
> Based on the current MSI/ITS driver, I can't register whole mbigen module which
> contains several mbigen devices at one time. Because they have different device ID.

I don't follow.

You can describe this by having a top-level mbigen node featuring a reg,
with a sub-node for each mbigen module with an appropriate msi-parent,
e.g.

mbigen {
	reg = < ... ... >;

	#interrupt-cells = <2>;

	#address-cells = <1>; /* module index */

	module at 0 {
		reg = <0>;
		msi-parent = <&its 0>;
	};

	module at 1 {
		reg = <1>;
		reg = <&its 1>;
	};
};


That clearly does not require the reg to be duplicated, and encodes the
information you want. The infrastructure for handling that might not
exist yet, but that is a Linux issue that we can fix.

Marc, thoughts?

I take it all interrupts within a module share the same device id?

> I don't know whether this explanation is clear or not.
> I think Marc can explain this well.
> 
> Marc, would you please help me explain this?  or, do you have any opinion about this ?
> 
> >> Now, a mbigen hardware module contains several logical mbigen device.
> >>
> >> -------------------------------
> >> |mgn_dev1  mgn_dev2  mgn_dev3 |
> >> |-----------------------------|
> >>    |          |        |
> >> dev1	    dev2      dev3
> >>
> >> So,mgn_dev1, mgn_dev2 and mgn_dev3 exist in same mbigen hardware module,
> >> and,they use the same reg address region,that is adress of mbigen hardware module.
> >>
> >> For this case, I think the question is can we map an reg address
> >> region more than one time?
> > 
> > As above, I think we've mis-described the hardware. Rather than making
> > things simpler, this has resulted in problems like this one.
> > 
> > We should not map a reg region more than once. Even if it's technically
> > possible to do so, I do not believe that would be the right solution
> > here. Implicitly sharing resources (e.g. portions of the mbigen control
> > registers) is inevitably going to lead to more problems later on.
> 
> Because we only need to write 1 into corresponding bit of status
> register to clear interrupt status during runtime,I think we don't
> need to worry about this.

That might be currently true, but I doubt that will remain true in
future. Presumably there are other control registers in the mbigen which
are shared between modules.

I think we do need to worry about this.

Mark.
