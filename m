From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Thu, 8 May 2014 05:12:56 +0530
Subject: [PATCH] arm: memset: zero out upper bytes in r1
In-Reply-To: <1399273875-8403-1-git-send-email-a.ryabinin@samsung.com>
References: <1399273875-8403-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20140507234255.GA2050@afzal-ThinkPad-R50e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Mon, May 05, 2014 at 11:11:13AM +0400, Andrey Ryabinin wrote:

> memset doesn't work right for following example:
> 
> 	signed char c = 0xF0;
> 	memset(addr, c, size);
> 
> Variable c is signed, so after typcasting to int the value will be 0xFFFFFFF0.
> This value will be passed through r1 regitster to memset function.
> memset doesn't zero out upper bytes in r1, so memory will be filled
> with 0xFFFFFFF0 instead of expected 0xF0F0F0F0.

> --- a/arch/arm/lib/memset.S
> +++ b/arch/arm/lib/memset.S
> @@ -22,7 +22,8 @@ ENTRY(memset)
>  /*
>   * we know that the pointer in ip is aligned to a word boundary.
>   */
> -1:	orr	r1, r1, r1, lsl #8
> +1:	and	r1, r1, #0xff
> +	orr	r1, r1, r1, lsl #8

int is to be converted to unsigned char in memset, would having above
change immediately upon entry to memset rather than at a place where it
won't always execute make intention clearer ? (although it doesn't make
difference)

ubfx r1, r1, #0, #8 would have given the needed typecasting, but seems
it is available only on ARMv6T2 & above.

Regards
Afzal
