From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Sat, 30 Jul 2016 17:20:49 +0200
Subject: [PATCH 2/2] ASoC: sunxi: compatibility for sun6i to SPDIF
In-Reply-To: <170941469890365@web9j.yandex.ru>
References: <20160730142716.29377-1-codekipper@gmail.com>
 <20160730142716.29377-3-codekipper@gmail.com>
 <170941469890365@web9j.yandex.ru>
Message-ID: <20160730152049.GU6215@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 10:52:45PM +0800, Icenowy Zheng wrote:
> > + if (of_device_is_compatible(pdev->dev.of_node,
> > + "allwinner,sun6i-a31-spdif")) {
> > + host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
> > + if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
> > + ret = -EPROBE_DEFER;
> > + dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
> > + goto err_disable_apb_clk;
> > + }
> > + if (!IS_ERR(host->rst))
> > + reset_control_deassert(host->rst);
> > + }
> > +
> I think you do not need the compatible.
> You can just detect whether the reset is present.

That would weaken the error check. If we're running on the A31 and are
missing our reset property, it would go unnoticed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160730/16e2204c/attachment.sig>
