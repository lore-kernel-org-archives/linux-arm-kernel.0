From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Jan 2014 17:12:54 +0100
Subject: [PATCH] ARM: cache-l2x0: Parse properties from DT for PL310 cache
 controller
In-Reply-To: <52CC2381.2090905@arm.com>
References: <1389094888-24348-1-git-send-email-tushar.behera@linaro.org>
 <4325123.pn10H18tk9@wuerfel> <52CC2381.2090905@arm.com>
Message-ID: <6680044.VpT1oREkGO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014 15:55:45 Sudeep Holla wrote:
> On 07/01/14 12:54, Arnd Bergmann wrote:
> > On Tuesday 07 January 2014 12:41:42 Sudeep Holla wrote:
> >> Hi Tushar,
> >>
> >> This has been discussed couple of times in past[1][2], and the opinion was not
> >> to have these in DT as they are more configuration data than the actual hardware
> >> description.
> > 
> > How do you suggest we get rid of the magic constants in platform code then?
> > I definitely don't want to keep the current state, and having configuration
> > data in DT seems the lesser evil.
> > 
> 
> I agree, but since these are more L2CC configuration than hardware description,
> IMO chosen node is one option. However it's good to get opinion from DT guys.

I think one of the discussions we had during the Edinburgh kernel summit resulted
in being more relaxed towards configuration data in device nodes.

> > Are there some reasonable defaults that Linux could use independent of the
> > platform and of what the boot loader defaults to?
> > 
> 
> Most of these registers can't be programmed in Non-secure mode. So as mentioned
> already in previous discussions it is better to avoid these settings in kernel.
> It would be better if bootloader programs these settings even if Linux runs in
> secure mode for simplicity.

Yes, that would be ideal, but I fear we have to live with the boot loaders that
are in existence already. Whether or not the registers can be programmed in
non-secure mode is certainly a piece of information that belongs into the DT
node, so we don't try to write them when we shouldn't. We could also have a
property that identifies whether the boot loader has in fact set up the cache
controller correctly or whether Linux has to do it. There should be no
argument about this being out of scope, since it describes a platform property
(presence of a sane boot loader) rather than the actual configuration.

If we decide to have such properties and we boot on a system where we can
and should change the settings, is there a way for Linux to know what the
settings are supposed to be other than reading them from a DT file or
from a per-platform default?

	Arnd
