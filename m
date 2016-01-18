From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Jan 2016 10:42:11 +0900
Subject: [PATCH 1/3] ARM: shmobile: timer: Fix preset_lpj leading to too
 short delays
In-Reply-To: <1452537674-20006-2-git-send-email-geert+renesas@glider.be>
References: <1452537674-20006-1-git-send-email-geert+renesas@glider.be>
 <1452537674-20006-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20160118014210.GD1905@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 07:41:12PM +0100, Geert Uytterhoeven wrote:
> On all shmobile ARM SoCs, loop-based delays may complete early, which
> can be after only 1/3 (Cortex A9) or 1/2 (Cortex A7 or A15) of the
> minimum required time.
> 
> This is caused by calculating preset_lpj based on incorrect assumptions
> about the number of clock cycles per loop:
>   - All of Cortex A7, A9, and A15 run __loop_delay() at 1 loop per
>     CPU clock cycle,
>   - As of commit 11d4bb1bd067f9d0 ("ARM: 7907/1: lib: delay-loop: Add
>     align directive to fix BogoMIPS calculation"), Cortex A8 runs
>     __loop_delay() at 1 loop per 2 instead of 3 CPU clock cycles.
> 
> On SoCs with Cortex A7 and/or A15 CPU cores, this went unnoticed, as
> delays use the ARM arch timer if available. R-Car Gen2 doesn't work if
> the arch timer is disabled. However, APE6 can be used without the arch
> timer.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Backporting note: older kernels need modifications in all calls to
> shmobile_setup_delay() or shmobile_setup_delay_hz().

Thanks, I have queued this up for v4.6.
