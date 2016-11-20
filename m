From: dianders@chromium.org (Doug Anderson)
Date: Sun, 20 Nov 2016 11:15:36 -0800
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <20161119110301.GQ1041@n2100.armlinux.org.uk>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk> <582F0DD2.3030805@free.fr>
 <20161119071702.GA25647@afzalpc> <20161119110301.GQ1041@n2100.armlinux.org.uk>
Message-ID: <CAD=FV=VaTAtN94kySt+V5B8HGDEwFra91HaAyqNhpib2Mz=bww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 19, 2016 at 3:03 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> Linus, how about we add something like this to linux/delay.h to document
> this fact?
>
>  include/linux/delay.h | 12 +++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/delay.h b/include/linux/delay.h
> index a6ecb34cf547..2ecb3c46b20a 100644
> --- a/include/linux/delay.h
> +++ b/include/linux/delay.h
> @@ -5,6 +5,18 @@
>   * Copyright (C) 1993 Linus Torvalds
>   *
>   * Delay routines, using a pre-computed "loops_per_jiffy" value.
> + *
> + * Please note that ndelay(), udelay() and mdelay() may return early for
> + * several reasons:
> + *  1. computed loops_per_jiffy too low (due to the time taken to
> + *     execute the timer interrupt.)
> + *  2. cache behaviour affecting the time it takes to execute the
> + *     loop function.
> + *  3. CPU clock rate changes.
> + * As a result, delays should always be over-stated.
> + *
> + * Please see this thread:
> + *   http://lists.openwall.net/linux-kernel/2011/01/09/56
>   */

Any reason not to land Mason's patch _and_ land your comment change.
They you eliminate the arbitrary/pointless inaccuracy but still
reinforce that delays are not accurate.
