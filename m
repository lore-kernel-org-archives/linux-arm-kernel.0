From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Wed, 22 Aug 2012 23:48:30 +0200
Subject: [RFC][PATCH] Disintegrate sharpsl_param.c
In-Reply-To: <1345663182.3907.134.camel@ted>
References: <1345656424-31234-1-git-send-email-dromede@gmail.com>
 <1345663182.3907.134.camel@ted>
Message-ID: <CAHod+Ge_xVNmm7Y8vn+99mXW0Q_X1tgqMGLUCgMykWja8OikGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 9:19 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2012-08-22 at 19:27 +0200, dromede at gmail.com wrote:
> > From: Marko Katic <dromede.gmail.com>
> >
> > I recently tried running 3.6-rc2 kernel on my Sharp Zaurus C-1000. It
> > hanged almost immediately after uncompressing the kernel. I tracked the
> > problem down to a single line in arch/arm/common/sharpsl_param.c:
> >
> > memcpy(&sharpsl_param, (void *)PARAM_BASE, sizeof(struct
> > sharpsl_param_info));
> >
> > Commenting out the line makes the kernel boot just fine. This left me
> > wondering whether sharpsl_param.c is actually needed. Here's a comment
> > from sharpsl_param.c that describes what sharpsl_param.c actually does:
>
> Sharp went to the trouble of saving these values into the hardware and
> passing them into the drivers. They're basically used by the LCD
> initialisation code from what I remember. I don't remember what the
> risks are of incorrect values.
>
> >  So sharpsl_save_param() is supposed to fill the sharpsl_param_info
> > struct
> >  with various parameters or fill some of the struct fields with -1.
> >  I found only four drivers that use some of these
> >  parameters (only two parameters are used by these drivers, comadj and
> > phadadj).
> >  These drivers are:
> >
> >  drivers/video/backlight/corgi_lcd.c
> >  drivers/video/backlight/locomolcd.c
> >  drivers/video/backlight/tosa_bl.c
> >  drivers/video/backlight/tosa_lcd.c
> >
> >  These drivers also have default values when comadj or phadadj == -1.
> >  I checked what values are actually contained in this struct in
> >  earlier kernels. 3.2.24 kernel is the latest one i know of where
> >  sharpsl_save_param() works properly. And it also has these fields
> > initialised
> >  to -1.
>
> What values was it loading from the bootloader? Or are you saying that
> it wasn't finding the bootloader information and therefore just using -1
> for everything?
>
> >  So it seems to me that sharpsl_param.c is redundant as it currently
> > only
> >  serves to assign -1 to a few variables. And drivers that use these
> > variables
> >  then handle -1 with assigning default values.
>
> Its not redundant, it sounds like its just broken at some point, at
> least on the platform you tested and nobody has noticed/cared. The
> better solution would be to fix it. Obviously its much easier to delete
> the code though.
>
> Cheers,
>
> Richard
>
>
>

Hmmm, i ran some tests again and it seems that my previous tests were
wrong. Sharpsl_param works properly in 3.2.24. I see proper values in
comadj and phadaj fields. Please disregard this patch, i should've
been more thorough with my tests. I'll try to bisect and find out why
it doesn't work in 3.6-rc2. Actually, it's broken since at least 3.4,
that should narrow my search down.
