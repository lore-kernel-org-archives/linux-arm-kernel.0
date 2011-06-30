From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 30 Jun 2011 19:35:06 +0800
Subject: [PATCH] ARM: automatically select OMAP3_PMU if we try to use perf
	on OMAP3
In-Reply-To: <20110628135706.GA28871@e102144-lin.cambridge.arm.com>
References: <1309268265-2685-1-git-send-email-bryan.wu@canonical.com>
	<20110628135706.GA28871@e102144-lin.cambridge.arm.com>
Message-ID: <CAK5ve-LQcY6XQENBJw6JaarLffULA7EtjJMxCtpzhwPCfs2OuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 9:57 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Bryan,
>
> On Tue, Jun 28, 2011 at 02:37:45PM +0100, Bryan Wu wrote:
>> For our Ubuntu kernel on OMAP4 machine, we need to enable OMAP3 as well as
>> OMAP4. OMAP3_EMU has to be enabled manully to make CPU_HAS_PMU=y, which is
>> required by perf.
>>
>> So this patch will select the OMAP3_EMU if ARCH_OMAP3 is enabled.
>>
>> Cc: Ming Lei <ming.lei@canonical.com>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> ?arch/arm/Kconfig | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 2fd0911..53d0eba 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1084,10 +1084,10 @@ config XSCALE_PMU
>> ? ? ? default y
>>
>> ?config CPU_HAS_PMU
>> - ? ? depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU) && \
>> - ? ? ? ? ? ? ? ?(!ARCH_OMAP3 || OMAP3_EMU)
>> + ? ? depends on CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU
>> ? ? ? default y
>> ? ? ? bool
>> + ? ? select OMAP3_EMU if ARCH_OMAP3
>>
>> ?config MULTI_IRQ_HANDLER
>> ? ? ? bool
>
> This issue has been discussed on the list in the past and I still think that
> it would be better for your config to select OMAP3_EMU explicitly. If we do
> that here unconditionally then we end up also bringing in OC_ETM which isn't
> something that sounds like a good idea (may have implications for power
> consumption in production hardware?).
>

Will,

I quite understand your concern. How about this one?
----
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2fd0911..e53f9e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1084,10 +1084,10 @@ config XSCALE_PMU
        default y

 config CPU_HAS_PMU
-       depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU) && \
-                  (!ARCH_OMAP3 || OMAP3_EMU)
+       depends on CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU
        default y
        bool
+       select OMAP3_EMU if (PERF_EVENTS && ARCH_OMAP3)

 config MULTI_IRQ_HANDLER
        bool

----

I think it is quite logically clear.
1. if the CPU is V6, V6K, V7, then CPU_HAS_PMU supported
2. if the CPU is OMAP3, we need select OMAP3_EMU built-in
3. if we don't use PERF at all, we don't need built-in OMAP3_EMU

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
