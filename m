From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jan 2014 13:22:32 +0000
Subject: Randconfig build failure: screwed dependencies for phy-msm-usb.c
Message-ID: <20140117132232.GC15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/usb/phy/phy-msm-usb.c: In function 'msm_otg_runtime_suspend':
drivers/usb/phy/phy-msm-usb.c:1691:2: error: implicit declaration of function 'msm_otg_suspend'
drivers/usb/phy/phy-msm-usb.c: In function 'msm_otg_runtime_resume':
drivers/usb/phy/phy-msm-usb.c:1699:2: error: implicit declaration of function 'msm_otg_resume'

#ifdef CONFIG_PM_SLEEP
static int msm_otg_suspend(struct msm_otg *motg)
{
...
}

static int msm_otg_resume(struct msm_otg *motg)
{
...
}
#endif
...
#ifdef CONFIG_PM_RUNTIME
...
static int msm_otg_runtime_suspend(struct device *dev)
{
        struct msm_otg *motg = dev_get_drvdata(dev);

        dev_dbg(dev, "OTG runtime suspend\n");
        return msm_otg_suspend(motg);
}

static int msm_otg_runtime_resume(struct device *dev)
{
        struct msm_otg *motg = dev_get_drvdata(dev);

        dev_dbg(dev, "OTG runtime resume\n");
        return msm_otg_resume(motg);
}
#endif

So, if runtime PM is enabled, but PM sleep isn't, this fails as above.
If the msm_otg_* functions are required for runtime PM, they shouldn't
be conditional on CONfIG_PM_SLEEP.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
