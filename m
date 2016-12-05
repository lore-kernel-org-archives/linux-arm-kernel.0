From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 5 Dec 2016 12:02:38 +0530
Subject: [PATCH v4] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <907a3c22-534f-80ce-daff-be84dd5e5cf8@lechnology.com>
References: <1480690380-13216-1-git-send-email-abailon@baylibre.com>
 <907a3c22-534f-80ce-daff-be84dd5e5cf8@lechnology.com>
Message-ID: <21fbc91f-5e85-86d0-dc97-4188bcafe5ad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Monday 05 December 2016 09:14 AM, David Lechner wrote:
> I have just tried this patch with a bunch of kernel hacking options
> enabled. I am getting the message show at the end of this email. We
> still have the problem of nested spin locks due to nested calls to
> clk_enable(). So, really, we need to use __clk_enable() and
> __clk_disable() from arch/arm/mach-davinci/clock.c in
> usb20_phy_clk_enable() above.

Good catch. I noticed  that common clock framework uses a more elaborate
mechanism to allow nested clock API calls (see clk_prepare_lock()), but
we don't (yet) have that issue in mach-davinci since the recursive calls
are still in mach-davinci and dont need the exported API to be
recursively callable.

> Applying the following patch on top of your patch fixed the recursive
> lock message.

The patch looks okay to me, except couple of minor adjustments.

> 
> ---
> 
> diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
> index df42c93..4fba579 100644
> --- a/arch/arm/mach-davinci/clock.c
> +++ b/arch/arm/mach-davinci/clock.c
> @@ -31,7 +31,7 @@ static LIST_HEAD(clocks);
>  static DEFINE_MUTEX(clocks_mutex);
>  static DEFINE_SPINLOCK(clockfw_lock);
> 
> -static void __clk_enable(struct clk *clk)
> +void __clk_enable(struct clk *clk)

Now that this function is going to be used outside of this file, lets
drop the __ naming convention and call this davinci_clk_enable() in line
with how other davinci-local clock APIs are named. Same thing for the
disable counterpart.

Also, the making these function non-static should be a patch of its own.

Thanks,
Sekhar
