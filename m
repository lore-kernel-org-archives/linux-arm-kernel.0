From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 12 Jan 2012 15:41:29 +0100
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <20120111194334.GF1068@n2100.arm.linux.org.uk>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
 <20120111165508.GC1068@n2100.arm.linux.org.uk>
 <201201111827.18890.arnd.bergmann@linaro.org>
 <20120111194334.GF1068@n2100.arm.linux.org.uk>
Message-ID: <4F0EF119.3000605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2012 08:43 PM, Russell King - ARM Linux :

[..]

> On the other hand, we have another DWB in cpu_arm926_do_idle itself.
> 
> Whether any of this matters depends on _why_ that DWB is in the AT91
> code itself - is it something that needs to be done before placing the
> SDRAM into self-refresh mode, or is it being done merely because the
> ARM926 docs say that a DWB is needed before WFI?

We have two cases here:

For the venerable at91rm9200: DWB is needed before putting SDRAM into
self-refresh because any subsequent access to SDRAM will force it to
resume from self-refresh state. Of course for this case, it is important
to make sure that no access to SDRAM is made before the
wait-for-interrupt instruction.

For all other SAM9 SoCs: no additional DWB is needed because RAM
controller manages self-refresh state even if accesses are still done to
the memory.

> If the latter, it can be dispensed with because the CPU specific code
> is already doing that.

Yes, exactly, but only for SAM9, not for RM9200.

> In any case, I think we need someone to speak up who knows this bit of
> the AT91 code, and it needs fixing so that it's less reliant on luck -
> otherwise cleanups could introduce some rather horrible bugs.

Ok, Daniel, tell me how I can help you. Is there any information that is
missing on your side?

BTW, you may save time by skipping all CAP9 related changes (and remove
the code): We shall remove its support in kernel for 3.4 release:
https://lkml.org/lkml/2012/1/6/161

Best regards,
-- 
Nicolas Ferre
