From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Dec 2014 09:35:09 +0100
Subject: [PATCH] clocksource: arch_timer: Fix arm64 platforms not booting
In-Reply-To: <71346397bb3c0e654aa5b634328ae29c@www.loen.fr>
References: <1419776431-26217-1-git-send-email-christoffer.dall@linaro.org>
 <71346397bb3c0e654aa5b634328ae29c@www.loen.fr>
Message-ID: <20141229083509.GC29460@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 28, 2014 at 09:46:20PM +0000, Marc Zyngier wrote:
> On 2014-12-28 14:20, Christoffer Dall wrote:
> >Commit 0b46b8a718c6e ("clocksource: arch_timer: Fix code to...")
> >fixes
> >timer issues with certain ARMv7 platforms, but unfortunately breaks
> >arm64 platforms with hyp mode (EL2) enabled.
> >
> >The commit only sets arch_timer_use_virtual to false under
> >CONFIG_ARM,
> >but forgets that the config variable is also set in other code paths
> >(actually, right underneath the check in the patch) with detrimental
> >consequences as we've now introduced a direct early call to BUG() on
> >practically all arm64 platforms.
> >
> >One could argue that this code could be refactored to use different
> >variables for checking which *timer* to use and which *counter* to
> >use,
> >which seems to be the desired difference between ARM and arm64 in
> >this
> >case, but this approach fixes an urgent issue for now.
> >
> >Cc: Sonny Rao <sonnyrao@chromium.org>
> >Cc: Catalin Marinas <catalin.marinas@arm.com>
> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >Cc: Olof Johansson <olof@lixom.net>
> >Cc: Mark Rutland <mark.rutland@arm.com>
> >Cc: Catalin Marinas <catalin.marinas@arm.com>
> >Cc: Marc Zyngier <marc.zyngier@arm.com>
> >Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> >Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >---
> >This was apparently already discovered by Yingjoe Chen in this thread
> >https://lkml.org/lkml/2014/11/24/41 and Catalin recommended a similar
> >fix.
> 
> I'm increasingly worried about the time it takes to get such critical
> fixes into the tree (arm64 is *dead* without it).
> 
> What is holding this patch which, as far as I remember, has been posted
> by Catalin almost three weeks ago?
> 
I didn't find that since I didn't think I'd have to go back that long on
lakml for something that breaks boot of an entire architecture.  Sorry
for the confusion of a second patch, but fwiw, I now spent another few
hours bisecting this, so I would really like to see this fix go into
mainline ASAP as well to save others the trouble.

Thanks,
-Christoffer
