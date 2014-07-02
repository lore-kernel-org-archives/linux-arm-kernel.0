From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Jul 2014 21:01:02 +0200
Subject: [patch 3/4] timerfd: Implement timerfd_ioctl method to restore
 timerfd_ctx::ticks
In-Reply-To: <20140702170416.GG12440@moon>
References: <20140623185431.396309193@openvz.org>
 <53B4382F.9030908@codeaurora.org> <20140702170416.GG12440@moon>
Message-ID: <4188254.Av1Z2pQssC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 July 2014 21:04:16 Cyrill Gorcunov wrote:
> On Wed, Jul 02, 2014 at 12:49:51PM -0400, Christopher Covington wrote:
> > >  
> > > +#ifdef CONFIG_CHECKPOINT_RESTORE
> > > +static long timerfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > +{
> > > +   struct timerfd_ctx *ctx = file->private_data;
> > > +   int ret = 0;
> > > +
> > > +   switch (cmd) {
> > > +   case TFD_IOC_SET_TICKS: {
> > > +           u64 ticks;
> > > +
> > > +           if (get_user(ticks, (u64 __user *)arg))
> > 
> > 64-bit get_user is currently unsupported on ARM, although it appears work is
> > ongoing [1].
> > 
> > 1. https://lkml.org/lkml/2014/6/17/260
> 
> Thanks for info, Christopher! What arm camp is using then, copy-from-user?
> 

copy_from_user should work on all architectures. I believe a 64-bit get_user
is currently unsupported on most 32-bit architectures, x86-32 being a notable
exception.

	Arnd
