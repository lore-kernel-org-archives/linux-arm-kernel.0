From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jun 2015 23:51:57 +0100
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <5581F542.708@opensource.altera.com>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <CAMuHMdX=T3CsLTT95H_07Si6Kd8SRraBfxADpn+VtAF4GmZ=mw@mail.gmail.com>
 <CAMuHMdUQkm_9PhSdGS8j85Uodm-o0jiki=Xh4h59PBShB=rCXw@mail.gmail.com>
 <20150601105319.GQ2067@n2100.arm.linux.org.uk>
 <CAMuHMdUXCy+87-pwLiJ7ynaM1AeFq0f7R3sJ4prdE3QN09z++w@mail.gmail.com>
 <CADhT+wdJX7jMO3_rafrZMeA5ZVMaA6b2U4zkksfJcUjh41mH9A@mail.gmail.com>
 <20150617213006.GC7557@n2100.arm.linux.org.uk>
 <5581F0DD.60408@opensource.altera.com>
 <5581F542.708@opensource.altera.com>
Message-ID: <20150617225157.GD7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 05:31:30PM -0500, Dinh Nguyen wrote:
> Also, I am not seeing the error on the SoCFPGA Arria 10 platform at all.
> This Arria10 platform is running a different version of bootloader than
> the Cyclone5. Although, I also did test with the latest version of
> U-Boot on the Cyclone5.

It _shouldn't_ cause any issue, unless secondary_startup is called with
caches already enabled (which it shouldn't.)

If caches are enabled, that's incredibly dodgy even with the old code -
cache lines could be migrated to the incoming CPU which v7_invalidate_l1()
would then invalidate, resulting in the loss of data in those migrated
cache lines.

If caches are not enabled, this change should have no effect: caches
should not be searched if the C bit is clear, and we still end up
invalidating the local L1 cache later in the normal boot sequence.

(If caches are searched with the C bit clear, and the caches initialise
in an unpredictable state, the ARM ARM requires an implementation specific
routine to be executed immediately on CPU startup.  The idea is that if
this option were to be chosen, the vendor must guarantee a certain code
sequence can't be disrupted by the uninitialised state in the caches,
which, if you're searching the caches for instruction fetches, is pretty
much impossible to guarantee no matter what kind of code sequence you
specify: even the first instruction fetched from the CPU reset vector
could ultimately be sourced from the instruction cache if the i-cache
reports that it thinks it has valid data.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
