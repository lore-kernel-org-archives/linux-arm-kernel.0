From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Jan 2014 14:17:11 +0100
Subject: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <201401071003.31309.arnd@arndb.de>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <201401051533.58931.arnd@arndb.de> <52CA72BF.10604@free-electrons.com>
 <201401071003.31309.arnd@arndb.de>
Message-ID: <52CBFE57.5020409@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 10:03, Arnd Bergmann wrote:
> On Monday 06 January 2014, Gregory CLEMENT wrote:
>>> Relying on the soc id patch for a "stable" bug fix seems a little
>>> far-reaching to me. I would be happier to first try to do a local
>>> detection based on the i2c bus device node itself. Do you know how
>>
>> It was my first proposal in case adding the soc id detection was
>> a too big things. But it turned out that the amount of code is very
>> low so I really think it worth adding it along the fix. Device tree
>> is supposed to be stable so as soon as we add something in it we are
>> supposed support it forever. Moreover using device tree for something
>> we can probe is counter productive.
> 
> I would still be happier if we did both and only need to check the
> SoC version if the device is in the "possibly broken" category
> but default to the existing behavior.
> 
> My main concern is that this patch is adding platform code that we'd
> otherwise have to carry in the kernel indefinitely. I agree that
> it's best if we can probe stuff automatically, but that doesn't normally
> mean looking at an unrelated piece of information. If the i2c controller
> registers themselves tell us whether this device is broken or not,
> we should use that information. Looking at a global SoC version register
> however is more like checking a board ID in the pre-DT days where the
> board number is the only information we have and everything is
> derived from that.

Well the way the hardware is designed is exactly like this: between
two revision of a SoC you can have slightly differences between various
IP and most of the time this IP don't have a specific register for it.
Moreover from my experience a change done in a IP of a given revision
of a SoC will be for this revision and not necessary reported in future
generation of a SoC. Most of the time the IP are not really under a VCS.
That means that the SoC ID is the only reliable information to know
the version of most of the IP inside this SoC.

> 
>>> common the A0 revision is? You mention "early release of the
>>> OpenBlocks AX3-4 boards". Any others that you suspect? If not,
>>
>> No, from the info I gathered I expected that only OpenBlocks AX3-4
>> would be the only product shipped with an A0 version and as I said
>> it should be only a limit amount of them.
> 
> Ok, good. So we really only need to worry about this one board for
> now and can make all the others default to normal operation without
> checking the SoC version.
> 
> Another idea: Could we have a quirk in the mvebu platform code for
> the AX3-4 to check the SoC version and then change the property for
> the i2c controller based on whether we expect it to work or not?
> This way, we wouldn't even need an interface between the platform
> code and the driver code.

I can try this last approach: using the device tree to pass platform
parameter from the arch part to the driver.

> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
