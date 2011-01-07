From: nm@ti.com (Nishanth Menon)
Date: Fri, 07 Jan 2011 07:30:15 -0600
Subject: [PATCH 2/2] OMAP3: beagle xm: enable upto 800MHz OPP
In-Reply-To: <alpine.DEB.1.10.1101071457540.18906@esdhcp041196.research.nokia.com>
References: <1294260576-20237-1-git-send-email-nm@ti.com>
	<1294260576-20237-3-git-send-email-nm@ti.com>
	<alpine.DEB.1.10.1101071457540.18906@esdhcp041196.research.nokia.com>
Message-ID: <4D271567.2010105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen wrote, on 01/07/2011 07:04 AM:

> On Wed, 5 Jan 2011, Nishanth Menon wrote:
>> +static void __init beagle_opp_init(void)
>> +{
>> + int r = 0;
>> +
>> + /* Initialize the omap3 opp table */
>> + if (omap3_opp_init()) {
>> + pr_err("%s: opp default init failed\n", __func__);
>> + return;
>> + }
>> +
>> + /* Custom OPP enabled for XM */
>> + if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> + struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
>> + struct omap_hwmod *dh = omap_hwmod_lookup("iva");
>> + struct device *dev;
>> +
>> + if (!mh || !dh) {
>> + pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
>> + __func__, mh, dh);
>> + r = -EINVAL;
>> + } else {
>> + /* Enable MPU 1GHz and lower opps */
>> + dev = &mh->od->pdev.dev;
>> + r = opp_enable(dev, 800000000);
>> + /* TODO: MPU 1GHz needs SR and ABB */
>> +
>> + /* Enable IVA 800MHz and lower opps */
>> + dev = &dh->od->pdev.dev;
>> + r |= opp_enable(dev, 660000000);
>> + /* TODO: DSP 800MHz needs SR and ABB */
>> + }
>> + if (r) {
>> + pr_err("%s: failed to enable higher opp %d\n",
>> + __func__, r);
>> + /*
>> + * Cleanup - disable the higher freqs - we dont care
>> + * about the results
>> + */
>> + dev = &mh->od->pdev.dev;
>> + opp_disable(dev, 800000000);
>> + dev = &dh->od->pdev.dev;
>
> This branch will be reached also when !mh || !dh, so it won't work.

arrgh.. thanks for catching it - will fix and repost.

-- 
Regards,
Nishanth Menon
