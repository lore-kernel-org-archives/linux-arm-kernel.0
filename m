From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 17 Jul 2017 17:28:17 +0300
Subject: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
In-Reply-To: <CAK8P3a1zBW_QuPtRFNwuVyE_ziySoV9_ebz4sD7Bya3eRoo8SA@mail.gmail.com>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <f57e08d9-0984-b67c-c64b-c7e0542d0361@xs4all.nl>
 <CAK8P3a1zBW_QuPtRFNwuVyE_ziySoV9_ebz4sD7Bya3eRoo8SA@mail.gmail.com>
Message-ID: <20170717142817.gq7xnmj3ajkvpqhe@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 04:26:23PM +0200, Arnd Bergmann wrote:
> On Mon, Jul 17, 2017 at 3:45 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > On 14/07/17 11:36, Arnd Bergmann wrote:
> >> @@ -201,8 +202,9 @@ static int cx18_g_fmt_sliced_vbi_cap(struct file *file, void *fh,
> >>        * digitizer/slicer.  Note, cx18_av_vbi() wipes the passed in
> >>        * fmt->fmt.sliced under valid calling conditions
> >>        */
> >> -     if (v4l2_subdev_call(cx->sd_av, vbi, g_sliced_fmt, &fmt->fmt.sliced))
> >> -             return -EINVAL;
> >> +     ret = v4l2_subdev_call(cx->sd_av, vbi, g_sliced_fmt, &fmt->fmt.sliced);
> >> +     if (ret)
> >> +             return ret;
> >
> > Please keep the -EINVAL here. I can't be 100% certain that returning 'ret' wouldn't
> > break something.
> 
> I think Dan was recommending the opposite here, if I understood you
> both correctly:
> he said we should propagate the error code unless we know it's wrong, while you
> want to keep the current behavior to avoid introducing changes ;-)
> 

I don't know the subsystem rules at all, so don't listen to me.

regards,
dan carpenter
