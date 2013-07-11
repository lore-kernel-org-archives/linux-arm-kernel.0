From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 11 Jul 2013 14:47:00 +0530
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <20130710160704.GH18966@arwen.pp.htv.fi>
References: <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi> <87mwpuakod.fsf@linaro.org>
 <20130710142633.GV5523@atomide.com> <20130710160704.GH18966@arwen.pp.htv.fi>
Message-ID: <51DE780C.2070701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 July 2013 09:37 PM, Felipe Balbi wrote:
> how about something like below ? It makes omap_device/hwmod and
> pm_runtime agree on the initial state of the device and will prevent
> ->runtime_resume() from being called on first pm_runtime_get*() done
> during probe.
> 
> This is similar to what PCI bus does (if you look at pci_pm_init()).

I tried something similar [1] but what I found is that the serial
runtime resume was called despite it being marked as active using
pm_runtime_set_active().

That seems to be because of the pm_runtime_set_autosuspend_delay()
because we have the autosuspend_delay = -1

-----
static void update_autosuspend(struct device *dev, int old_delay, int old_use)
{
        int delay = dev->power.autosuspend_delay;

        /* Should runtime suspend be prevented now? */
        if (dev->power.use_autosuspend && delay < 0) {

                /* If it used to be allowed then prevent it. */
                if (!old_use || old_delay >= 0) {
                        atomic_inc(&dev->power.usage_count);
                        rpm_resume(dev, 0); <------------------------------- calls serial runtime resume.
                }
        }
-----

So we end up with the same issue with serial resume being called before set_termios()

[1]

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 5cc9287..c71d47d 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -129,6 +129,7 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
        struct device_node *node = pdev->dev.of_node;
        const char *oh_name;
        int oh_cnt, i, ret = 0;
+       bool device_active = false;
 
        oh_cnt = of_property_count_strings(node, "ti,hwmods");
        if (oh_cnt <= 0) {
@@ -152,6 +153,9 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
                        goto odbfd_exit1;
                }
                hwmods[i] = oh;
+               if (oh->flags & HWMOD_INIT_NO_IDLE)
+                       device_active = true;
+                       
        }
 
        od = omap_device_alloc(pdev, hwmods, oh_cnt);
@@ -172,6 +176,11 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 
        pdev->dev.pm_domain = &omap_device_pm_domain;
 
+       if (device_active) {
+               omap_device_enable(pdev);
+               pm_runtime_set_active(&pdev->dev);
+       }
+       
 odbfd_exit1:
        kfree(hwmods);
 odbfd_exit:
