From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Nov 2010 01:30:34 +0800
Subject: [PATCH 02/17] ARM: pxa: Access SMEMC via virtual addresses
In-Reply-To: <201011031630.03658.marek.vasut@gmail.com>
References: <1288741914-21328-1-git-send-email-marek.vasut@gmail.com>
	<1288741914-21328-2-git-send-email-marek.vasut@gmail.com>
	<AANLkTimdrc1XjnTbq8nW+0yov00YyhpJnMG9j57f4uZk@mail.gmail.com>
	<201011031630.03658.marek.vasut@gmail.com>
Message-ID: <AANLkTi=YiToY8APLeeieQaeyRe1OeKERPLWOYBWZhp9E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 3, 2010 at 11:30 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Wednesday 03 November 2010 15:37:14 Eric Miao wrote:
>> On Wed, Nov 3, 2010 at 7:51 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> > This is important because on PXA3xx, the physical mapping of SMEMC
>> > registers differs from the one on PXA2xx. In order to get PCMCIA working
>> > on both PXA2xx and PXA320, the PCMCIA driver was adjusted accordingly as
>> > well.
>> >
>> > Also, various places in the kernel had to be patched to use
>> > __raw_read/__raw_write.
>> >
>> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> > Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> > ---
>> > ?arch/arm/mach-pxa/cm-x2xx.c ? ? ? ? ? ? ? ? ?| ? 13 +++--
>> > ?arch/arm/mach-pxa/cpufreq-pxa2xx.c ? ? ? ? ? | ? 10 ++--
>> > ?arch/arm/mach-pxa/csb726.c ? ? ? ? ? ? ? ? ? | ? ?7 ++-
>> > ?arch/arm/mach-pxa/generic.c ? ? ? ? ? ? ? ? ?| ? ?1 +
>> > ?arch/arm/mach-pxa/h5000.c ? ? ? ? ? ? ? ? ? ?| ? ?9 ++--
>> > ?arch/arm/mach-pxa/include/mach/pxa-smemc.h ? | ? 74
>> > ++++++++++++++++++++++++++ arch/arm/mach-pxa/include/mach/pxa2xx-regs.h
>> > | ? 55 ------------------- arch/arm/mach-pxa/lpd270.c
>> > | ? ?3 +-
>> > ?arch/arm/mach-pxa/lubbock.c ? ? ? ? ? ? ? ? ?| ? ?3 +-
>> > ?arch/arm/mach-pxa/mainstone.c ? ? ? ? ? ? ? ?| ? ?5 +-
>> > ?arch/arm/mach-pxa/pxa25x.c ? ? ? ? ? ? ? ? ? | ? ?5 +-
>> > ?arch/arm/mach-pxa/pxa27x.c ? ? ? ? ? ? ? ? ? | ? 10 ++--
>> > ?arch/arm/mach-pxa/pxa3xx.c ? ? ? ? ? ? ? ? ? | ? ?5 +-
>> > ?arch/arm/mach-pxa/sleep.S ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
>> > ?arch/arm/mach-pxa/smemc.c ? ? ? ? ? ? ? ? ? ?| ? 51 ++++++------------
>> > ?arch/arm/mach-pxa/spitz.c ? ? ? ? ? ? ? ? ? ?| ? ?5 +-
>> > ?arch/arm/mach-pxa/stargate2.c ? ? ? ? ? ? ? ?| ? ?3 +-
>> > ?arch/arm/mach-pxa/tosa.c ? ? ? ? ? ? ? ? ? ? | ? ?7 ++-
>> > ?arch/arm/mach-pxa/trizeps4.c ? ? ? ? ? ? ? ? | ? ?3 +-
>> > ?arch/arm/mach-pxa/xcep.c ? ? ? ? ? ? ? ? ? ? | ? ?5 +-
>> > ?arch/arm/mach-pxa/zeus.c ? ? ? ? ? ? ? ? ? ? | ? ?5 +-
>> > ?drivers/pcmcia/pxa2xx_base.c ? ? ? ? ? ? ? ? | ? 65
>> > +++++++++++++++------- 22 files changed, 196 insertions(+), 150
>> > deletions(-)
>> > ?create mode 100644 arch/arm/mach-pxa/include/mach/pxa-smemc.h
>> >
>
> SNIP
>
>> > diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
>> > index 0909df2..2f21144 100644
>> > --- a/arch/arm/mach-pxa/zeus.c
>> > +++ b/arch/arm/mach-pxa/zeus.c
>> > @@ -47,6 +47,7 @@
>> > ?#include <mach/audio.h>
>> > ?#include <mach/arcom-pcmcia.h>
>> > ?#include <mach/zeus.h>
>> > +#include <mach/pxa-smemc.h>
>> >
>> > ?#include "generic.h"
>> >
>> > @@ -828,8 +829,8 @@ static void __init zeus_init(void)
>> > ? ? ? ?pr_info("Zeus CPLD V%dI%d\n", (system_rev & 0xf0) >> 4,
>> > (system_rev & 0x0f));
>> >
>> > ? ? ? ?/* Fix timings for dm9000s (CS1/CS2)*/
>> > - ? ? ? MSC0 = (MSC0 & 0xffff) | (dm9000_msc << 16);
>> > - ? ? ? MSC1 = (MSC1 & 0xffff0000) | dm9000_msc;
>> > + ? ? ? __raw_writel((MSC0 & 0xffff) | (dm9000_msc << 16), MSC0);
>> > + ? ? ? __raw_writel((MSC1 & 0xffff0000) | dm9000_msc, MSC1);
>>
>> This isn't correct.
>
> I don't see the difference (well, besides that this should be adjusted by
> bootloader).
>

Shouldn't this being written as:

msc0 = __raw_readl(MSC0) & 0xffff | (dm9000_msc << 16);
__raw_writel(msc0, MSC00);
msc1 = __raw_readl(MSC1) & 0xffff0000 | dm9000_msc;
__raw_writel(msc1, MSC1);

??
