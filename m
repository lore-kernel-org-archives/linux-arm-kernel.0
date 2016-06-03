From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 3 Jun 2016 18:54:26 +0200
Subject: [RFC PATCH v1 4/6] PM / devfreq: event: support rockchip dfi
 controller
In-Reply-To: <1464947719-6245-5-git-send-email-hl@rock-chips.com>
References: <1464947719-6245-1-git-send-email-hl@rock-chips.com>
 <1464947719-6245-5-git-send-email-hl@rock-chips.com>
Message-ID: <20160603165426.GC21013@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 05:55:17PM +0800, Lin Huang wrote:
[...]
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable clk: %d\n", ret);
> +		clk_disable_unprepare(data->clk);
> +		return ret;
> +	}

This is going to give you a large WARN. clk_prepare_enable() already
leaves the clock in a proper state when it fails (i.e. it calls
clk_unprepare() if the clk_enable() part failed), so calling
clk_disable_unprepare() upon failure is going to unbalance the
reference counts.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160603/74ea7cb3/attachment.sig>
