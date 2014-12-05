From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Dec 2014 10:54:17 +0100
Subject: [GIT PULL] Broadcom STB GISB bus driver for 3.19 (v2)
In-Reply-To: <54815D85.7090409@gmail.com>
References: <1417220370-469-1-git-send-email-f.fainelli@gmail.com>
 <2910464.KM7dWcxCmJ@wuerfel> <54815D85.7090409@gmail.com>
Message-ID: <6133066.hrdnRxXNp1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 23:23:49 Florian Fainelli wrote:
> Le 04/12/2014 07:44, Arnd Bergmann a ?crit :
> > On Friday 28 November 2014 16:19:30 Florian Fainelli wrote:
> >> This pull request contains the following changes to the Broadcom GISB bus
> >> arbiter from Kevin Cernekee:
> >>
> >> - Extend brcmstb GISB bus driver to work on MIPS (currently ARM-only) and support
> >>   65nm and 40nm MIPS-based chips such as: BCM7038, BCM7400 and BCM7435
> > 
> > Pulled into next/drivers, thanks!
> 
> Thanks! You may have to resolve a conflict when you merge
> brcm/stb-smp-uart with next/drivers for this file, especially with the
> commit below:
> 
> 203bb85ed605e43eadca62afb3a8cd128a8ec10a ("bus: brcmstb_gisb: save and
> restore GISB timeout")
> 
> for brcmstb_gisb_arb_suspend() and
> brcmstb_gisb_arb_resume_noirq() which still use the ioread32/iowrite32
> accessors instead of those introduced later on by Kevin: gisb_read() and
> gisb_write. The merge resolution looks like this:
> 
> 
> #ifdef CONFIG_PM_SLEEP
> static int brcmstb_gisb_arb_suspend(struct device *dev)
> {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
> 
>         gdev->saved_timeout = gisb_read(gdev, ARB_TIMER);
> 
>         return 0;
> }
> 
> /* Make sure we provide the same timeout value that was configured
> before, and
>  * do this before the GISB timeout interrupt handler has any chance to run.
>  */
> static int brcmstb_gisb_arb_resume_noirq(struct device *dev)
> {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
> 
>         gisb_write(gdev, gdev->saved_timeout, ARB_TIMER);
> 
>         return 0;
> }

I ended up mismerging it actually, but Olof fixed it up. If you have the
time, please check that the contents of our for-next branch are correct
now.

Thanks,

	Arnd
