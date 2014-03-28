From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Mar 2014 08:55:49 +0100
Subject: [PATCH 00/17] i2c: deprecate class based instantiation for
 embedded I2C drivers
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20140328075548.GD2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:03:54AM +0100, Wolfram Sang wrote:
> With I2C, class based instantiation means if a master driver has e.g.
> I2C_CLASS_HWMON set, all slave drivers with this class will try to probe a
> device using an array of possible addresses and some heuristics. That creates
> traffic and needs time, even when nothing is connected. This mechanism is
> needed when you do not have another method to describe the slaves. Embedded I2C
> drivers do not need class based instantiation, since there is i2c_board_info or
> devicetree description. Some drivers have the class flags set, though, and it
> has spread further over the years. We can't remove the flags directly, because
> there might be users out there relying on this feature. So, we add a
> deprecation warning if a device is instantiated via class attributes. After
> giving some time to switch over, we can then finally remove the class flags and
> gain boot time.
> 
> Patch 1 adds some missing documentation. Patch 2 adds the deprecation feature.
> Patches 3+4 are tested on hardware I need. Patches 5-17 are suggestions for
> drivers I think could benefit from that. For those, acks are needed before I
> will apply them to my tree. If you use a different driver which can also
> benefit from this, just send a patch adding the new DEPRECATED flag.
> 
> The series can also be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/deprecated_class
> 
> Thanks,
> 
>    Wolfram
> 
> 
> Wolfram Sang (17):
>   Documentation: i2c: describe devicetree method for instantiating
>     devices
>   i2c: add deprecation warning for class based instantiation
>   i2c: i2c-omap: deprecate class based instantiation
>   i2c: i2c-at91: deprecate class based instantiation
>   i2c: i2c-bcm2835: deprecate class based instantiation
>   i2c: i2c-bfin-twi: deprecate class based instantiation
>   i2c: i2c-davinci: deprecate class based instantiation
>   i2c: i2c-designware-platdrv: deprecate class based instantiation
>   i2c: i2c-mv64xxx: deprecate class based instantiation
>   i2c: i2c-nomadik: deprecate class based instantiation
>   i2c: i2c-ocores: deprecate class based instantiation
>   i2c: i2c-rcar: deprecate class based instantiation
>   i2c: i2c-s3c2410: deprecate class based instantiation
>   i2c: i2c-sirf: deprecate class based instantiation
>   i2c: i2c-stu300: deprecate class based instantiation
>   i2c: i2c-tegra: deprecate class based instantiation
>   i2c: i2c-xiic: deprecate class based instantiation

I reconsidered and have now applied all patches. That way, all these
drivers can be converted to no class based instantiation in one go after
some grace period. If it turns out, one driver actually needs it, there
is still the grace period left to remove the DEPRECATED flag again.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/dd0e039f/attachment-0001.sig>
