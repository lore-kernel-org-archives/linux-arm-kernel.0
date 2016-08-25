From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Thu, 25 Aug 2016 21:37:27 +0800
Subject: [PATCH v13 0/4] Mediatek MT8173 CMDQ support
In-Reply-To: <20b10079-3ae2-9da9-1149-0bceabac9837@gmail.com>
References: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
 <20b10079-3ae2-9da9-1149-0bceabac9837@gmail.com>
Message-ID: <1472132247.26044.23.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Wed, 2016-08-24 at 13:00 +0200, Matthias Brugger wrote:
> On 24/08/16 05:27, HS Liao wrote:
[...]
> > Changes since v12:
> >  - remove mediatek,gce from device tree
> 
> Why? The binding got accepted by Rob.

We can get cmdq dev from mailbox controller,
so we don't need mediatek,gce anymore.

> >
> > Best regards,
> > HS Liao
> >
> > HS Liao (4):
> >   dt-bindings: soc: Add documentation for the MediaTek GCE unit
> >   CMDQ: Mediatek CMDQ driver
> >   arm64: dts: mt8173: Add GCE node
> >   CMDQ: save more energy in idle
> >
> >  .../devicetree/bindings/soc/mediatek/gce.txt       |  44 +
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
> >  drivers/soc/mediatek/Kconfig                       |  11 +
> >  drivers/soc/mediatek/Makefile                      |   1 +
> >  drivers/soc/mediatek/mtk-cmdq.c                    | 983 +++++++++++++++++++++
> 
> The driver uses the mailbox framework, so it should live in the 
> drivers/mailbox folder.

As you know, the maximum number of gce threads is 16.
However, we plan to support more clients in the future,
and they may need to use more than 16 gce threads.

For this issue, our plan is to let multiple clients share the same gce
thread; i.e. we will acquire gce thread for client dynamically by
internal policy in cmdq driver.
Unfortunately. mailbox channel has exclusive feature.
Quote from comment of mbox_request_channel().
"The channel is exclusively allocated and can't be used by another
client before the owner calls mbox_free_channel."
Therefore, we plan to remove mailbox framework from cmdq driver in the
future.

For current status, could you tell us your preference?
(1) Move cmdq to mailbox folder and then move it back here when we
submit another patch to support more than 16 gce clients; or
(2) Remove mailbox framework from cmdq now for its future extensibility.

Thanks,
HS

> Please don't forget to add Jassi to the loop, as he is the maintainer of 
> this subsystem and the last instance to decide if/when the driver will 
> get accepted.
> 
> Thanks,
> Matthias
> 
