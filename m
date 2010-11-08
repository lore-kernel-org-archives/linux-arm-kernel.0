From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 8 Nov 2010 14:43:13 -0500
Subject: [PATCH 1/3] OMAP: use generic panel data in board files
In-Reply-To: <1289219163.3297.54.camel@tubuntu>
References: <1288986236-30210-1-git-send-email-bryan.wu@canonical.com>
	<1288986236-30210-2-git-send-email-bryan.wu@canonical.com>
	<1289219163.3297.54.camel@tubuntu>
Message-ID: <AANLkTin7XOPyupobBehHc+hdJbGVJWFPRPYf03BwuDcZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 8, 2010 at 7:26 AM, Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Fri, 2010-11-05 at 20:43 +0100, ext Bryan Wu wrote:
>> Introduce struct panel config data in panel.h, which will be used to match
>> the right panel configurations in generic DPI panel driver and other future
>> dsi panel drivers.
>>
>> Still keep sharp_ls_panel, since the sharp_ls_panel driver contains blacklight
>> control driver code which will be moved out later. Then we can use generic DPI
>> driver for sharp_ls_panel.
>
> As mentioned in the other mail, don't touch panel-taal or
> nokia-dsi-panel.h. They are not related to this change.
>

Got it. I just found nokia-dsi-panel.h is some kind of confusing and
tried to unify them. Obviously I should not touch them in this
patchset. I will remove them in next version.

> The panel.h file should be spesific for the generic panel driver, so
> name the .c and .h files similarly. (yes, panel-taal.c and
> nokia-dsi-panel.h are not good examples for this, but I have a patch
> fixing it, I just haven't had time to push it forward =).
>

OK, I got it. Actually I did that, but wanna unify the
nokia-dis-panel.h somehow. I will change back.

> And remember that the kernel should compile and work after each
> individual patch in the patch set. In this patch you set the boards to
> use dvi_panel driver, but there is no dvi_panel driver yet.
>

Got it. I will fold some patches together.

> Also some comments inline.
>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> ?arch/arm/mach-omap2/board-3430sdp.c ? ? ? ? ? ? ? | ? 10 +++-
>> ?arch/arm/mach-omap2/board-am3517evm.c ? ? ? ? ? ? | ? 19 +++++--
>> ?arch/arm/mach-omap2/board-cm-t35.c ? ? ? ? ? ? ? ?| ? 19 +++++--
>> ?arch/arm/mach-omap2/board-devkit8000.c ? ? ? ? ? ?| ? 22 +++++---
>> ?arch/arm/mach-omap2/board-igep0020.c ? ? ? ? ? ? ?| ? 10 +++-
>> ?arch/arm/mach-omap2/board-omap3beagle.c ? ? ? ? ? | ? 10 +++-
>> ?arch/arm/mach-omap2/board-omap3evm.c ? ? ? ? ? ? ?| ? 10 +++-
>> ?arch/arm/mach-omap2/board-omap3stalker.c ? ? ? ? ?| ? 19 +++++--
>> ?arch/arm/plat-omap/include/plat/nokia-dsi-panel.h | ? 31 -----------
>> ?arch/arm/plat-omap/include/plat/panel.h ? ? ? ? ? | ? 57 +++++++++++++++++++++
>> ?drivers/video/omap2/displays/panel-taal.c ? ? ? ? | ? 26 ++++------
>> ?11 files changed, 148 insertions(+), 85 deletions(-)
>> ?delete mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
>> ?create mode 100644 arch/arm/plat-omap/include/plat/panel.h
>>
>> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
>> index 4e3742c..859b4e5 100644
>> --- a/arch/arm/mach-omap2/board-3430sdp.c
>> +++ b/arch/arm/mach-omap2/board-3430sdp.c
>> @@ -38,6 +38,7 @@
>> ?#include <plat/dma.h>
>> ?#include <plat/gpmc.h>
>> ?#include <plat/display.h>
>> +#include <plat/panel.h>
>>
>> ?#include <plat/gpmc-smc91x.h>
>>
>> @@ -270,11 +271,14 @@ static struct omap_dss_device sdp3430_lcd_device = {
>> ? ? ? ? .platform_disable ? ? ? = sdp3430_panel_disable_lcd,
>> ?};
>>
>> +static struct panel_data dvi_panel = {
>> + ? ? ? .name ? ? ? ? ? = "generic",
>> +};
>> +
>> ?static struct omap_dss_device sdp3430_dvi_device = {
>> ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "dvi",
>> - ? ? ? .driver_name ? ? ? ? ? ?= "generic_panel",
>> - ? ? ? .type ? ? ? ? ? ? ? ? ? = OMAP_DISPLAY_TYPE_DPI,
>> - ? ? ? .phy.dpi.data_lines ? ? = 24,
>
> Why do you remove type and datalines configuration? You do this for the
> other panels also.
>

I found this is common in all the generic dpi panel, but the value
depends on the specific panel. I move this to the panel configuration
data and will set this value in panel-dpi driver. Do you think need I
keep them here? Actually I found all of them are 24 for generic one.
16 or 18 for others.

-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
