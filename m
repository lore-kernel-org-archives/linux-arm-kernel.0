From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2009 21:17:59 +0000
Subject: [PATCH] ARM: Wrong size used in dump_mem()
In-Reply-To: <4B2A9F8E.5080508@gmail.com>
References: <4B2A9F8E.5080508@gmail.com>
Message-ID: <20091217211759.GB16520@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 10:15:58PM +0100, Roel Kluin wrote:
> The sizeof the pointed to should be used rather than of the pointer
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Unless I am mistaken?

You are mistaken.  sizeof(array) is the byte size of the array.
sizeof(*array) is the size of one individual object of the array.

The code is correct as is - which is to fill  the entire array with
space characters and then zero the last one.

> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 3f361a7..5e828fa 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -102,7 +102,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
>  		unsigned long p;
>  		char str[sizeof(" 12345678") * 8 + 1];
>  
> -		memset(str, ' ', sizeof(str));
> +		memset(str, ' ', sizeof(*str));
>  		str[sizeof(str) - 1] = '\0';
>  
>  		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
