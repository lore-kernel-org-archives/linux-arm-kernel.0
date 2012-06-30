From: lokeshvutla@ti.com (Vutla, Lokesh)
Date: Sat, 30 Jun 2012 12:53:14 +0530
Subject: [PATCH] Watchdog: OMAP: Fix the runtime pm code to avoid module
 getting stuck intransition state.
In-Reply-To: <CAMQu2gwUgPewy98L+yF5bcdrqXRLZftb3utLNg5HV1jBscGpTQ@mail.gmail.com>
References: <1339996996-3257-1-git-send-email-lokeshvutla@ti.com>
 <CAMQu2gwUgPewy98L+yF5bcdrqXRLZftb3utLNg5HV1jBscGpTQ@mail.gmail.com>
Message-ID: <CAJ1gdcajf5RG7gsMC7V8qsS7KB9bFC_ox5Jj62CRCmmsTOSHhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle ping on this....



Thanks n regards
Lokesh Vutla
LDC MPUSS Platform Team



On Mon, Jun 18, 2012 at 11:11 AM, Shilimkar, Santosh <
santosh.shilimkar@ti.com> wrote:

> (You should cc linux-omap too.  CC'ing linux-omap)
>
> On Mon, Jun 18, 2012 at 10:53 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> > OMAP watchdong driver is adapted to runtime PM like a general device
> > driver but it is not appropriate. It is causing couple of functional
> > issues.
> >
> > 1. On OMAP4 SYSCLK can't be gated, because of issue with WDTIMER2 module,
> > which constantly stays in "in transition" state. Value of register
> > CM_WKUP_WDTIMER2_CLKCTRL is always 0x00010000 in this case.
> > Issue occurs immediately after first idle, when hwmod framework tries
> > to disable WDTIMER2 functional clock - "wd_timer2_fck". After this
> > module falls to "in transition" state, and SYSCLK gating is blocked.
> >
> > 2. Due to runtime PM, watchdog timer may be completely disabled.
> > In current code base watchdog timer is not disabled only because of
> > issue 1. Otherwise state of WDTIMER2 module will be "Disabled", and there
> > will be no interrupts from omap_wdt. In other words watchdog will not
> > work at all.
> >
> > Watchdong is a special IP and it should not be disabled otherwise
> > purpose of it itself is defeated. Watchdog functional clock should
> > never be disabled. This patch updates the runtime PM handling in
> > driver so that runtime PM is limited only during probe/shutdown
> > and suspend/resume.
> >
> > The patch fixes issue 1 and 2
> >
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Wim Van Sebroeck <wim@iguana.be>
> > ---
> > Tested on OMAP4430SDP.
> >
> > Issue #1 can be easily reproduced on mainline kernel.
> > - Take latest mainline kernel and create uImage using omap2plus_defconfig
> > - Write a program to open watchdog,like
> > void main(void)
> > {
> >        int fd = open("/dev/watchdog", O_WRONLY);
> >
> >        if (fd == -1) {
> >                perror("Watchdog device interface is not available!\n");
> >        }
> > }
> > - Build with arm compiler and copy it to your file syatem
> > - Boot the image and run the executable.
> >
> >
> >  drivers/watchdog/omap_wdt.c |   17 -----------------
> >  1 files changed, 0 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> > index 8285d65..27ab8db 100644
> > --- a/drivers/watchdog/omap_wdt.c
> > +++ b/drivers/watchdog/omap_wdt.c
> > @@ -126,8 +126,6 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev
> *wdev)
> >        u32 pre_margin = GET_WLDR_VAL(timer_margin);
> >        void __iomem *base = wdev->base;
> >
> > -       pm_runtime_get_sync(wdev->dev);
> > -
> >        /* just count up at 32 KHz */
> >        while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
> >                cpu_relax();
> > @@ -135,8 +133,6 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev
> *wdev)
> >        __raw_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
> >        while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
> >                cpu_relax();
> > -
> > -       pm_runtime_put_sync(wdev->dev);
> >  }
> >
> >  /*
> > @@ -166,8 +162,6 @@ static int omap_wdt_open(struct inode *inode, struct
> file *file)
> >        omap_wdt_ping(wdev); /* trigger loading of new timeout value */
> >        omap_wdt_enable(wdev);
> >
> > -       pm_runtime_put_sync(wdev->dev);
> > -
> >        return nonseekable_open(inode, file);
> >  }
> >
> > @@ -179,8 +173,6 @@ static int omap_wdt_release(struct inode *inode,
> struct file *file)
> >         *      Shut off the timer unless NOWAYOUT is defined.
> >         */
> >  #ifndef CONFIG_WATCHDOG_NOWAYOUT
> > -       pm_runtime_get_sync(wdev->dev);
> > -
> >        omap_wdt_disable(wdev);
> >
> >        pm_runtime_put_sync(wdev->dev);
> > @@ -199,11 +191,9 @@ static ssize_t omap_wdt_write(struct file *file,
> const char __user *data,
> >
> >        /* Refresh LOAD_TIME. */
> >        if (len) {
> > -               pm_runtime_get_sync(wdev->dev);
> >                spin_lock(&wdt_lock);
> >                omap_wdt_ping(wdev);
> >                spin_unlock(&wdt_lock);
> > -               pm_runtime_put_sync(wdev->dev);
> >        }
> >        return len;
> >  }
> > @@ -236,18 +226,15 @@ static long omap_wdt_ioctl(struct file *file,
> unsigned int cmd,
> >                                        (int __user *)arg);
> >                return put_user(0, (int __user *)arg);
> >        case WDIOC_KEEPALIVE:
> > -               pm_runtime_get_sync(wdev->dev);
> >                spin_lock(&wdt_lock);
> >                omap_wdt_ping(wdev);
> >                spin_unlock(&wdt_lock);
> > -               pm_runtime_put_sync(wdev->dev);
> >                return 0;
> >        case WDIOC_SETTIMEOUT:
> >                if (get_user(new_margin, (int __user *)arg))
> >                        return -EFAULT;
> >                omap_wdt_adjust_timeout(new_margin);
> >
> > -               pm_runtime_get_sync(wdev->dev);
> >                spin_lock(&wdt_lock);
> >                omap_wdt_disable(wdev);
> >                omap_wdt_set_timeout(wdev);
> > @@ -255,7 +242,6 @@ static long omap_wdt_ioctl(struct file *file,
> unsigned int cmd,
> >
> >                omap_wdt_ping(wdev);
> >                spin_unlock(&wdt_lock);
> > -               pm_runtime_put_sync(wdev->dev);
> >                /* Fall */
> >        case WDIOC_GETTIMEOUT:
> >                return put_user(timer_margin, (int __user *)arg);
> > @@ -363,7 +349,6 @@ static void omap_wdt_shutdown(struct platform_device
> *pdev)
> >        struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
> >
> >        if (wdev->omap_wdt_users) {
> > -               pm_runtime_get_sync(wdev->dev);
> >                omap_wdt_disable(wdev);
> >                pm_runtime_put_sync(wdev->dev);
> >        }
> > @@ -403,7 +388,6 @@ static int omap_wdt_suspend(struct platform_device
> *pdev, pm_message_t state)
> >        struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
> >
> >        if (wdev->omap_wdt_users) {
> > -               pm_runtime_get_sync(wdev->dev);
> >                omap_wdt_disable(wdev);
> >                pm_runtime_put_sync(wdev->dev);
> >        }
> > @@ -419,7 +403,6 @@ static int omap_wdt_resume(struct platform_device
> *pdev)
> >                pm_runtime_get_sync(wdev->dev);
> >                omap_wdt_enable(wdev);
> >                omap_wdt_ping(wdev);
> > -               pm_runtime_put_sync(wdev->dev);
> >        }
> >
> >        return 0;
> > --
> > 1.7.5.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120630/b186e4b9/attachment-0001.html>
