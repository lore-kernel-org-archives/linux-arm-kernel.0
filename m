From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 3 Dec 2015 13:03:41 +0000
Subject: [RESEND v4 2/6] remoteproc: debugfs: Add ability to boot remote
 processor using debugfs
In-Reply-To: <5329827.I5W30K072M@wuerfel>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
 <CAJAp7Og2MPapOQmCSB9o4qwQHsA8_iyAWPhjHYPw6J=xCK2xew@mail.gmail.com>
 <20151203122634.GX12874@x1> <5329827.I5W30K072M@wuerfel>
Message-ID: <20151203130341.GA26902@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 03 Dec 2015, Arnd Bergmann wrote:

> On Thursday 03 December 2015 12:26:34 Lee Jones wrote:
> > > >
> > > > +static ssize_t rproc_state_write(struct file *filp, const char __user *userbuf,
> > > > +                                size_t count, loff_t *ppos)
> > > > +{
> > > > +       struct rproc *rproc = filp->private_data;
> > > > +       char buf[10];
> > > > +       int ret;
> > > > +
> > > > +       if (count > sizeof(buf))
> > > > +               return count;
> > > > +       ret = copy_from_user(buf, userbuf, count);
> > > > +       if (ret)
> > > > +               return -EFAULT;
> > > > +
> > > > +       if (buf[count - 1] == '\n')
> > > > +               buf[count - 1] = '\0';
> > > 
> > > I believe you can get here with count = 0.
> > 
> > I'm pretty sure you can't.
> > 
> > If you are sure that you can, if you can provide me with a way of
> > testing, I'd be happy to put in provisions.
> > 
> 
> I think that a zero-length write() from user space ends up in the write
> file operation.

I tested this and didn't see it enter write().  My conclusion was that
if the file doesn't change, then nothing is triggered.

> Also, we get a gcc warning about the out-of-bounds access for code like
> this, and checking that count is larger than zero avoids the warning.

I did however see this warning and wondered what it was talking
about.  Thanks for clarifying.  Will fix.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
