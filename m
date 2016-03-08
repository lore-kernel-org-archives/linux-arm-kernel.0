From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 08 Mar 2016 17:19:39 +0100
Subject: [PATCH] ARM: mvebu: Fix of_clk_get() call in a non sleeping
 context
In-Reply-To: <20160308164117.2a3ed3a7@free-electrons.com> (Thomas Petazzoni's
 message of "Tue, 8 Mar 2016 16:41:17 +0100")
References: <1457446733-7137-1-git-send-email-gregory.clement@free-electrons.com>
 <20160308164117.2a3ed3a7@free-electrons.com>
Message-ID: <87a8m93pt0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., mars 08 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Greg,
>
> On Tue,  8 Mar 2016 15:18:53 +0100, Gregory CLEMENT wrote:
>> of_clk_get() is called armada_xp_smp_prepare_cpus() function.
>
> Hum? Your code is changing things to have of_clk_get() called by
> armada_xp_smp_prepare_cpus(). I think you wanted to say:
>
> "of_clk_get() is currently called in get_cpu_clk(), which it turns is
> called by set_secondary_cpu_clock() during armada_xp_boot_secondary().
> However, this callback is called in a context...

right!

>
>> This
>> callback can be called in a context where it should not sleep as pointed
>> when enabling CONFIG_DEBUG_ATOMIC_SLEEP. However of_clk_get() can sleep.
>> 
>> This patch solved this issue by moving the of_clk_get() during
>> initialization by gathering the list of reference on the clock, and only
>> access to this list later.
>
> I think this doesn't solve the problem completely, because
> set_secondary_cpu_clock() is still calling clk_prepare_enable(), and
> the prepare step of a clock is theoretically allowed to sleep. In
> practice, it doesn't sleep in our specific case, but still
> clk_prepare_enable() is not good in an atomic context.

OK, so let's only use clk_enable() which can't sleep. On mvebu SoCs
there is no prepare/unprepare operation for the clock, so trying to use
clk_prepare_enable() is useless. Especially for this code which is not
for a random IP but especially for the Armada XP SoC.

If in the future the same logic can be used for a new mvebu SoC which
need the prepare/unprepare feature, then we will see how to deal with
it, but I really doubt that it will happen.


>
> So I believe the whole approach of setting the CPU clock frequency in
> armada_xp_boot_secondary() is wrong, and we should basically revert my
> commit b9b1de0f4da37dac76d812a27d6065eba02dc05b, and instead find a
> different solution for the resume from suspend case.
>
>> 
>> Fixes: f6cec7cd0777 ("ARM: mvebu: remove device tree parsing for cpu
>> nodes")
>
> I don't think it fixes this commit. The one it really fixes is most
> probably b9b1de0f4da37dac76d812a27d6065eba02dc05b.

Yes to be honest I pick the closer commit on which this fix could apply
without any conflict.

Thanks for your feedback, I will send a v2 taking into account your
remarks.

Ggregory


>
> Best regards,
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
