From: eranian@googlemail.com (stephane eranian)
Date: Fri, 27 Jan 2012 14:32:43 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120127132826.GD2347@mudshark.cambridge.arm.com>
References: <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
 <CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
 <CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
 <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
 <CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
 <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
 <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
 <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
Message-ID: <CAMsRxf++i+CQZvPvGaHD_zOT-B-P0R-UyLTVRiA-XdFYUiY_JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/27 Will Deacon <will.deacon@arm.com>:
> Mans,
>
> On Fri, Jan 27, 2012 at 12:56:35PM +0000, M?ns Rullg?rd wrote:
>> Will Deacon <will.deacon@arm.com> writes:
>> > Did this lead anywhere in the end? It seems as though Ming Lei has a working
>> > setup but Stephane is unable to replicate it, despite applying the necessary
>> > patches and trying an updated bootloader.
>>
>> With the patches listed above plus the one in [1], I get PMU interrupts.
>> However, unless I restrict the profiled process to one CPU
>> (taskset 1 perf record ...), I get a panic in armpmu_event_update() with
>> the 'event' argument being null when called from armv7pmu_handle_irq().
>>
>> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/69696
>
Ok, I am recompiling the kernel for this one line fix:

--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
       .prcm_partition   = OMAP4430_PRM_PARTITION,
       .cm_inst          = OMAP4430_PRM_EMU_CM_INST,
       .clkdm_offs       = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-       .flags            = CLKDM_CAN_HWSUP,
+       .flags            = CLKDM_CAN_SWSUP,
 };
