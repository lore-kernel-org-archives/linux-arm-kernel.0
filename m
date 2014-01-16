From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jan 2014 12:19:00 +0100
Subject: [PATCH v3 7/7] ARM: brcmstb: dts: add a reference DTS for
 Broadcom 7445
In-Reply-To: <52D72FCD.1030005@gmail.com>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
 <61E0E2A7-F7FC-4397-8E92-06CC409912B9@gmail.com> <52D72FCD.1030005@gmail.com>
Message-ID: <201401161219.01038.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 January 2014, Marc C wrote:
> > And then you can add a regular device driver to drivers/reset that provides a
> > device_reset() API to other drivers, or a system-reset function to be registered as
> > arm_pm_restart. This driver would use syscon_regmap_lookup_by_phandle() to get access
> > to a regmap pointer, and then use either hardcoded offsets into the regmap, or get
> > those offsets from numbers in the devicetree, as provided in the example above.
> 
> I was able to port a standalone "reboot" driver using syscon + regmap. However, for the
> SMP initialization case, it turns out that syscon is configured after SMP init. Do you
> have any advice for this type of situation?
> 
> I'd hate to go around in circles, but without resorting to hard-coded offsets, perhaps I
> can just add the remaining "non-regmap" register offsets in the DT?

You are not the first one to stumble over this problem. There are
two ways to get out of it, and we should probably implement both in
the long run:

1. Other platforms also require the syscon driver to be active before
the regular device driver probing starts. Michal Simek has the same
issue in the zynq clock driver that you have for SMP initialization.
We have talked about this with Mark Brown already, and I think we will
find a solution for this in the end, but it's not as straightforward
as I first hoped. We can probably use help in this area.

2. There is actually no reason for the SMP code to be called this early,
and multiple platforms would like to move SMP init to a later stage.
Stephen Boyd has recently started reworking the way we do SMP init,
and he may have some more insight.

In the meantime, I'd suggest you do the binding under the assumption
that it will work eventually, and then work around the current limitations
in the SMP code by looking for the device nodes you need and map them
manually, as you did in the previous versions of your patch set.

	Arnd
