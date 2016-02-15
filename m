From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Feb 2016 18:15:43 +0000
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160215180333.GK10826@n2100.arm.linux.org.uk>
References: <20160214165010.GA3189@roeck-us.net>
 <20160215105909.GH12289@pengutronix.de> <56C1F19F.8090100@roeck-us.net>
 <56C20DD6.8050604@arm.com> <20160215180333.GK10826@n2100.arm.linux.org.uk>
Message-ID: <56C215CF.1030509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/02/16 18:03, Russell King - ARM Linux wrote:
> On Mon, Feb 15, 2016 at 05:41:42PM +0000, Sudeep Holla wrote:
>> Sorry for missing this earlier, I could reproduce this on my TC2.
>> The issue is with card-detect gpio probing. It's not related to AMBA
>> probing as discussed on the mail thread.
>>
>> mfd_add_device adds devices with of_node when cell->of_compatible is
>> matched, but the device created is expected to be matched based on name
>> which the patch under discussion clearly breaks.
>
> If I'm understanding you correctly, you're saying that MFD re-adds
> platform devices with the of_node of a new platform device pointing
> to an existing of_node, but expects this new platform device to
> match a _different_ driver?
>

Sorry if I was not clear.

I don't think it re-adds. IIUC mfd cells are specified inside the
mfd device DT node. MFD adds devices for it's child nodes with the
associated device node but with the name specified by MFD cells
matching the compatible.

> Sounds like MFD needs fixing.  I've said this before: of_node's must
> _never_ be copied between different device structures, especially
> when they are on the _same_ bus - quite simply because the driver
> core _can_ match using the DT compatible.
>

I don't think that's happening in this case at-least. For example:

Device node compatible: arm,vexpress-sysreg
Child node compatible: arm,vexpress-sysreg,sys_mci

MFD device is created for above child node with name
"basic-mmio-gpio.<id>.auto" as it matched the MFD cell of_compatible

Since there's no driver to match "arm,vexpress-sysreg,sys_mci", it fails
with $subject patch applied which otherwise would do normal name matching

-- 
Regards,
Sudeep
