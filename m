From: khilman@ti.com (Kevin Hilman)
Date: Fri, 30 Sep 2011 16:27:03 -0700
Subject: [PATCH v5 2/3] omap_twl: Prevent SR to enable for am3517/am3505
	devices
In-Reply-To: <87r52xhhkb.fsf@ti.com> (Kevin Hilman's message of "Fri, 30 Sep
	2011 14:00:04 -0700")
References: <1317363153-10259-1-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-3-git-send-email-abhilash.kv@ti.com>
	<87r52xhhkb.fsf@ti.com>
Message-ID: <874nztfw6w.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash,

Kevin Hilman <khilman@ti.com> writes:

> Abhilash K V <abhilash.kv@ti.com> writes:
>
>> From: Abhilash K V <abhilash.kv@ti.com>
>>
>> In case of AM3517 & AM3505, SmartReflex is not applicable so
>> we must not enable it. So omap3_twl_init() is now not called
>> when the processor does not support SR.
>
> This still isn't right.
>
> The reason to skip the TWL PMIC init is not because SR is not available
> (TWL PMICs are quite usable without SR).  The reason to skip TWL PMIC
> init is because the PMIC is not present.
>
> Instead, we need to fix up the TWL/PMIC init so that TWL-specifics are
> only registered if a TWL driver is registered.
>

Below is a test patch that is a first pass at implementing what I
suggested above.  I tested this (along with your patch 3/3) on a
3430/n900 after removing the omap_pmic_init() call frome the board file.

Can you let me know if this solves the problem you're seeing on
platforms that don't have TWL PMICs?

After digging into this more, I'm increasingly aware that the way we're
managing the init of PMIC stuff is a mess.  Guess I need another round
of voltage layer cleanups to fix that up.  


Kevin
