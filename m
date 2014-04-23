From: robherring2@gmail.com (Rob Herring)
Date: Wed, 23 Apr 2014 08:16:33 -0500
Subject: [PATCH v6 1/3] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <CAJ5Y-eZ=ugeav++ysMCbAUFnPMr5=WaCdrEdYojwLi1HTYX6rw@mail.gmail.com>
References: <1397762146-8337-1-git-send-email-ashwin.chaugule@linaro.org>
 <1397762146-8337-2-git-send-email-ashwin.chaugule@linaro.org>
 <CALrVBkuSsi=2J1YT7w2bGtcL7CL6_xheZceaRtqETyC9mUqhTw@mail.gmail.com>
 <CAJ5Y-eZ=ugeav++ysMCbAUFnPMr5=WaCdrEdYojwLi1HTYX6rw@mail.gmail.com>
Message-ID: <CAL_JsqKkmfWaDkc_DHh5ZWc=E13qii4U4g_bfiDzJ+N3e0Az8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 12:32 PM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> On 21 April 2014 02:23, Anup Patel <anup.patel@linaro.org> wrote:
>> Hi Ashwin,
>>
>> Please include system reboot & shutdown implementation
>> in this patch using PSCI v0.2 SYSTEM_OFF and
>> SYSTEM_RESET functions.
>
> hm, I had thought these relied on having the (optional) MIGRATE
> function. But thats not the case.
>
> So, how about this..
>
> ---------------------8<---------------------
>
> diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
> index ead8cdb..5a54f2f 100644
> --- a/arch/arm/kernel/psci.c
> +++ b/arch/arm/kernel/psci.c
> @@ -17,6 +17,8 @@
>
>  #include <linux/init.h>
>  #include <linux/of.h>
> +#include <linux/reboot.h>
> +#include <linux/pm.h>
>  #include <uapi/linux/psci.h>
>
>  #include <asm/compiler.h>
> @@ -24,6 +26,7 @@
>  #include <asm/opcodes-sec.h>
>  #include <asm/opcodes-virt.h>
>  #include <asm/psci.h>
> +#include <asm/system_misc.h>
>
>  struct psci_operations psci_ops;
>
> @@ -196,6 +199,16 @@ static int get_set_conduit_method(struct device_node *np)
>   return 0;
>  }
>
> +static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> +{
> + invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
> +}
> +
> +static void psci_sys_off(void)

This is a bit terse. I would spell out system or use sys_poweroff
here. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

Rob
