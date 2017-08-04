From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 4 Aug 2017 10:11:03 +0800
Subject: [PATCH 1/2] usb: mtu3: add a vbus debugfs interface
In-Reply-To: <20170803160135.GC20736@kroah.com>
References: <1501749439-8837-1-git-send-email-chunfeng.yun@mediatek.com>
 <20170803160057.GB20736@kroah.com> <20170803160135.GC20736@kroah.com>
Message-ID: <1501812663.25536.116.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-08-03 at 09:01 -0700, Greg Kroah-Hartman wrote:
> On Thu, Aug 03, 2017 at 09:00:57AM -0700, Greg Kroah-Hartman wrote:
> > On Thu, Aug 03, 2017 at 04:37:18PM +0800, Chunfeng Yun wrote:
> > > +static ssize_t ssusb_vbus_write(struct file *file,
> > > +	const char __user *ubuf, size_t count, loff_t *ppos)
> > > +{
> > > +	struct seq_file *sf = file->private_data;
> > > +	struct ssusb_mtk *ssusb = sf->private;
> > > +	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
> > > +	char buf[16];
> > > +
> > > +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> > > +		return -EFAULT;
> > > +
> > > +	if (!strncmp(buf, "on", 2)) {
> > > +		ssusb_set_vbus(otg_sx, 1);
> > > +	} else if (!strncmp(buf, "off", 3)) {
> > > +		ssusb_set_vbus(otg_sx, 0);
> > 
> > kstrtobool() is better to use here.
Ok
> > 
> > > +static int ssusb_debugfs_init(struct ssusb_mtk *ssusb)
> > >  {
> > >  	struct dentry *root;
> > >  	struct dentry *file;
> > >  
> > >  	root = debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
> > >  	if (IS_ERR_OR_NULL(root)) {
> > 
> > That test is wrong, you should never need to care about the return value
> > of a debugfs call.  You can always just use it in your next call (if it
> > is a dentry *), or just ignore it.
Ok, I'll just test NULL pointer, and ignore other ERROR value
> > 
> > > -		if (!root)
> > > -			dev_err(ssusb->dev, "create debugfs root failed\n");
> > > -		return;
> > > +		dev_err(ssusb->dev, "create debugfs root failed\n");
> > > +		goto err_dbgfs;
> > >  	}
> > >  	ssusb->dbgfs_root = root;
> > >  
> > > -	file = debugfs_create_file("mode", S_IRUGO | S_IWUSR, root,
> > > -			ssusb, &ssusb_mode_fops);
> > > -	if (!file)
> > > -		dev_dbg(ssusb->dev, "create debugfs mode failed\n");
> > > +	file = debugfs_create_file("mode", 0644, root, ssusb, &ssusb_mode_fops);
> > > +	if (!file) {
> > > +		dev_err(ssusb->dev, "create debugfs mode failed\n");
> > 
> > Same here, do not care, as it does not matter.  Actually, you don't even
> > need to keep the file pointer around, right?
Yes, you are right
> > 
> > > +		goto err_dbgfs;
> > > +	}
> > > +
> > > +	file = debugfs_create_file("vbus", 0644, root, ssusb, &ssusb_vbus_fops);
> > > +	if (!file) {
> > 
> > Same here, you don't care if debugfs fails or not, it should never
> > affect your code flow.
Ok

Thanks a lot
> > 
> > And don't you need to remove the directory when your module/hardware is
> > removed?  I don't see that happening here as you are not saving root off
> > anywhere.
> 
> Oh nevermind, you do save it, sorry for the noise...
> 
> greg k-h
