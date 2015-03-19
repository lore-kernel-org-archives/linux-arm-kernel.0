From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Thu, 19 Mar 2015 08:57:16 +0200
Subject: [PATCH 1/2] ARM: dts: sun4i: a10-lime: Override and remove
 1008MHz OPP setting
In-Reply-To: <1426732773-7179-2-git-send-email-wens@csie.org>
References: <1426732773-7179-1-git-send-email-wens@csie.org>
 <1426732773-7179-2-git-send-email-wens@csie.org>
Message-ID: <20150319085716.75d3ce76@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015 10:39:32 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> The Olimex A10-Lime is known to be unstable when running at 1008MHz.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> index 31dc2f1c3870..16ecb8938e19 100644
> --- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> @@ -74,6 +74,20 @@
>  	status = "okay";
>  };
>  
> +&cpu0 {
> +	/* The A10-Lime is known to be unstable when running at 1008 MHz */
> +	operating-points = <
> +		/* kHz    uV */
> +		960000  1400000
> +		912000  1400000
> +		864000  1300000
> +		720000  1200000
> +		528000  1100000
> +		312000  1000000
> +		144000  900000
> +		>;
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };

Thanks for the patch. At least it should make my A10-OLinuXino-LIME
working without obvious failures out of the box (the U-Boot is still
another story though and there is a gap during boot up when the board
is running with unreliable settings, but the probability of a failure
is rather low).

I should also mention that using 960MHz @1.4V does not fail, but it does
not have any safety headroom either (the cyan 'sun4i_poorlime' line
on the plot):

    http://people.freedesktop.org/~siamashka/files/20140512/sunxi-cpufreq-plot.png

On the other hand, my board is on the worst part of the spectrum (many
other a10-lime boards do not fail even at 1008MHz), so maybe having
extra safety headroom is less necessary.

An interesting question is whether the same problem may be reproducible
on the Allwinner A10 devices other than A10-OLinuXino-LIME. My original
problem report

    https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg04343.html
    
mentioned the A10-OLinuXino-LIME rev.A and introduced some sort of
a bias by itself. At least I have seen people saying something like
"my a10-lime revision is not rev.A, so it's none of my concern and
I'm not going to bother running any tests". So far we have accumulated
reports from 4 or 5 people having this reliability problem on their
A10-OLinuXino-LIME (various revisions, not just rev.A), but not
much from the other boards owners.

Anyway, this particular patch is
Tested-by: Siarhei Siamashka <siarhei.siamashka@gmail.com> 
Acked-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>

-- 
Best regards,
Siarhei Siamashka
