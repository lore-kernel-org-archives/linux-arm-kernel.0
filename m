From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 23 Jan 2017 11:04:22 +0100
Subject: [PATCH] ARM: tegra: paz00: fix __initdata placement
In-Reply-To: <20170123074347.GA29804@dtor-ws>
References: <20170123074347.GA29804@dtor-ws>
Message-ID: <4072003.S1IBmddlP7@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dmitry,

Am Sonntag, 22. Januar 2017, 23:43:47 CET schrieb Dmitry Torokhov:
> To have expected effect the __initdata attribute should go after variable
> name and before initializer.`
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/arm/mach-tegra/board-paz00.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tegra/board-paz00.c
> b/arch/arm/mach-tegra/board-paz00.c index 7478f6fb3664..ea6bff404161 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -23,7 +23,7 @@
> 
>  #include "board.h"
> 
> -static struct property_entry __initdata wifi_rfkill_prop[] = {
> +static struct property_entry wifi_rfkill_prop[] __initdata = {
>  	PROPERTY_ENTRY_STRING("name", "wifi_rfkill"),
>  	PROPERTY_ENTRY_STRING("type", "wlan"),
>  	{ },

you are right according to the documentation, but objdump -s always shows that 
it gets put into the .rodata section. So this patch has no effect, because 
result is always same (and wrong). It's also possible that I'm doing something 
wrong :-) Btw, there are hundreds of such __initdata misplacement in the 
kernel.

Marc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170123/9ac10752/attachment.sig>
