From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 14:17:46 -0600
Subject: [RESEND PATCH 1/2] ARM: dts: Change dw-apb-timer-osc and
 dw-apb-timer-sp to just dw-apb-timer
In-Reply-To: <1375740158-10012-1-git-send-email-dinguyen@altera.com>
References: <1375740158-10012-1-git-send-email-dinguyen@altera.com>
Message-ID: <5203FCEA.7040709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 04:02 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> "dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
> DW APB timer, just fed by different clocks.

I assume patch 1/1 made similar changes to the driver?

> diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt

>  Required properties:
> -- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
> +- compatible: "snps,dw-apb-timer"

This change is problematic w.r.t device tree as an ABI. any DT that uses
the new value "snps,dw-apb-timer" will not work with older software that
was written to expect the old values.

Similarly, if the driver was edited to only support the new value listed
above, then old DTs will not work with the new driver.

Instead, I think what you need to do is:

a) Update the driver to support all 3 compatible values, so all DTs will
work with the new driver.

b) Modify the *.dtsi files to uses one of the old compatible values, so
the new DTs will work with the old driver.

c) Modify the binding document to mention all 3 compatible values, but
mark the old 2 as deprecated.
