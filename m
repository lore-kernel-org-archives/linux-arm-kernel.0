From: bhutchings@solarflare.com (Ben Hutchings)
Date: Tue, 8 Jan 2013 12:52:44 +0000
Subject: [PATCH 1/1 net-next] net: fec: enable pause frame to improve rx
 prefomance for 1G network
In-Reply-To: <1357634609-4112-1-git-send-email-Frank.Li@freescale.com>
References: <1357634609-4112-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1357649564.29986.10.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-08 at 16:43 +0800, Frank Li wrote:
> The limition of imx6 internal bus cause fec can't achieve 1G perfomance.
> There will be many packages lost because FIFO over run.

How sad...

> This patch enable pause frame flow control.
[...]

You should not enable pause frames unconditionally. It will cause
compatibility problems with some switches.  It should be possible to
control their use manually or through autonegotiation (if the medium
supports that).

You should:
1. Implement the ethtool get_pauseparam and set_pauseparam operations.
If the medium supports autoneog, use mii_advertise_flowctrl() in
set_pauseparam to update pause frame advertising and then restart
autoneg.
2. Allow pause frame advertising to be changed through set_settings (I
think phylib covers this for you).
3. Program the MAC according to the the parameters set with
set_pauseparam or (if pause autoneg was enabled) the result of autoneg.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
