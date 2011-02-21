From: ccross@android.com (Colin Cross)
Date: Sun, 20 Feb 2011 23:02:06 -0800
Subject: [PATCH v2 12/21] ARM: tegra: clock: Add shared bus clock type
In-Reply-To: <AANLkTinWQRmKhorYHQ2rHCArHN89go-2mYVAe5UUZVOV@mail.gmail.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<AANLkTinWQRmKhorYHQ2rHCArHN89go-2mYVAe5UUZVOV@mail.gmail.com>
Message-ID: <AANLkTikcqYfC6crtwSUYvSH7dSOQZD8K+fCyOSCVMpnL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 8:15 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
>> Some clocks may have multiple downstream users that need to request a
>> higher clock rate. ?Shared bus clocks provide a unique shared_bus_user
>> clock to each user. ?The frequency of the bus is set to the highest
>> enabled shared_bus_user clock, with a minimum value set by the
>> shared bus. ?Drivers can use clk_enable and clk_disable to enable
>> or disable their requirement, and clk_set_rate to set the minimum rate.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
>
> [...]
>> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
>> index a1c86d8..dd53af3 100644
>> --- a/arch/arm/mach-tegra/tegra2_clocks.c
>> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
> [...]
>
>> + ? ? ? c->u.shared_bus_user.rate = c->parent->max_rate;
>> + ? ? ? c->state = OFF;
>> +#ifdef CONFIG_DEBUG_FS
>> + ? ? ? c->set = 1;
>> +#endif
>> +
>> + ? ? ? spin_lock_irqsave(&c->parent->spinlock, flags);
>
>
> A later patch in the series removes the ifdef. Might as well remove it
> here. Also, should be c->set = true, which that patch also does. :)
At this point in the series c->set is not defined for
CONFIG_DEBUG_FS=n, so dropping the #ifdef would break bisection, and I
left the = 1 in for consistency.

> With that fixed:
>
> Acked-by: Olof Johansson <olof@lixom.net>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
