From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 7 Jan 2014 11:54:12 -0800
Subject: [PATCH v2 3/7] mfd: pm8921: Migrate to irqdomains
In-Reply-To: <20140107082233.GB3182@lee--X1>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-4-git-send-email-sboyd@codeaurora.org>
 <20140106155350.GI30156@lee--X1> <52CB1323.6080200@codeaurora.org>
 <20140107082233.GB3182@lee--X1>
Message-ID: <20140107195412.GC14405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07, Lee Jones wrote:
> > >> +	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> > >> +}
> > > Can't you use the MFD core instead?
> > >
> > 
> > Are you suggesting using mfd_add_devices()? At first glance it looks
> > like that would require an array of mfd_cell structures that do nothing
> > besides match compatible strings in the DT. Using of_platform_populate()
> > achieves the same goal and doesn't require an array of mfd_cell
> > structures for each different pm8xxx chip that comes along, meaning
> > simpler code.
> 
> I'm inclined to agree, but playing Devil's advocate here, as a device
> using the MFD subsystem it's often clearer to readers and other people
> looking for examples if the MFD core functionality is used. For
> instance, I now have no idea what devices the PM8xxx encompasses
> without looking at the DTS file. A small cell structure is a small
> price to pay for code clarity IMHO.
> 

Why not just put that information in the binding document? And
how is this different from adding a bunch of C files to match a
set of compatible strings that a dts file has just so that we can
add all the devices on a board (think board files for an SoC).
Sure it documents the devices on a board, but we've been moving
away from that by using of_platform_populate().

IMHO the code is clear. I want to add all subnodes of this
device's node as children struct devices. Using
of_platform_populate() says that, whereas mfd_add_devices() says
I want to add these specific subnodes of this device's node.

Also, as more drivers are written and more bindings are ratified
this platform driver will need to be updated with more cells and
more compatible strings, causing more inter-tree dependencies and
more patches. Please, let's avoid this if we can.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
