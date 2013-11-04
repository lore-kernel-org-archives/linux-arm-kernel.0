From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 04 Nov 2013 15:24:26 +0100
Subject: [PATCH v4] videobuf2: Add missing lock held on vb2_fop_relase
In-Reply-To: <5277AB62.5000505@xs4all.nl>
References: <1383385994-11422-1-git-send-email-ricardo.ribalda@gmail.com>
 <527794F0.40901@xs4all.nl>
 <CAPybu_0cKxMxhXoSqbK2nTyX3DGCVZdUZPt2bTE6aZR65xDG=w@mail.gmail.com>
 <5277AB62.5000505@xs4all.nl>
Message-ID: <5277AE1A.6090303@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/13 15:12, Hans Verkuil wrote:
> On 11/04/2013 02:54 PM, Ricardo Ribalda Delgado wrote:
>> > Hello Hans
>> > 
>> > Thanks for your comments.
>> > 
>> > Please take a look to v4 of this patch
>> > https://patchwork.linuxtv.org/patch/20529/
>> > 
>> > On Mon, Nov 4, 2013 at 1:37 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>> >> On 11/02/2013 10:53 AM, Ricardo Ribalda Delgado wrote:
>>>> >>> From: Ricardo Ribalda <ricardo.ribalda@gmail.com>
>>>> >>>
>>>> >>> vb2_fop_relase does not held the lock although it is modifying the
>>>> >>> queue->owner field.
>>>> >>>
>>>> >>> This could lead to race conditions on the vb2_perform_io function
>>>> >>> when multiple applications are accessing the video device via
>>>> >>> read/write API:
>>> >>
>>> >> It's also called directly by drivers/media/usb/em28xx/em28xx-video.c!
>>> >>
>> > 
>> > em28xx-video does not hold the lock, therefore it can call the normal
>> > function. On v2 we made a internal function that should be called if
>> > the funciton is called directly by the driver. Please take a look to
>> > the old comments. https://patchwork.linuxtv.org/patch/20460/
>
> static int em28xx_v4l2_close(struct file *filp)
> {
>         struct em28xx_fh *fh  = filp->private_data;
>         struct em28xx    *dev = fh->dev;
>         int              errCode;
> 
>         em28xx_videodbg("users=%d\n", dev->users);
> 
>         mutex_lock(&dev->lock);
>         vb2_fop_release(filp);
> 	...
> 
> vb2_fop_release(filp) will, with your patch, also try to get dev->lock.
> 
> Sylwester's comment re em28xx is incorrect.

dev->lock is not used as the video queue lock:

$ git grep "lock =" drivers/media/usb/em28xx/
...
drivers/media/usb/em28xx/em28xx-video.c:        dev->vdev->queue->lock = &dev->vb_queue_lock;
drivers/media/usb/em28xx/em28xx-video.c:                dev->vbi_dev->queue->lock = &dev->vb_vbi_queue_lock;

There is a separate mutex for the video queue which needs to be acquired
independently.

--
Regards,
Sylwester
