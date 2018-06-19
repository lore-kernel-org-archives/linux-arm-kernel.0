From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 20 Jun 2018 05:29:59 +0900
Subject: [RFC PATCH v2] driver core: add a debugfs entry to show deferred
 devices
In-Reply-To: <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
References: <20180619183356.32106-1-javierm@redhat.com>
 <CAHp75Vcn39N9rZ0UO3szGrODVLxek4X746uWs+RPXwy4i0s1Ug@mail.gmail.com>
 <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
Message-ID: <20180619202959.GA19129@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 10:55:20PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 19, 2018 at 10:53 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 19, 2018 at 9:33 PM, Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> For debugging purposes it may be useful to know what are the devices whose
> >> probe function was deferred. Add a debugfs entry showing that information.
> 
> >> +static int deferred_devs_open(struct inode *inode, struct file *file)
> >> +{
> >> +       return single_open(file, deferred_devs_show, inode->i_private);
> >> +}
> >> +
> >> +static const struct file_operations deferred_devs_fops = {
> >> +       .owner = THIS_MODULE,
> >> +       .open = deferred_devs_open,
> >> +       .read = seq_read,
> >> +       .llseek = seq_lseek,
> >> +       .release = single_release,
> >> +};
> >
> > Isn't this DEFINE_SHOW_ATTRIBUTE() ?
> 
> Besides that, you are summoning Greg's dark side :-)
> See below.
> 
> >> +       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> >> +               deferred_devices = debugfs_create_file("deferred_devices",
> >> +                                                      0444, NULL, NULL,
> >> +                                                      &deferred_devs_fops);
> 
> >> +               if (!deferred_devices)
> >> +                       return -ENOMEM;
> 
> This must not prevent the execution. So, the check introduces actually
> a regression.

Awe, you beat me to it :)

Also, I don't usually comment on RFC patches, as that shows the author
really doesn't think that the code is ready to be reviewed/merged...

thanks,

greg k-h
