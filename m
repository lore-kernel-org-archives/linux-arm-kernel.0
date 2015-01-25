From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 25 Jan 2015 14:30:24 +0100
Subject: [PATCH 08/12] pm: at91: rename file name: pm_slowclock.S
 -->pm_suspend.S
In-Reply-To: <20150123231738.GB32318@piout.net>
References: <1421741825-18226-1-git-send-email-wenyou.yang@atmel.com>
 <1421741825-18226-9-git-send-email-wenyou.yang@atmel.com>
 <20150123191719.GA29601@gradator.net>
 <20150123231738.GB32318@piout.net>
Message-ID: <20150125133024.GA27125@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexandre,


On Sat, Jan 24, 2015 at 12:17:38AM +0100, Alexandre Belloni wrote:
> 
> This is a rework, what is part of linux-3.10-at91 and not yet present in
> mainline should be part of a following series. I would prefer not mixing
> reworks and "new" functionalities (they have been present in the atmel
> tree for a while but never mainlined).

I agree, I just didn't know a new series will follow, maybe I missed 
this point.

Maybe I am a bit too picky (or boring: if I am, please told me), but 
this series by itself adds regression to all users of >= 9x5 boards 
(sama5, ?) because it merges MEM target and MEM+SLOW_CLOCK target, which 
used to be too different target states, not selectable at runtime indeed 
but this is still in practice two different target states. Note that I 
am not saying that MEM target and MEM+SLOW_CLOCK target should not be 
merged, they should, absolutely ;-). For >= 9x5 boards (sama5, ?), MEM 
target works and MEM+SLOW_CLOCK target does not work, MEM and 
MEM+SLOW_CLOCK merge breaks MEM target for those boards.

There is however a good news !, at91_pm_verify_clocks() used to be 
called for MEM target without considering if it was MEM (~STANDBY) or 
MEM+SLOW_CLOCK. It means that all MEM target users can with very good 
chance go to a deeper sleep state without issue because 
at91_pm_verify_clocks() successfully checked on those boards and is why 
we can merge MEM and MEM+SLOW_CLOCK without adding a regression.

Care should be taken to pull-request at the same time both the rework 
and the above cited following series about slow clock support for all 
known boards so we don't break MEM target for a release cycle.


> I would say that PM on 9x5, n12 and sama5 in mainline is clearly not 
> well tested and is lagging behind the atmel tree.

Well, at the current mainline state, everything works fine for me except 
slow clock mode, I thoroughly checked everything else.


Sylvain
