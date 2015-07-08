From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 8 Jul 2015 16:26:49 -0600
Subject: [PATCH v4 3/5] tee: generic TEE subsystem
In-Reply-To: <20150708211129.GA29824@kroah.com>
References: <1436350592-7732-1-git-send-email-jens.wiklander@linaro.org>
 <1436350592-7732-4-git-send-email-jens.wiklander@linaro.org>
 <20150708171026.GA11740@obsidianresearch.com>
 <20150708211129.GA29824@kroah.com>
Message-ID: <20150708222649.GA20068@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 02:11:29PM -0700, Greg Kroah-Hartman wrote:
> > > +       cdev_init(&teedev->cdev, &tee_fops);
> > > +       teedev->cdev.owner = teedesc->owner;
> > 
> > This also needs to set teedev->cdev.kobj.parent.
> > I'm guessing:
> > 
> >  teedev->cdev.kobj.parent = &teedev->dev.kobj;
> > 
> > TPM had the same mistake..
> 
> Really?  As of a few years ago, A cdev's kobject should not be touched
> by anything other than the cdev core.  It's not a "real" kobject in that
> it is never registered in sysfs, and no one sees it.  I keep meaning to

Well, when I looked at it, it looked like it was necessary to maintain
the refcount on the memory that is holding cdev.

The basic issue is that cdev_del doesn't seem to be synchronizing.

The use after free race is then something like:

   struct tpm_chip {
 	struct device dev;
	struct cdev cdev;

       CPU0                            CPU1
=================             ======================
tpm_chip = kalloc
cdev_add(&tpm_chip->cdev)
device_add(&tpm_chip->dev)
                                chrdev_open
		                 filp->f_op->open
cdev_del(&tpm_chip->cdev)
device_unregister
   (&tpm_chip->dev)
 kfree(tpm_chip)
		                  tpm_chip = container_of
				 fput
				  cdev_put(.. cdev)

Ie we need cdev to hold a ref on tpm_chip->dev until cdev_put is
called.

> just use something else one of these days for that structure, as lots of
> people get it wrong.  Or has things changed there?

Not recently, but this is the commit:

commit 2f0157f13f42800aa3d9017ebb0fb80a65f7b2de
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sun Oct 21 17:57:19 2012 -0700

    char_dev: pin parent kobject
    
    In certain cases (for example when a cdev structure is embedded into
    another object whose lifetime is controlled by a separate kobject) it is
    beneficial to tie lifetime of another object to the lifetime of
    character device so that related object is not freed until after
    char_dev object is freed.
    
    To achieve this let's pin kobject's parent when doing cdev_add() and
    unpin when last reference to cdev structure is being released.
    
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Acked-by: Al Viro <viro@zeniv.linux.org.uk>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

It doesn't seem the be the best situation, this is the 3rd time this
week I've noticed cdev with a kalloc'd struct being used improperly.

Perhaps cdev_init should accept the module and kref parent as an
argument?

Jason
