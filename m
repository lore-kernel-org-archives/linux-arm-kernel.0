From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Jul 2014 14:37:56 +0530
Subject: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
In-Reply-To: <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
 <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
 <53BE926A.2070005@ti.com>
 <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
Message-ID: <CAOh2x=muti0t8akw=Kbw22seOCP4=CsUrCUaNzmae74+JH3Q+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 7:00 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>>> +#ifdef CONFIG_PM_SLEEP
>>> +static int spear1340_miphy_suspend(struct device *dev)
>>> +{
>>> +     struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
>>> +     int ret = 0;
>>> +
>>> +     if (priv->mode == SATA)
>>> +             ret = spear1340_miphy_sata_exit(priv);
>>
>> Shouldn't this be spear1340_miphy_init()?
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int spear1340_miphy_resume(struct device *dev)
>>> +{
>>> +     struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
>>> +     int ret = 0;
>>> +
>>> +     if (priv->mode == SATA)
>>> +             ret = spear1340_miphy_sata_init(priv);
>>
>> And here spear1340_miphy_exit()? Why only for sata phys?

Kishon,

I had a chat with Pratyush and this is what we came to:

init and exit are rightly placed I believe. We need to initialize from
resume and exit from suspend. That's fine right? Also this was already
part of: arch/arm/mach-spear/spear1340.c which is removed with
this set.

Regarding sata and pcie, pcie suspend isn't yet implemented and
tested. So only sata :)

For delays, need to wait for mohit. Was on leave today.
