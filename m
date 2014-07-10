From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Thu, 10 Jul 2014 17:02:59 +0300
Subject: [PATCH v2 4/4] USB: PHY: tegra: Call tegra_usb_phy_close only
 on device removal
In-Reply-To: <20140710134859.GM15340@saruman.home>
References: <1404436179-10745-1-git-send-email-ttynkkynen@nvidia.com>
 <1404436179-10745-5-git-send-email-ttynkkynen@nvidia.com>
 <20140710134859.GM15340@saruman.home>
Message-ID: <53BE9D13.6000102@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/07/14 16:48, Felipe Balbi wrote:
> * PGP Signed by an unknown key
>
> Hi,
>
> On Fri, Jul 04, 2014 at 04:09:39AM +0300, Tuomas Tynkkynen wrote:
>> tegra_usb_phy_close() is supposed to undo the effects of
>> tegra_usb_phy_init(). It is also currently added as the USB PHY shutdown
>> callback, which is wrong, since tegra_usb_phy_init() is only called
>
> you could just make tegra_usb_phy_init() be called as u_phy->init().

Apart from enabling pll_u and vbus, that function mostly fetches clocks 
etc. from the device tree and as such should preferably fail the probe() 
and not when the EHCI driver enables the PHY. (Renaming it would 
probably be a good idea.)

> That way you even delay enabling clocks and regulators to the point
> where they are more likely to be needed. Also, if EHCI is never loaded,
> you won't power up the PHY for no reason.
>

That's true, but due to the above that'd be a bigger refactoring.

>> during probing wheras the shutdown callback can get called multiple
>> times. This then leads to warnings about unbalanced regulator_disable if
>> the EHCI driver is unbound and bound again at runtime.
>>
>> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>
> I suppose this has no dependencies with the rest of the series ?
>

No. But Greg apparently applied these to his tree earlier today.

Thanks,
Tuomas.

-- 
nvpublic
