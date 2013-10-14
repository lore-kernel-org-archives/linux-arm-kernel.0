From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Oct 2013 11:44:39 +0100
Subject: [PATCH 01/11] usb: chipidea: Add power management support
In-Reply-To: <20131014075547.GA26191@shlinux1.ap.freescale.net>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
 <1381570513-24927-2-git-send-email-peter.chen@freescale.com>
 <20131014100458.4f577d01@ipc1.ka-ro>
 <20131014075547.GA26191@shlinux1.ap.freescale.net>
Message-ID: <20131014104439.GJ25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 03:55:48PM +0800, Peter Chen wrote:
> On Mon, Oct 14, 2013 at 10:04:58AM +0200, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Peter Chen wrote:
> > > This commit adds runtime and system power management support for
> > > chipidea core. The runtime pm support is controlled by glue
> > > layer, it can be enabled by flag CI_HDRC_SUPPORTS_RUNTIME_PM.
> > > 
> > [...]
> > > +#ifdef CONFIG_PM
> > > +static int ci_controller_suspend(struct device *dev)
> > > +{
> > > +	struct ci_hdrc *ci = dev_get_drvdata(dev);
> > > +
> > > +	dev_dbg(dev, "at %s\n", __func__);
> > > +
> > > +	if (atomic_read(&ci->in_lpm))
> > > +		return 0;
> > > +
> > What does this 'atomic_read()' buy you over just testing/assinging a
> > simple integer. Note that just because the function has 'atomic' in
> > its name the sequence:
> > 	atomic_read();
> > ...
> > 	atomic_set();
> > does not magically become an atomic operation.
> 
> I just want the read and set are atomic, not the operations
> between atomic_read and atomic_set.

There is nothing magical about atomic_read() or atomic_set():

#define atomic_read(v)  (*(volatile int *)&(v)->counter)
#define atomic_set(v,i) (((v)->counter) = (i))

You might as well just read and write the variable directly if you're
going to do this.  The atomicity of atomic_t comes from the *other*
operations which can be done on an atomic_t, not from some magical
macro which starts with the name "atomic_".

Lesson 1: whenever you see atomic_read() and atomic_set() in a patch
be very very very suspicious; it's 99% of times plainly wrong and a
sign of something being totally broken.
