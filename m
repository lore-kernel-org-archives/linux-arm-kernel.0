From: tony@atomide.com (Tony Lindgren)
Date: Thu, 27 Aug 2015 09:59:41 -0700
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <OFCA2F1DCE.C787A961-ONC1257EAE.001D79BC-C1257EAE.00203AFF@br-automation.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <1432156863-19695-3-git-send-email-tony@atomide.com>
 <OFCA2F1DCE.C787A961-ONC1257EAE.001D79BC-C1257EAE.00203AFF@br-automation.com>
Message-ID: <20150827165940.GY4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Hannes Schmelzer <Hannes.Schmelzer@br-automation.com> [150826 22:55]:
> Hi Tony,
> 
> Did anyone test this changeset on some AM335x board?

Apparently not if it does not work or else you somehow have a different
configuration for GPMC.
 
> Today I ran into trouble with that because:
> 
> The GPMC controller gets reseted on kernel boot due to the missing/removed 
> HWMOD_INIT_NO_RESET flag.

Oh so you mean it only works on am335x if CONFIG_OMAP_GPMC_DEBUG is set?
 
> Primary this should not be a big problem, but on my board (maybe on all 
> AM335x) the GPMC doesn't behave as described in TRM.
> Especially the GPMC_CONFIG register is not reset to 0h after reset, 
> instead it holds the value 0xa00 which is very strange because bit 10-31 
> are reserved.
> 
> Further this 0xa00 means that Bit9 (WAIT1PINPOLARITY) is set, exactly this 
> causes my system to stall on first access the connected NAND flash because 
> it never becomes ready due to the wrong wait pin polarity. Maybe others 
> dont't run into trouble because they may use WAIT0PIN, which one has it's 
> old polarity.
> 
> First approach was simply to write 0x0 to the GPMC_CONFIG register during 
> gpmc_probe function.
> It solves the problem.

OK
 
> I also tried to issue some SYSRESET through GPMC registers without 
> success, same strange behavior.

Interesting, never heard of that one before.
 
> What?s your thinking around that?

We could add a custom hwmod reset function that sets GPMC_CONFIG to 0.
Similar to omap_i2c_reset() is set up. Or we could set up a property for
the wait pin polarity. Roger, got any better ideas?

Regards,

Tony
