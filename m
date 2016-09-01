From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 1 Sep 2016 13:35:22 +0200
Subject: [PATCH] rtc: constify rtc_class_ops structures
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160901113522.GC18255@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 10:05:25AM +0200, Julia Lawall wrote:
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
[...]
>  drivers/rtc/rtc-tegra.c      |    2 +-
[...]

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/35fedc39/attachment.sig>
