From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 17 Dec 2013 19:31:21 +0100
Subject: pwm-backlight: 3.13-rc1 regression for old arm machine
In-Reply-To: <20131217095658.GD13823@ulmo.nvidia.com> (Thierry Reding's
 message of "Tue, 17 Dec 2013 10:57:00 +0100")
References: <87r49c6bea.fsf@free.fr> <20131217095658.GD13823@ulmo.nvidia.com>
Message-ID: <87iounuy6e.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> I hadn't anticipated that =(. In fact I had been holding this patch back
> for a release cycle because I was waiting for a specific regulator patch
> to land which provides a dummy regulator if one wasn't specified. It
> seems that that patch only works when booting from DT, though.
>
> The correct way to fix this would be to provide a lookup table with the
> dummy regulator in the board file. I've attached a patch (compile-tested
> only) that might work.
>
> If it does, please let me know and, if nobody else volunteers, I'll see
> if I can come up with a set of patches to fix this for any other boards
> that have the same issue.
Actually, it needs a very small "tweak" to work :
-	REGULATOR_SUPPLY("power", "pwm-backlight.0"),
+	REGULATOR_SUPPLY("power", "pwm-backlight"),

Without it regulator_dev_lookup() won't match the device.

Moreover, it requires a config option, CONFIG_REGULATOR_FIXED_VOLTAGE=y. That's
not a problem for my specific platform, but I haven't seen *any* PXA platform
with it activated, which means all defconfigs have to be patched, which is
unfortunate.

As for my specific mioa701, your change with the tweak is perfectly fine and
tested.

Cheers.

--
Robert
