From: sre@ring0.de (Sebastian Reichel)
Date: Sun, 1 Oct 2017 15:11:52 +0200
Subject: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
In-Reply-To: <20170929223411.9691-2-tony@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-2-tony@atomide.com>
Message-ID: <20171001131151.loanjnvarkihbhik@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 29, 2017 at 03:34:05PM -0700, Tony Lindgren wrote:
> With the recently introduced omap clkctrl module binding, we can start
> moving omap hwmod data to device tree and drivers from arch/arm/mach-omap2.
> 
> To start doing this, let's introduce a device tree binding for TI
> sysc interconnect target module hardware. The sysc manages module clocks,
> idlemodes and interconnect level resets. Each interconnect target module
> can have one or more child devices connected to it.
> 
> TI sysc interconnect target module hardware is independent of the
> interconnect. It is used at least with TI L3 interconnect (Arteris NoC)
> and TI L4 interconnect (Sonics s3220). The sysc is mostly used for
> interaction between module and PRCM. It participates in the OCP Disconnect
> Protocol but other than that is mostly indepenent of the interconnect.
> 
> As all the features may not be supported for a given sysc module, we
> need to use device tree configuration for the revision of the interconnect
> target module.
> 
> Note that the interconnect target module control registers are always
> sprinked at varying locations in the unused address space of the first
> child device IP block. To avoid device tree reg conflicts, the sysc device
> provides ranges for it's children.
> 
> For a non-intrusive transition from static hwmod data to using device
> tree defined TI interconnect target module binding, we can keep things
> working with static hwmod data if device tree property "ti,hwmods" is
> specified for the the interconnect target module.
> 
> Note that additional properties for sysc capabilities will be added
> later on. For now, we can already use this binding for interconnect
> target modules that do not have any child device drivers available.
> This allows us to idle the unused interconnect target modules during
> init without the need for legacy hwmod platform data for doing it.

DT backwards compatibility is about booting an old DT file with a
newer kernel. Since old DT file does not contain a "ti,sysc-omap*"
node you don't need to add "ti,hwmod = *" support to it. Instead a
DT file, that uses ti,hwmod in the device node and does not have a
"ti,sysc-omap*" at all should still work.

IMHO we should break DT ABI for OMAP at some point, so that we can
get rid of the hwmod database. My suggestion would be, that
simple-bus checks if any child device is != "ti,omap-sysc*" and
does panic("please update DT!").

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171001/ddc1f844/attachment.sig>
