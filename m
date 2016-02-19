From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 16:06:40 +0100
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <HK2PR06MB05613CF6C996BF8BD459842E8AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <2413859.DaWDFlIaaB@wuerfel>
 <HK2PR06MB05613CF6C996BF8BD459842E8AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <3699765.F7sfuMCyKT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 14:46:36 Chris Brandt wrote:
> On 19 Feb 2016, Arnd Bergmann wrote:
> 
> > > A car with the best seat belts and airbags still won't help you
> > > if you drive it off a cliff.
> > 
> > That was my point about DEBUG_LL: We already allow picking a DEBUG_LL
> > option that immediately breaks booting on any other platform, and
> > (worse) breaks even printing any useful output about that fact.
> 
> Ya, the DEBUG_LL issue seems like it could be an endless hole of options
> all throughout the Kconfigs.
> 
> DT was supposed to allow everything to be configured at boot time, but
> it looks like we still need an early-Device-Tree for settings before DT
> is available. That would solve your DEBUG_LL and PHYS_OFFSET issue.

Not really: for DEBUG_LL, it doesn't work because DEBUG_LL is literally
meant to work from the first instruction in the kernel, so there can't
be any code to configure it. If you don't need to go that low-level,
you should use "earlycon", which can parse the DT just fine.

For PHYS_OFFSET, parsing the DT doesn't help at all because we only
need it for XIP_KERNEL (more or less at least) which cannot patch
the kernel image at boot time, so knowing that the address is wrong
also doesn't help you.

	Arnd
