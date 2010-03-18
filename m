From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Mar 2010 08:47:43 +0000
Subject: [RFC/PATCH 08/10] [ARM] tegra: Add framebuffer driver
In-Reply-To: <1268721688-27550-9-git-send-email-konkers@google.com>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-1-git-send-email-konkers@google.com>
	<1268721688-27550-2-git-send-email-konkers@google.com>
	<1268721688-27550-3-git-send-email-konkers@google.com>
	<1268721688-27550-4-git-send-email-konkers@google.com>
	<1268721688-27550-5-git-send-email-konkers@google.com>
	<1268721688-27550-6-git-send-email-konkers@google.com>
	<1268721688-27550-7-git-send-email-konkers@google.com>
	<1268721688-27550-8-git-send-email-konkers@google.com>
	<1268721688-27550-9-git-send-email-konkers@google.com>
Message-ID: <20100318084743.GC8267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 11:41:26PM -0700, konkers at google.com wrote:
> +static int tegra_fb_set_par(struct fb_info *info)
> +{
> +	struct tegra_fb_info *tegra_fb = info->par;
> +	struct fb_var_screeninfo *var = &info->var;
> +	struct fb_fix_screeninfo *fix = &info->fix;
> +	u32 color_depth;
> +	unsigned int h_dda;
> +	unsigned int v_dda;
> +
> +	/* we only support RGB ordering for now */
> +	switch (var->bits_per_pixel) {
> +	case 32:
> +	case 24:
> +		var->red.offset = 0;
> +		var->red.length = 8;
> +		var->green.offset = 8;
> +		var->green.length = 8;
> +		var->blue.offset = 16;
> +		var->blue.length = 8;
> +		color_depth = DC_COLOR_DEPTH_B8G8R8A8;
> +		break;
> +	case 16:
> +		var->red.offset = 11;
> +		var->red.length = 5;
> +		var->green.offset = 5;
> +		var->green.length = 6;
> +		var->blue.offset = 0;
> +		var->blue.length = 5;
> +		color_depth = DC_COLOR_DEPTH_B5G6R5;
> +		break;
> +	default:
> +		return -1;

Is this really -EPERM, "Operation not permitted"?  Please use a proper
errno code rather than just thinking "Oh, I'll use -1 because its easier".
