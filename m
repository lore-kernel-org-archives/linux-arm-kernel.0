From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Feb 2013 15:09:58 +0000
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <511A0F11.1050608@stericsson.com>
References: <511A0F11.1050608@stericsson.com>
Message-ID: <20130212150958.GO17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 10:44:49AM +0100, Jean-Nicolas GRAUX wrote:
> We did one small platform device driver to handle this piece of hardware.
> In the patch attached to this file, we kept the code in the mach-ux500  
> machine folder.
> But we are wondering where is the best place to put that stuff.
> So, the question is: where should we put this code in the kernel tree ?

That is one of the most difficult questions...

Definitely not in arch/arm.  Device drivers do not belong under arch/ but
under the drivers/ subtree.  Several possibilities:

drivers/platform/<appropriate-new-subdirectory>
drivers/misc/<appropriate-new-subdirectory>
drivers/misc

Also, consider getting rid of:
> ST-Ericsson-ID: 478266
> ST-Ericsson-FOSS-OUT-ID: Trivial

from your commit messages when you submit this upstream.

> +static const char readme[] =
> +	"\nHardware observer usage:\n\n"
> +	"./available_modes: List supported hardware observer modes.\n"
> +	"./ddr_select:      Set/get current ddr instance (0|1) to monitor.\n"
> +	"./enable:          Enable/disable hardware observer.\n"
> +	"./gpio_x:          Configure hardware observer IO number x in gpio output:\n"
> +	"                   Write IO number followed by 1 or 0 to select high/low output.\n"
> +	"                   example: echo \"12 1\" > gpio_x\n"
> +	"./mode:            Force a mode to all hardware observer IOs.\n"
> +	"./mode_x:          Set mode to one harware observer IO:\n"
> +	"                   Write IO number followed by mode to set current io mode:\n"
> +	"                   example: echo \"12 wake-up\" > mode_x\n"
> +	"./status:          Show current mode of all hardware observer IOs.\n";
> +
> +static int hwobs_readme(struct seq_file *s, void *p)
> +{
> +	return seq_printf(s, "%s", readme);
> +}

Eww, yuck, no.  We do not do stuff like that.  Put this in a file under
Documentation/ documenting the interface rather than littering the
debugfs with such things.  I'm sure if you started something like a
Documentation/filesystems/debugfs/ directory, you may make some new
friends!
