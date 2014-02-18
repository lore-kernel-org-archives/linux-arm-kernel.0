From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Feb 2014 11:50:19 -0600
Subject: [PATCH v4 1/2] usb: musb: dsps, debugfs files
In-Reply-To: <20140218173021.GA17368@kroah.com>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
 <1389950556-6453-2-git-send-email-mpa@pengutronix.de>
 <20140218162054.GE9878@saruman.home>
 <20140218165911.GA17486@kroah.com>
 <20140218170335.GC28506@saruman.home>
 <20140218173021.GA17368@kroah.com>
Message-ID: <20140218175018.GF28506@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 18, 2014 at 09:30:21AM -0800, Greg KH wrote:
> > > > > +static int dsps_musb_dbg_init(struct musb *musb, struct dsps_glue *glue)
> > > > > +{
> > > > > +	struct dentry *root;
> > > > > +	struct dentry *file;
> > > > > +	char buf[128];
> > > > > +
> > > > > +	sprintf(buf, "%s.dsps", dev_name(musb->controller));
> > > > > +	root = debugfs_create_dir(buf, NULL);
> > > > > +	if (!root)
> > > > 
> > > > wrong, you should be using IS_ERR()
> > > 
> > > !root is fine, IS_ERR() will fail if CONFIG_DEBUGFS is not enabled.
> > 
> > in that case, files will be created on parent directory right ?
> 
> If, for some reason, creating a directory fails and then creating a file
> would succeed, yes, that will happen.
> 
> > If we pass a ERR_PTR(-ENODEV), otoh, we will try to dereference it in
> > __create_file().
> 
> No, because -ENODEV will only happen if debugfs is not enabled, so no
> dereference will ever happen.
> 
> Don't worry about checking return values from debugfs, it shouldn't be
> needed.

aha, now I see. I missed the:

348         if (error) {
349                 dentry = NULL;
350                 simple_release_fs(&debugfs_mount, &debugfs_mount_count);
351         }

in fs/debugfs/inode.c::__create_file(). I'll apply this patch in a few
hours (randconfig running).

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/508bb275/attachment.sig>
