From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 3 Dec 2015 12:26:34 +0000
Subject: [RESEND v4 2/6] remoteproc: debugfs: Add ability to boot remote
 processor using debugfs
In-Reply-To: <CAJAp7Og2MPapOQmCSB9o4qwQHsA8_iyAWPhjHYPw6J=xCK2xew@mail.gmail.com>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
 <1448370862-19120-3-git-send-email-lee.jones@linaro.org>
 <CAJAp7Og2MPapOQmCSB9o4qwQHsA8_iyAWPhjHYPw6J=xCK2xew@mail.gmail.com>
Message-ID: <20151203122634.GX12874@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Nov 2015, Bjorn Andersson wrote:

> On Tue, Nov 24, 2015 at 5:14 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > This functionality is especially useful during the testing phase.  When
> > used in conjunction with Mailbox's Test Framework we can trivially conduct
> > end-to-end testing i.e. boot co-processor, send and receive messages to
> > the co-processor, then shut it down again (repeat as required).
> >
> 
> I want this too!
> 
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_debugfs.c | 34 +++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> > index 9d30809..8113c18 100644
> > --- a/drivers/remoteproc/remoteproc_debugfs.c
> > +++ b/drivers/remoteproc/remoteproc_debugfs.c
> > @@ -88,8 +88,42 @@ static ssize_t rproc_state_read(struct file *filp, char __user *userbuf,
> >         return simple_read_from_buffer(userbuf, count, ppos, buf, i);
> >  }
> >
> > +static ssize_t rproc_state_write(struct file *filp, const char __user *userbuf,
> > +                                size_t count, loff_t *ppos)
> > +{
> > +       struct rproc *rproc = filp->private_data;
> > +       char buf[10];
> > +       int ret;
> > +
> > +       if (count > sizeof(buf))
> > +               return count;
> > +
> > +       ret = copy_from_user(buf, userbuf, count);
> > +       if (ret)
> > +               return -EFAULT;
> > +
> > +       if (buf[count - 1] == '\n')
> > +               buf[count - 1] = '\0';
> 
> I believe you can get here with count = 0.

I'm pretty sure you can't.

If you are sure that you can, if you can provide me with a way of
testing, I'd be happy to put in provisions.

> > +
> > +       if (!strncmp(buf, "start", count)) {
> > +               ret = rproc_boot(rproc);
> > +               if (ret) {
> > +                       dev_err(&rproc->dev, "Boot failed: %d\n", ret);
> > +                       return ret;
> > +               }
> > +       } else if (!strncmp(buf, "stop", count)) {
> > +               rproc_shutdown(rproc);
> > +       } else {
> > +               dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
> 
> Unrecognized

What I have is correct.

> > +               return -EINVAL;
> > +       }
> > +
> > +       return count;
> > +}
> > +
> >  static const struct file_operations rproc_state_ops = {
> >         .read = rproc_state_read,
> > +       .write = rproc_state_write,
> >         .open = simple_open,
> >         .llseek = generic_file_llseek,
> >  };
> 
> Part of these nits
> 
> Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
