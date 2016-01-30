From: rabin@rab.in (Rabin Vincent)
Date: Sat, 30 Jan 2016 19:40:05 +0100
Subject: [PATCH] recordmcount: arm: Implement make_nop
In-Reply-To: <1454116686-30190-1-git-send-email-sboyd@codeaurora.org>
References: <1454116686-30190-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160130184005.GA29607@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 05:18:06PM -0800, Stephen Boyd wrote:
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index e167592793a7..0b16d14c54fb 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -206,6 +206,52 @@ static int make_nop_x86(void *map, size_t const offset)
>  	return 0;
>  }
>  
> +/*
> + * Indicates if ARM is using __gnu_mcount_nc or mcount style and if
> + * we should replace it with a pop or a nop respectively.
> + */

For __gnu_mcount_nc, wouldn't it be better to replace both the push {lr}
and the bl with nop instructions, instead of keeping a (useless) push +
pop sequence?

> +static int uses_altmcount;
> +
> +static unsigned char ideal_nop4_arm_arm[4] = { 0x00, 0x40, 0xbd, 0xe8 };
> +static unsigned char ideal_nop4_arm_thumb[4] = { 0x5d, 0xf8, 0x04, 0xeb };
> +static unsigned char ideal_nop4_arm_arm_be[4] = { 0xe8, 0xbd, 0x40, 0x00 };
> +static unsigned char ideal_nop4_arm_thumb_be[4] = { 0xf8, 0x5d, 0xeb, 0x04 };
> +static unsigned char ideal_nop4_arm_old[4] = { 0x00, 0x00, 0xa0, 0xe1 };
> +static unsigned char ideal_nop4_arm_old_be[4] = { 0xe1, 0xa0, 0x00, 0x00 };
> +
> +static unsigned char bl_gnu_mcount_nc_arm[4] = { 0xfe, 0xff, 0xff, 0xeb };
> +static unsigned char bl_gnu_mcount_nc_thumb[4] = { 0xff, 0xf7, 0xfe, 0xff };
> +static unsigned char bl_gnu_mcount_nc_arm_be[4] = { 0xeb, 0xff, 0xff, 0xfe };
> +static unsigned char bl_gnu_mcount_nc_thumb_be[4] = { 0xf7, 0xff, 0xff, 0xfe };

Comments showing what assembly instructions all these correspond to
would be helpful.
