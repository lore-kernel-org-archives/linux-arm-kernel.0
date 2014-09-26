From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 14:32:29 +0200
Subject: [RFC] should we remove soc subnode in all berlin SoC's dts if
 SOC_BUS is selected
In-Reply-To: <20140926193945.3bb94276@xhacker>
References: <20140926193945.3bb94276@xhacker>
Message-ID: <1821058.sf1gKKFj8T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 September 2014 19:39:45 Jisheng Zhang wrote:
> We want to export machine name, soc family, chip revision and chipid to
> userspace via. the SOC BUS interface, i.e call soc_device_register()
> 
> It works perfectly, but there's one side effect: every device nodes will have
> an additional level. For example:
> 
> /sys/devices/soc.0/xxx.sdhci will be changed to
> 
> /sys/devices/soc0/soc.0/xxx.sdhci
> 
> This seems a bit ugly. I have one solution: remove "soc" subnodes in all berlin's
> dts, then we will have 
> 
> /sys/devices/soc0/xxx.sdhci
> 
> Is there any better solution? 
> 

As of a recent discussion, we decided that the soc_device_register is now
purely informational and not meant to be used as the root for all the
other devices.

The structure in the DTS is fine and will continue to do the right thing.

Originally the intention was that soc_device_register would be used to
register the soc device  that corresponds to your /soc device node in DT,
and then you'd populate the other devices below, but we never implemented
a nice way to call that, so you don't need to bother with it.

Instead, you will now have /sys/devices/soc0/ for the soc_device you register
manually, and /sys/devices/soc.0/ to correspond with the DT node and continues
to have the child devices. This is still a bit confusing, but should be
consistent across all (new) platforms.

	Arnd
