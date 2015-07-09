From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 8 Jul 2015 17:47:29 -0700
Subject: [PATCH v4 3/5] tee: generic TEE subsystem
In-Reply-To: <20150708235321.GB12393@kroah.com>
References: <1436350592-7732-1-git-send-email-jens.wiklander@linaro.org>
 <1436350592-7732-4-git-send-email-jens.wiklander@linaro.org>
 <20150708171026.GA11740@obsidianresearch.com>
 <20150708211129.GA29824@kroah.com>
 <20150708222649.GA20068@obsidianresearch.com>
 <20150708223325.GA5843@kroah.com>
 <20150708231612.GB20068@obsidianresearch.com>
 <20150708235321.GB12393@kroah.com>
Message-ID: <20150709004729.GC379@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:53:21PM -0700, Greg Kroah-Hartman wrote:
> On Wed, Jul 08, 2015 at 05:16:12PM -0600, Jason Gunthorpe wrote:
> > On Wed, Jul 08, 2015 at 03:33:25PM -0700, Greg Kroah-Hartman wrote:
> > > > The basic issue is that cdev_del doesn't seem to be synchronizing.
> > > > 
> > > > The use after free race is then something like:
> > > > 
> > > >    struct tpm_chip {
> > > >  	struct device dev;
> > > > 	struct cdev cdev;
> > > 
> > > Oops, right there's your problem.  You can't have two reference counted
> > > objects trying to manage the memory of a single structure.  No matter
> > > what you do, it's going to be a pain to deal with this, so don't :)
> > 
> > Sure, generally, yes, but that isn't done for no reason, it is to make
> > open straightforward:
> > 
> > static int tpm_open(struct inode *inode, struct file *file)
> > {
> > 	struct tpm_chip *chip =
> > 		container_of(inode->i_cdev, struct tpm_chip, cdev);
> > 
> > We need to recover the tpm_chip associated with the char device
> > node, in a way that is holding a kref on it, without racing with
> > cdev_del/etc
> > 
> > This scheme does mean that if we have a struct file we have a kref on
> > the cdev, and if we have cdev then we have a kref on the tpm_chip,
> > which is really easy to use properly.
> > 
> > > > Ie we need cdev to hold a ref on tpm_chip->dev until cdev_put is
> > > > called.
> > > 
> > > No, separate them, make the cdev a pointer and all should be fine.
> > 
> > Okay, cdev_alloc takes care of the cdev lifetime.
> > 
> > Do you have a simple solution to replace container_of as well?
> > 
> > What would you think about something like:
> > 
> >  cdev_alloc(&chip->dev.kref)
> 
> Just pick either the cdev to handle the lifetime rules, or the struct
> device, you'll still need a container_of().  Just don't do both as odds
> are the lifetime rules is going to get really hard to debug and ensure
> that everything is correct on the shutdown/release path.

It is not that simple. The issue is that we need to ensure that cdev
does not outlive the structure that represents the device, otherwise it
may disappear while cdev code tries to access it. So we need a way to
pin the "main" structure in memory until cdev is gone. But as I
mentioned in [1] cdev is "sealed" and does not give us a way of hooking
into add/release so that we can try to pin the object we need. And given
that the main driver model primitive is kobject even if we "unseal" cdev
everyone will end up doing pretty much what the above commit did.

Thanks.

-- 
Dmitry

[1] http://www.spinics.net/lists/kernel/msg1421595.html
