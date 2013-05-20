From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 May 2013 10:10:08 +0100
Subject: [PATCH] arm64: kernel: need extern variable 'screen_info' for
 related driver using.
In-Reply-To: <5199B7D6.40907@asianux.com>
References: <5199B7D6.40907@asianux.com>
Message-ID: <20130520091008.GB31359@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen,

On Mon, May 20, 2013 at 06:42:46AM +0100, Chen Gang wrote:
> 
> Add the extern variable 'screen_info' according to arm32 has done.
> 
> The related error:
>   drivers/video/console/vgacon.c:1305: undefined reference to `screen_info'
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/kernel/setup.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index add6ea6..1055992 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -374,3 +374,14 @@ const struct seq_operations cpuinfo_op = {
>  	.stop	= c_stop,
>  	.show	= c_show
>  };
> +
> +#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
> +struct screen_info screen_info = {
> +	.orig_video_lines	= 30,
> +	.orig_video_cols	= 80,
> +	.orig_video_mode	= 0,
> +	.orig_video_ega_bx	= 0,
> +	.orig_video_isVGA	= 1,
> +	.orig_video_points	= 8
> +};
> +#endif

I think it would be better if we added a something like
CONFIG_HAVE_VGA_CONSOLE, which VGA_CONSOLE can then depend on. Architectures
like x86 can then select the former, and we can remove the long list of
architectures from the current option.

Will
