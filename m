From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Apr 2015 15:00:28 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <10227049.9i19zDi2y3@wuerfel>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
 <10227049.9i19zDi2y3@wuerfel>
Message-ID: <20150430130028.GF3488@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 12:42:48PM +0200, Arnd Bergmann wrote:
> I've looked at the driver in a little more detail now, and found that
> it is a weird conglomerate at the moment. Basically you have four
> drivers in one file here, appended to one another, but not sharing
> any common functions except the module_init() that registers the four
> drivers. This is what Rob was referring to when he suggested splitting
> it up into four files, and these would in total be smaller than the
> common file (by being able to use module_platform_driver()).
> 
> However, there is another dimension to this, which supports your point
> about making it one driver for the platform: The split into four drivers
> is completely artificial, because all four use the same IRQs and
> implement four separate interrupt handlers for it (using IRQF_SHARED),
> each handling only the events they are interested in. Similarly, they
> all access the same register set ("pcperror"), aside from having their
> own separate registers, and they use the "syscon" framework to get to
> the registers.  This seems to be an inferior design, as the pcperror

Doh, now that you mention it...

So why isn't this thing registering a single IRQ handler which
multiplexes between the _check routines depending on the bits set in
PCPHPERRINTSTS/MEMERRINTSTS? (L3 alternatively, ctx->dev_csr + L3C_ESR).

This would really make it a single driver which acts according to the
bits set in those error registers. It can't get any simpler than that.

Loc?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
