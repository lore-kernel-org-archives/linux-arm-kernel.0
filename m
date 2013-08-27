From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 27 Aug 2013 15:19:46 -0700
Subject: [PATCH RFC v2 01/16] ARM: call clk_of_init from time_init
In-Reply-To: <1377638890-371-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <3837b119-baad-4e68-8805-2bc52c0135f9@DB9EHSMHS031.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 11:27:55PM +0200, Sebastian Hesselbarth wrote:
> Most DT ARM machs require common clock providers initialized before timers.
> Currently, arch/arm machs use .init_time to call clk_of_init right before
> clocksource_of_init. This prevents to remove that hook and use the default
> hook instead. clk_of_init is safe to call for non-DT platforms, so add
> the call to ARM arch time_init by default. While at it, also reorder includes
> alphabetically.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> v1->v2:
> - reorder includes alphabetically
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-tegra at vger.kernel.org
> Cc: kernel at stlinux.com
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/kernel/time.c |   24 ++++++++++++++----------
>  1 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index 98aee32..dd1028e 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -11,25 +11,26 @@
[ ... ]
>  void __init time_init(void)
>  {
> +	/* initalize common clocks before timers */
> +	of_clk_init(NULL);
> +
>  	if (machine_desc->init_time)
>  		machine_desc->init_time();
>  	else

This forces zynq to move some initialization our clock code relies on to
init_irq(). Also, the current code already takes an approach of
doing either common init or machine specific init.
I think it might be better to move the call to of_clk_init() down into
the else branch of the if-else.
Though, this probably contradicts the purpose of the whole series.

	S?ren
