From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Mar 2014 15:55:52 -0500
Subject: [GIT PULL 1/2] omap device tree changes for v3.15, part 3
In-Reply-To: <20140317164509.GA30471@atomide.com>
References: <20140313200135.GA5981@atomide.com>
 <201403171514.07194.arnd@arndb.de> <20140317164509.GA30471@atomide.com>
Message-ID: <53276158.2020101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Tony,

On 03/17/2014 11:45 AM, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [140317 07:18]:
>> On Thursday 13 March 2014, Tony Lindgren wrote:
>>> Hi,
>>>
>>> Resending these two, looks like my updated scripts have some issues hitting
>>> the mailing lists..
>>>
>>> The following changes since commit 18c49af3ee9e32a535413a949672bea726699f04:
>>>
>>>    ARM: dts: am335x-evmsk: enable dual_emac mode (2014-03-05 11:53:36 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-part3
>>>
>>> for you to fetch changes up to e1902bbe44844597a38c8cbae30ca895f6e126ee:
>>>
>>>    ARM: dts: Add MMC2/SDIO/WLAN support for cm-t3530 (2014-03-12 10:40:37 -0700)
>>>
>>> ----------------------------------------------------------------
>>> Device tree related changes to the omap iommu driver as that
>>> is finally getting updated. Also few trivial board related
>>> .dts updates to add more devices.
>>
>> Pulled into next/dt, thanks!
>
> Thanks, looks like the merge ddf071148934047b1e87bf89e823e74f267f0b84
> introduces a build failure though:
>
> @@@ -22,8 -23,7 +23,7 @@@
>    #include "common-board-devices.h"
>    #include "dss-common.h"
>    #include "control.h"
> - #include "omap-secure.h"
>   -#include "omap_device.h"
>   +#include "soc.h"
>
>    struct pdata_init {
>          const char *compatible;
>
> Those need to be added back to keep things building.
>
>> I haven't really been following the iommu discussions, so I have to trust
>> you are doing the right thing here. What is the status on iommu
>> support through DT? Do we have or require a generic binding for iommus?
>
> There are certainly various things that could be improved in the
> drivers/iommu, just doing grep EXPORT_SYMBOL drivers/iommu shows quite
> a few things that should probably be implemented in a generic way.

Yes, Laurent is working towards removing omap-iovmm.c completely and 
started a discussion/cleanup series towards thats[1]. I expect some of 
the other export symbols for OMAP to also vanish slowly once iovmm is 
removed.

>
> Currently the bindings don't do much, but could probably be simplified
> further. Things like ti,#tlb-entries and ti,iommu-bus-err-back may not
> even be needed and could be set by the driver match .data based on the
> compatible flag alone.

Yeah, I was in fact looking for feedback on exactly these properties 
[2]. I haven't removed this as the only feedback I got was positive for 
the changes [3].

>
> This set contains the independent SoC related changes related to get
> things moving for the drivers/iommu changes as discussed here:
>
> http://www.spinics.net/lists/arm-kernel/msg312144.html
>
> Some things like reset are still being done using platform_data with
> a promise of future patches:
>
> http://www.spinics.net/lists/linux-omap/msg104328.html
>
>> Are you following that, or will you have to do incompatible changes to
>> do that?
>
> I'm not following too closely on the drivers/iommu parts, mostly
> following just the moving away from platform data part at this point.
> Suman can probably describe what needs to be done more accurately.

I am not expecting any changes to bindings as this series is mainly 
adding the OMAP iommu DT nodes and having the OMAP IOMMU driver 
functional with the DT-based IOMMU devices. We are yet to add any DTS 
client devices use IOMMU.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=139423949120188&w=2
[2] http://marc.info/?l=linux-omap&m=139231544416973&w=2
[3] http://marc.info/?l=linux-omap&m=139338074931831&w=2
