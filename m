From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 3 Dec 2016 10:24:43 +0900
Subject: [PATCH] clk: uniphier: Fix build with gcc-4.4.
In-Reply-To: <1480725436-9628-1-git-send-email-vlee@freedesktop.org>
References: <1480725436-9628-1-git-send-email-vlee@freedesktop.org>
Message-ID: <CAK7LNATeswNhoFsA90k=qF4Jock0ytNT-pPT6j+0b9MJFJwu9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinson,

2016-12-03 9:37 GMT+09:00 Vinson Lee <vlee@freedesktop.org>:
> gcc-4.4 has issues with anonymous unions in initializers.
>
>   CC      drivers/clk/uniphier/clk-uniphier-sys.o
> drivers/clk/uniphier/clk-uniphier-sys.c:45: error: unknown field ?factor? specified in initializer
>
> Fixes: 1574d5722636 ("clk: uniphier: remove unneeded member name for union")
> Signed-off-by: Vinson Lee <vlee@freedesktop.org>


This driver has COMPILE_TEST option, but kbuild test robot
did not mention about this.



This is a bad way of fixing, I think.
(what if a new member is inserted before the union in the future?)

Rather, please revert the bad commit.


>                 .name = "sd" #ch "-sel",                                \
>                 .type = UNIPHIER_CLK_TYPE_MUX,                          \
>                 .idx = -1,                                              \
> -               .mux = {                                                \
> +               { .mux = {                                              \
>                         .parent_names = {                               \
>                                 "sd-44m",                               \
>                                 "sd-33m",                               \
> @@ -63,7 +63,7 @@
>                                 0x00001200,                             \
>                                 0x00001300,                             \
>                         },                                              \
> -               },                                                      \
> +               } },                                                    \
>         },                                                              \


No, please do not do this.






-- 
Best Regards
Masahiro Yamada
