From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 2 Sep 2016 22:32:18 +0200
Subject: [PATCH] rtc: constify rtc_class_ops structures
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160902203218.swu3fcxb266jeq2s@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/2016 at 10:05:25 +0200, Julia Lawall wrote :
> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct rtc_class_ops i at p = { ... };
> 
> @ok@
> identifier r.i;
> expression e1,e2,e3,e4;
> position p;
> @@
> (
> devm_rtc_device_register(e1,e2,&i at p,e3)
> |
> rtc_device_register(e1,e2,&i at p,e3)
> |
> platform_device_register_data(e1,e2,e3,&i at p,e4)
> )
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> @@
> i at p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct rtc_class_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/rtc/rtc-at32ap700x.c |    2 +-
>  drivers/rtc/rtc-coh901331.c  |    2 +-
>  drivers/rtc/rtc-davinci.c    |    2 +-
>  drivers/rtc/rtc-digicolor.c  |    2 +-
>  drivers/rtc/rtc-ds1302.c     |    2 +-
>  drivers/rtc/rtc-gemini.c     |    2 +-
>  drivers/rtc/rtc-jz4740.c     |    2 +-
>  drivers/rtc/rtc-mcp795.c     |    2 +-
>  drivers/rtc/rtc-mt6397.c     |    2 +-
>  drivers/rtc/rtc-nuc900.c     |    2 +-
>  drivers/rtc/rtc-omap.c       |    2 +-
>  drivers/rtc/rtc-palmas.c     |    2 +-
>  drivers/rtc/rtc-pcf50633.c   |    2 +-
>  drivers/rtc/rtc-rx6110.c     |    2 +-
>  drivers/rtc/rtc-rx8025.c     |    2 +-
>  drivers/rtc/rtc-spear.c      |    2 +-
>  drivers/rtc/rtc-stmp3xxx.c   |    2 +-
>  drivers/rtc/rtc-tegra.c      |    2 +-
>  drivers/rtc/rtc-twl.c        |    2 +-
>  19 files changed, 19 insertions(+), 19 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
