From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Thu, 16 Dec 2010 08:11:51 -0600
Subject: [PATCH v4 5/5] OMAP: mailbox: use runtime pm for clk and sysc
	handling
In-Reply-To: <AANLkTi=RE3ZEuoe=jMRLiFZ7iVgvuXMrgqfXMAYa92=z@mail.gmail.com>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-6-git-send-email-omar.ramirez@ti.com>
	<AANLkTi=RE3ZEuoe=jMRLiFZ7iVgvuXMrgqfXMAYa92=z@mail.gmail.com>
Message-ID: <AANLkTinPpj5Po4yPjc8hG1Kjs2wM3b62-hRGMY+U_UjN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 16, 2010 at 2:28 AM, Varadarajan, Charulatha <charu@ti.com> wrote:
> On Thu, Dec 16, 2010 at 12:17, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> Use runtime pm APIs to enable/disable mailbox clocks and
>> to configure SYSC register.
>>
>> Based on the patch sent by Felipe Contreras:
>> https://patchwork.kernel.org/patch/101662/
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>> ?arch/arm/mach-omap2/mailbox.c | ? 27 +++++----------------------
>> ?1 files changed, 5 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
>> index 40ddeca..f5f72ba 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -14,6 +14,7 @@
>> ?#include <linux/err.h>
>> ?#include <linux/platform_device.h>
>> ?#include <linux/io.h>
>> +#include <linux/pm_runtime.h>
>> ?#include <plat/mailbox.h>
>> ?#include <mach/irqs.h>
>>
>> @@ -34,12 +35,8 @@
>> ?#define MAILBOX_IRQ_NOTFULL(m) ? ? ? ? (1 << (2 * (m) + 1))
>>
>> ?/* SYSCONFIG: register bit definition */
>> -#define AUTOIDLE ? ? ? (1 << 0)
>> ?#define SOFTRESET ? ? ?(1 << 1)
>> -#define SMARTIDLE ? ? ?(2 << 3)
>> ?#define OMAP4_SOFTRESET ? ? ? ?(1 << 0)
>> -#define OMAP4_NOIDLE ? (1 << 2)
>> -#define OMAP4_SMARTIDLE ? ? ? ?(2 << 2)
>>
>> ?/* SYSSTATUS: register bit definition */
>> ?#define RESETDONE ? ? ?(1 << 0)
>
> Is this still required?

Yes, mailbox uses the softreset every time it is requested (and that
it has no current users at the time), it does it before configuring
sysc, as opossed to what this patch does (where clk is enabled, sysc
configured, and then softreset), but no harm was seen with this
sequence.

AFAIK, enabling/disabling hwmod handles prm reset but not softreset
bit, that's why I left it there.

Regards,

Omar
