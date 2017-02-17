From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2017 17:31:01 +0000
Subject: [PATCH] arm64: traps: Mark __le16, __le32, __user variables
 properly
In-Reply-To: <20170217165112.17512-1-stephen.boyd@linaro.org>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
Message-ID: <20170217173101.GH21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 08:51:12AM -0800, Stephen Boyd wrote:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 659b2e6b6cf7..23959cb70ded 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -84,7 +84,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
>  			if (p >= bottom && p < top) {
>  				unsigned long val;
>  
> -				if (__get_user(val, (unsigned long *)p) == 0)
> +				if (__get_user(val, (unsigned long __user *)p) == 0)
>  					sprintf(str + i * 17, " %016lx", val);
>  				else
>  					sprintf(str + i * 17, " ????????????????");
> @@ -113,7 +113,7 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
>  	for (i = -4; i < 1; i++) {
>  		unsigned int val, bad;
>  
> -		bad = __get_user(val, &((u32 *)addr)[i]);
> +		bad = __get_user(val, &((u32 __user *)addr)[i]);
>  
>  		if (!bad)
>  			p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
> @@ -340,23 +340,28 @@ static int call_undef_hook(struct pt_regs *regs)
>  		return 1;
>  
>  	if (compat_thumb_mode(regs)) {
> +		__le16 tinst;
> +
>  		/* 16-bit Thumb instruction */
> -		if (get_user(instr, (u16 __user *)pc))
> +		if (get_user(tinst, (__le16 __user *)pc))
>  			goto exit;
> -		instr = le16_to_cpu(instr);
> +		instr = le16_to_cpu(tinst);
>  		if (aarch32_insn_is_wide(instr)) {
> -			u32 instr2;
> +			__le16 tinstr2;
> +			u16 instr2;
>  
> -			if (get_user(instr2, (u16 __user *)(pc + 2)))
> +			if (get_user(tinstr2, (__le16 __user *)(pc + 2)))
>  				goto exit;
> -			instr2 = le16_to_cpu(instr2);
> +			instr2 = le16_to_cpu(tinstr2);
>  			instr = (instr << 16) | instr2;
>  		}
>  	} else {
> +		__le32 ainst;
> +
>  		/* 32-bit ARM instruction */
> -		if (get_user(instr, (u32 __user *)pc))
> +		if (get_user(ainst, (__le32 __user *)pc))
>  			goto exit;
> -		instr = le32_to_cpu(instr);
> +		instr = le32_to_cpu(ainst);

For the majority of causes, these are _not_ user addresses, they are
kernel addresses.  The use of get_user() at these locations is a way
to safely access these kernel addresses when something has gone wrong
without causing a further oops.

Annotating them with __user to shut up sparse is incorrect.  The point
with sparse is _not_ to end up with a warning free kernel, but for it
to warn where things are not quite right in terms of semantics.  These
warnings should stay.

So, the warnings about lack of __user should stay.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
