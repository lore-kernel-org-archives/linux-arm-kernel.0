From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 9 Jul 2015 14:49:08 +0200
Subject: [PATCH v4 3/5] tee: generic TEE subsystem
In-Reply-To: <20150708171026.GA11740@obsidianresearch.com>
References: <1436350592-7732-1-git-send-email-jens.wiklander@linaro.org>
 <1436350592-7732-4-git-send-email-jens.wiklander@linaro.org>
 <20150708171026.GA11740@obsidianresearch.com>
Message-ID: <20150709124908.GA27483@ermac>
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

Thanks, I'll fix.

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

OK. This triggered a discussion, from what I understand the outcome
is that what you're suggesting is the right thing to do here.

> 
> > +void tee_device_unregister(struct tee_device *teedev)
> > +{
> > +	if (IS_ERR_OR_NULL(teedev))
> > +		return;
> 
> See for some general colour on IS_ERR_OR_NULL
> 
> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg78030.html
> 
> IMHO, you should never, store an ERR pointer into long term storage,
> so I wonder why this is like this...

OK, I'll replace the IS_ERR_OR_NULL with !teedev and only store a real
pointer or NULL here.

> 
> > +	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED) {
> > +		cdev_del(&teedev->cdev);
> > +		device_del(&teedev->dev);
> > +	}
> > +
> > +	tee_device_put(teedev);
> > +	wait_for_completion(&teedev->c_no_users);
> 
> Generally in a scheme like this we'd see open and release get/put the
> underlying module handle to prevent driver removal while the char dev
> is open. Otherwise module removal will hang here.

I'm perhaps misunderstanding you. While the cdev has any open file
descriptors rmmod will fail with "Resource temporarily unavailable"
because of fops_get() in chrdev_open().

tee_device_get()/put() deals with detaching of the driver, I see no
other way than blocking here once the detaching has been triggered.

--
Thanks,
Jens
