From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 23 Aug 2013 11:06:25 -0500
Subject: [PATCH RFC v2 2/5] spmi: Linux driver framework for SPMI
In-Reply-To: <20130822231054.GA31973@kroah.com>
References: <cover.1377202730.git.joshc@codeaurora.org>
 <46db5901fe4d04d09cee8fd81ea1c62068ee9503.1377202730.git.joshc@codeaurora.org>
 <20130822231054.GA31973@kroah.com>
Message-ID: <20130823160625.GP4035@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 04:10:54PM -0700, Greg Kroah-Hartman wrote:
> On Fri, Aug 09, 2013 at 01:37:09PM -0700, Josh Cartwright wrote:
> > +static char dbgfs_help[] =
> > +	"SPMI Debug-FS support\n"
> > +	"\n"
> > +	"Hierarchy schema:\n"
> > +	"/sys/kernel/debug/spmi\n"
> > +	"       /help                -- Static help text\n"
> > +	"       /spmi-0              -- Directory for SPMI bus 0\n"
> > +	"       /spmi-0/0-1          -- Directory for SPMI device '0-1'\n"
> > +	"       /spmi-0/0-1/address  -- Starting register for reads or writes\n"
> > +	"       /spmi-0/0-1/count    -- Number of registers to read (only used for reads)\n"
> > +	"       /spmi-0/0-1/data     -- Initiates the SPMI read (formatted output)\n"
> > +	"       /spmi-0/0-1/data_raw -- Initiates the SPMI raw read or write\n"
> > +	"       /spmi-n              -- Directory for SPMI bus n\n"
> > +	"\n"
> > +	"To perform SPMI read or write transactions, you need to first write the\n"
> > +	"address of the slave device register to the 'address' file.  For read\n"
> > +	"transactions, the number of bytes to be read needs to be written to the\n"
> > +	"'count' file.\n"
> > +	"\n"
> > +	"The 'address' file specifies the 20-bit address of a slave device register.\n"
> > +	"The upper 4 bits 'address[19..16]' specify the slave identifier (SID) for\n"
> > +	"the slave device.  The lower 16 bits specify the slave register address.\n"
> > +	"\n"
> > +	"Reading from the 'data' file will initiate a SPMI read transaction starting\n"
> > +	"from slave register 'address' for 'count' number of bytes.\n"
> > +	"\n"
> > +	"Writing to the 'data' file will initiate a SPMI write transaction starting\n"
> > +	"from slave register 'address'.  The number of registers written to will\n"
> > +	"match the number of bytes written to the 'data' file.\n"
> > +	"\n"
> > +	"Example: Read 4 bytes starting at register address 0x1234 for SID 2\n"
> > +	"\n"
> > +	"echo 0x21234 > address\n"
> > +	"echo 4 > count\n"
> > +	"cat data\n"
> > +	"\n"
> > +	"Example: Write 3 bytes starting at register address 0x1008 for SID 1\n"
> > +	"\n"
> > +	"echo 0x11008 > address\n"
> > +	"echo 0x01 0x02 0x03 > data\n"
> > +	"\n"
> > +	"Note that the count file is not used for writes.  Since 3 bytes are\n"
> > +	"written to the 'data' file, then 3 bytes will be written across the\n"
> > +	"SPMI bus.\n\n";
> 
> The help file within the kernel is a nice touch :)
> 
> I do know the only rule for debugfs is "There are no rules", but this
> looks like you are going to have the way to interact to this bus and
> devices as debugfs, is that correct?

Using debugfs is _a_ way to interact with the controller/slaves, however
it is not _the_ way to do so.  The primary interface is the in-kernel
spmi_{read,write,...}_* functions called within the context of a proper
slave driver.

> Or is this only for "debugging"?  If so, please document it as such.

It's there because it provides a useful interface for debugging of the
controller code, and for simple peek/poke of the slave registers without
having a full driver in place.  Will document this.

> > +void spmi_dfs_controller_add(struct spmi_controller *ctrl)
> > +{
> > +	ctrl->dfs_dir = debugfs_create_dir(dev_name(&ctrl->dev),
> > +					   spmi_debug_root);
> > +	WARN_ON(!ctrl->dfs_dir);
> 
> Why?  What is a user going to be able to do with something like this?
> You do this in a number of places, please provide "valid" error messages
> instead of just kernel stack tracebacks, failing to show the device for
> which the error occured (hint, use dev_err()).

Will do.  Thanks.

> Again, never use WARN_ON() as error handling, it's lazy, and wrong.

To be fair to the original author of this code, this was one of the
'cleanups' I implemented.  So, I'll take full responsibility for the
laziness. :)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
