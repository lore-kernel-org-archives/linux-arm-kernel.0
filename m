From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 2 Oct 2015 10:32:01 +0100
Subject: [PATCH v3 2/5] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <CABb+yY2wJKBvL3eceVxkq3ZdS6V+-yqQp98YCaS_oR+3CobQ0g@mail.gmail.com>
References: <1439994175-13360-1-git-send-email-lee.jones@linaro.org>
 <1439994175-13360-3-git-send-email-lee.jones@linaro.org>
 <CABb+yY2wJKBvL3eceVxkq3ZdS6V+-yqQp98YCaS_oR+3CobQ0g@mail.gmail.com>
Message-ID: <20151002093201.GA23213@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Oct 2015, Jassi Brar wrote:

> On Wed, Aug 19, 2015 at 7:52 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> ....
> 
> > +
> > +#define MBOX_BASE(mdev, inst)   ((mdev)->base + (inst * 4))
> >
> It should be    (inst) * 4

I'm guessing you mean:

  ((mdev)->base + ((inst) * 4))

?

> > +/**
> > + * STi Mailbox device data
> > + *
> > + * An IP Mailbox is currently composed of 4 instances
> > + * Each instance is currently composed of 32 channels
> > + * This means that we have 128 channels per Mailbox
> > + * A channel an be used for TX or RX
> > + *
> > + * @dev:       Device to which it is attached
> > + * @mbox:      Representation of a communication channel controller
> > + * @base:      Base address of the register mapping region
> > + * @name:      Name of the mailbox
> > + * @enabled:   Local copy of enabled channels
> > + * @lock:      Mutex protecting enabled status
> > + */
> > +struct sti_mbox_device {
> > +       struct device           *dev;
> > +       struct mbox_controller  *mbox;
> > +       void __iomem            *base;
> > +       const char              *name;
> > +       u32                     enabled[STI_MBOX_INST_MAX];
> > +       spinlock_t              lock;
> > +       bool                    txonly;
> >
> txonly is never used after being initialized from DT :)   which is a
> good sign. So maybe just drop it and the optional property 'tx-only'.

Okay.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
