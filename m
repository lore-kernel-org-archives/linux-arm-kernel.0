From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 8 Jul 2015 14:11:29 -0700
Subject: [PATCH v4 3/5] tee: generic TEE subsystem
In-Reply-To: <20150708171026.GA11740@obsidianresearch.com>
References: <1436350592-7732-1-git-send-email-jens.wiklander@linaro.org>
 <1436350592-7732-4-git-send-email-jens.wiklander@linaro.org>
 <20150708171026.GA11740@obsidianresearch.com>
Message-ID: <20150708211129.GA29824@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 11:10:26AM -0600, Jason Gunthorpe wrote:
> On Wed, Jul 08, 2015 at 12:16:30PM +0200, Jens Wiklander wrote:
> 
> > +static void tee_device_complete_unused(struct kref *kref)
> > +{
> > +	struct tee_device *teedev;
> > +
> > +	teedev = container_of(kref, struct tee_device, users);
> > +	/* When the mutex is released, no other tee_device_get() will succeed */
> > +	teedev->desc = NULL;
> > +	complete(&teedev->c_no_users);
> > +}
> > +
> > +void tee_device_put(struct tee_device *teedev)
> > +{
> > +	mutex_lock(&teedev->mutex);
> > +	/* Shouldn't put in this state */
> > +	if (!WARN_ON(!teedev->desc))
> > +		kref_put(&teedev->users, tee_device_complete_unused);
> > +	mutex_unlock(&teedev->mutex);
> > +}
> > +
> > +bool tee_device_get(struct tee_device *teedev)
> > +{
> > +	mutex_lock(&teedev->mutex);
> > +	if (!teedev->desc) {
> > +		mutex_unlock(&teedev->mutex);
> > +		return false;
> > +	}
> > +	kref_get(&teedev->users);
> > +	mutex_unlock(&teedev->mutex);
> > +	return true;
> > +}
> 
> If you are holding the mutex then you don't really need a kref, just a
> simple active count counter.
> 
> I've been a bit learly lately about seeing krefs used for something
> other than kfree, I've seen a few subtle mistakes in those schemes -
> yours looks OK, only because of the lock, and the lock makes the kref
> redundant..
> 
> > +       cdev_init(&teedev->cdev, &tee_fops);
> > +       teedev->cdev.owner = teedesc->owner;
> 
> This also needs to set teedev->cdev.kobj.parent.
> I'm guessing:
> 
>  teedev->cdev.kobj.parent = &teedev->dev.kobj;
> 
> TPM had the same mistake..

Really?  As of a few years ago, A cdev's kobject should not be touched
by anything other than the cdev core.  It's not a "real" kobject in that
it is never registered in sysfs, and no one sees it.  I keep meaning to
just use something else one of these days for that structure, as lots of
people get it wrong.  Or has things changed there?

thanks,

greg k-h
