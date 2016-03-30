From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 30 Mar 2016 17:09:20 +0200
Subject: [PATCH] sbs-battery: fix power status when battery is dry
In-Reply-To: <1459328310.29450.24.camel@mtksdaap41>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
 <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
 <1458801832.16645.7.camel@mtksdaap41>
 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
 <1459132330.16645.14.camel@mtksdaap41>
 <CAGS+omBVStB3mfXtDHdbsOK+y2UesGYtZBtYm=ctcpBfm88VEg@mail.gmail.com>
 <56F95451.5040607@nvidia.com>
 <1459216353.16645.20.camel@mtksdaap41>
 <56FA99D0.1010004@nvidia.com>
 <1459328310.29450.24.camel@mtksdaap41>
Message-ID: <20160330150919.GA21068@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 30, 2016 at 04:58:30PM +0800, YH Huang wrote:
> If I revise the description in this way(using your clear explanation):
> ------------------------------------------------------------------------
> The battery capacity changing course is like this:
> 
> full: BATTERY_FULLY_CHARGED => POWER_SUPPLY_STATUS_FULL
> <unplug AC>
> high->low: BATTERY_DISCHARGING => POWER_SUPPLY_STATUS_DISCHARGING
> ~0%: DISCHARGING & FULLY_DISCHARGED => POWER_SUPPLY_STATUS_NOT_CHARGING
> <plug in AC>
> 0%~20%: FULLY_DISCHARGED => POWER_SUPPLY_STATUS_CHARGING
> 20%~: No flag => POWER_SUPPLY_STATUS_CHARGING
> 
> For now, it is not exactly right to show the status as
> POWER_SUPPLY_STATUS_NOT_CHARGING when the battery is dry
> (FULLY_DISCHARGED) and AC is plugged in.
> Although the battery is in a low level, system works fine with the AC
> charging.
> It is better to say that the battery is charging.
> ------------------------------------------------------------------------
> 
> How about this?
> By the way, should I also revise the title?

POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
battery not charging (e.g. because battery temperature is out
of acceptable range). If you are discharging use
POWER_SUPPLY_STATUS_DISCHARGING.

You should just ignore the FULLY_DISCHARGED bit in the status
property. If you don't want to loose the information about fully
discharged battery add POWER_SUPPLY_PROP_CAPACITY_LEVEL, which maps:

BATTERY_FULLY_CHARGED => POWER_SUPPLY_CAPACITY_LEVEL_FULL
FULLY_DISCHARGED => POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL
otherwise => POWER_SUPPLY_CAPACITY_LEVEL_NORMAL

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160330/b28a67d3/attachment.sig>
