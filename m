From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 7 Mar 2013 13:47:45 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307212854.24be187f@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <201303070337.43288.arnd@arndb.de> <20130307115817.3b3cad20@skate>
 <20130307173736.GA20840@obsidianresearch.com>
 <20130307201133.42a6c44b@skate>
 <20130307195541.GA20695@obsidianresearch.com>
 <20130307212854.24be187f@skate>
Message-ID: <20130307204745.GA23385@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 09:28:54PM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Thu, 7 Mar 2013 12:55:41 -0700, Jason Gunthorpe wrote:
> 
> > > Adding description of windows in the Device Tree can be added later on,
> > > in a completely DT backward compatible way, and the mvebu-devbus driver
> > > can be adjusted accordingly.
> > 
> > Hmm.. You could make a new DT that is compatible with an older kernel,
> > but once the mvebu_mbus_add_window is moved into the mbus driver it
> > would require an updated DT.
> 
> So what is your proposal that preserves non-DT compatibility? As I
> already said multiple times, we still have non-DT platforms around, and
> we can leave them on the side on this topic, so we have to have a
> solution that keeps non-DT compatibility for the moment.

Well, I'd keep it basically the same as we have now..

Non-DT platforms call into the mbus driver via code to create windows
before creating the platform device that will use the window. Use a
fixed address, or dynamic allocation, it doesn't matter. Pass the
resulting address in through the struct resource during platform
device register. This would be done in the same place as today, in the
non-DT board specific file.

Critically, the window is setup and address selected prior to the
platform device add and driver probe. In both the DT and non-DT case
the struct resource associated with the platform device is correct.

Something like this randomly choosen example.

static struct platform_device kirkwood_nand_flash = {
        .name           = "orion_nand",
        .id             = -1,
        .dev            = {
                .platform_data  = &kirkwood_nand_data,
        },
        .resource       = &kirkwood_nand_resource,
        .num_resources  = 1,
};

void __init kirkwood_nand_init(struct mtd_partition *parts, int nr_parts,
                               int chip_delay)
{
        kirkwood_nand_data.parts = parts;
        kirkwood_nand_data.nr_parts = nr_parts;
        kirkwood_nand_data.chip_delay = chip_delay;
+	mbus_assign_resource_window(&kirkwood_nand_flash.resource,
+  	                            MAPDEF(...));
        platform_device_register(&kirkwood_nand_flash);
}

That should work for all the non-DT support cases in the kernel today?

Regards,
Jason
