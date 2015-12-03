From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 3 Dec 2015 17:28:30 +0000
Subject: [RESEND v4 2/6] remoteproc: debugfs: Add ability to boot remote
 processor using debugfs
In-Reply-To: <2600153.9u9Z7N2IT1@wuerfel>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
 <5329827.I5W30K072M@wuerfel> <20151203130341.GA26902@x1>
 <2600153.9u9Z7N2IT1@wuerfel>
Message-ID: <20151203172830.GB26902@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 03 Dec 2015, Arnd Bergmann wrote:

> On Thursday 03 December 2015 13:03:41 Lee Jones wrote:
> > On Thu, 03 Dec 2015, Arnd Bergmann wrote:
> > 
> > > On Thursday 03 December 2015 12:26:34 Lee Jones wrote:
> > > > > >
> > > > > > +static ssize_t rproc_state_write(struct file *filp, const char __user *userbuf,
> > > > > > +                                size_t count, loff_t *ppos)
> > > > > > +{
> > > > > > +       struct rproc *rproc = filp->private_data;
> > > > > > +       char buf[10];
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       if (count > sizeof(buf))
> > > > > > +               return count;
> > > > > > +       ret = copy_from_user(buf, userbuf, count);
> > > > > > +       if (ret)
> > > > > > +               return -EFAULT;
> > > > > > +
> > > > > > +       if (buf[count - 1] == '\n')
> > > > > > +               buf[count - 1] = '\0';
> > > > > 
> > > > > I believe you can get here with count = 0.
> > > > 
> > > > I'm pretty sure you can't.
> > > > 
> > > > If you are sure that you can, if you can provide me with a way of
> > > > testing, I'd be happy to put in provisions.
> > > > 
> > > 
> > > I think that a zero-length write() from user space ends up in the write
> > > file operation.
> > 
> > I tested this and didn't see it enter write().  My conclusion was that
> > if the file doesn't change, then nothing is triggered.
> > 
> 
> Ah, interesting. I haven't tried myself, and just tried to read the
> code. Maybe glibc already catches zero-length writes before it gets
> into the kernel, or I just missed the part of the syscall that checks
> for this.

Glibc is responsible indeed:
  
  http://osxr.org/glibc/source/io/write.c

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
