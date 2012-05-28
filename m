From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 28 May 2012 15:32:50 +0530
Subject: [RFC PATCH 06/11] OMAP2+: use control module mfd driver in
 omap_type
In-Reply-To: <4FBF80D5.2000600@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-7-git-send-email-eduardo.valentin@ti.com>
 <4FBF80D5.2000600@ti.com>
Message-ID: <CAMQu2gyjJdJZKAf+TJwQfQ2BgAXe_s-soTcs7Am6O4+yy=7cLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 6:23 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Eduardo,
>
>
> On 5/25/2012 10:25 AM, Eduardo Valentin wrote:
>>
>> OMAP system control module can be probed early, then
>> omap_type is safe to use its APIs.
>>
>> TODO: add support for other omap versions
>>
>> Signed-off-by: Eduardo Valentin<eduardo.valentin@ti.com>
>> ---
>> ?arch/arm/mach-omap2/id.c | ? 16 +++++++++++++++-
>> ?1 files changed, 15 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> index 5bb9746..acfd698 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -18,6 +18,7 @@
>> ?#include<linux/kernel.h>
>> ?#include<linux/init.h>
>> ?#include<linux/io.h>
>> +#include<linux/mfd/omap_control.h>
>>
>> ?#include<asm/cputype.h>
>>
>> @@ -40,8 +41,14 @@ EXPORT_SYMBOL(omap_rev);
>>
>> ?int omap_type(void)
>> ?{
>> + ? ? ? struct device *scm;
>> + ? ? ? int ret = 0;
>> ? ? ? ?u32 val = 0;
>>
>> + ? ? ? scm = omap_control_get();
>> + ? ? ? if (IS_ERR_OR_NULL(scm))
>> + ? ? ? ? ? ? ? return 0;
>> +
>> ? ? ? ?if (cpu_is_omap24xx()) {
>
>
> OK, not really related to that patch, but the previous cpu_is_omap24xx makes
> me think of that :-)
>
> What about the omap<X>_check_revision used by cpu_is_XXX?
>
> This call is the very first one to require the control module access in
> order to get the ID_CODE inside the control module.
>
> So far it still use that ugly hard coded phys -> virtual address macro that
> is sued for that.
>
Agree with Benoits comment. One way to deal with this is,
store the register offset with init and then just use it here.

That way you can get rid of all cpu_is_XXXX() from this function.

Regards
Santosh
