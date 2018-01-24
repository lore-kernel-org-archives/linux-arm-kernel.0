From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 24 Jan 2018 23:33:50 +0000
Subject: [PATCH v2 4/4] drivers: firmware: xilinx: Add debugfs interface
In-Reply-To: <20180123084103.GC21463@kroah.com>
References: <1516220434-22204-1-git-send-email-jollys@xilinx.com>
 <1516220434-22204-5-git-send-email-jollys@xilinx.com>
 <20180123084103.GC21463@kroah.com>
Message-ID: <DM2PR0201MB0767AE5B7E37276806A3FED4B8E20@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review Greg,

> -----Original Message-----
> From: Greg KH [mailto:gregkh at linuxfoundation.org]
> Sent: Tuesday, January 23, 2018 12:41 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v2 4/4] drivers: firmware: xilinx: Add debugfs interface
> 
> On Wed, Jan 17, 2018 at 12:20:34PM -0800, Jolly Shah wrote:
> > +/* Setup debugfs fops */
> > +static const struct file_operations fops_zynqmp_pm_dbgfs = {
> > +       .owner  =       THIS_MODULE,
> > +       .write  =       zynqmp_pm_debugfs_api_write,
> > +       .read   =       zynqmp_pm_debugfs_api_version_read,
> > +};
> > +
> > +/**
> > + * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
> > + *
> > + * Return:      Returns 0 on success
> > + *             Corresponding error code otherwise
> > + */
> > +int zynqmp_pm_api_debugfs_init(void)
> > +{
> > +       int err;
> > +
> > +       /* Initialize debugfs interface */
> > +       zynqmp_pm_debugfs_dir = debugfs_create_dir(DRIVER_NAME, NULL);
> > +       if (!zynqmp_pm_debugfs_dir) {
> > +               pr_err("debugfs_create_dir failed\n");
> > +               return -ENODEV;
> > +       }
> 
> No, you should NEVER care if a debugfs call returned an error or not, no need to
> check it at all.  Your code path should not change based on the return value as
> no code should depened on the functionality of debugfs.
> 
> Any error returned by a debugfs call can be passed right back into it with no
> problems, so again, no need to check this.
> 

Fixed in v3 patch series. Not saving dentries anymore but added check to show warning message instead of error.

> > +
> > +       zynqmp_pm_debugfs_power =
> > +               debugfs_create_file("pm", 0220,
> > +                                   zynqmp_pm_debugfs_dir, NULL,
> > +                                   &fops_zynqmp_pm_dbgfs);
> > +       if (!zynqmp_pm_debugfs_power) {
> > +               pr_err("debugfs_create_file power failed\n");
> > +               err = -ENODEV;
> > +               goto err_dbgfs;
> > +       }
> > +
> > +       zynqmp_pm_debugfs_api_version =
> > +               debugfs_create_file("api_version", 0444,
> > +                                   zynqmp_pm_debugfs_dir, NULL,
> > +                                   &fops_zynqmp_pm_dbgfs);
> > +       if (!zynqmp_pm_debugfs_api_version) {
> > +               pr_err("debugfs_create_file api_version failed\n");
> > +               err = -ENODEV;
> > +               goto err_dbgfs;
> > +       }
> 
> Why do you save these dentries at all anyway?  You never do anything with
> them, just create the files and away you go, no need to worry about anything.
> 
> Remember, debugfs was created to be very simple to use, don't make it more
> complex than it has to be please.
> 
> thanks,
> 
> greg k-h

Fixed in v3 patch series.

Thanks,
Jolly Shah
