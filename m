From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Mar 2017 15:10:54 -0700
Subject: [PATCH] ARM: ux500: resume the second core properly
In-Reply-To: <20170227091338.9800-1-linus.walleij@linaro.org>
References: <20170227091338.9800-1-linus.walleij@linaro.org>
Message-ID: <20170313221054.GC13064@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 10:13:38AM +0100, Linus Walleij wrote:
> The pen hold/release scheme was copied over to Ux500 from the ARM
> reference designs like most of these at the time. It is not needed
> at all, and was mostly removed in commit c00def71efd9
> "ARM: ux500: simplify secondary CPU boot".
> 
> However on the suspend/resume path and hot plug/unplug of CPUs,
> the .cpu_die() callback was still waiting for the pen to be
> released which made it spin forever and the second core never come
> back online after suspend/resume.
> 
> Fix this by simply replacing the strange custom .cpu_die() with
> a oneline wfi() just like e.g. the qcom platform does. This fixes
> the issue and makes the second core come up properly after
> suspend/resume.
> 
> As a side effect, this rids us of the completely surplus local
> setup.h and hotplug.c files, and we just compile this into platsmp.c
> with everything else SMP.
> 
> Cc: stable at vger.kernel.org
> Fixes: c00def71efd9 ("ARM: ux500: simplify secondary CPU boot")
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for fixes. The bug
> has been around for a while, it is nice to have both CPUs
> online after suspend/resume.

Looks like this one was included in next/late merge by Arnd.


-Olof
