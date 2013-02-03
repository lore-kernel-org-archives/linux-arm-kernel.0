From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 3 Feb 2013 20:44:07 +0100
Subject: [PATCH v2] rtc: rtc-mv: Add support for clk to avoid lockups
In-Reply-To: <1359891126-21909-1-git-send-email-andrew@lunn.ch>
References: <1359891126-21909-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130203194407.GA16366@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sun, Feb 03, 2013 at 12:32:06PM +0100, Andrew Lunn wrote:
> The Marvell RTC on Kirkwood makes use of the runit clock. Ensure the
> driver clk_prepare_enable() this clock, otherwise there is a danger
> the SoC will lockup when accessing RTC registers with the clock
> disabled.
> 
> Reported-by: Simon Baatz gmbnomis at gmail.com
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

And:

Tested-by: Simon Baatz <gmbnomis@gmail.com>

Btw, <...> is missing from the email address in the Reported-by line.

Thanks for providing this so quickly. Now, it looks like this
(without applying the GPIO fix, yet, because it would already enable
the runit clock):

# cat /sys/kernel/debug/clk/tclk/runit/clk_enable_count
0
# insmod ./rtc-mv.ko
# cat /sys/kernel/debug/clk/tclk/runit/clk_enable_count
1
# hwclock
Sun Feb  3 19:34:53 2013  -1.003522 seconds
# rmmod rtc-mv
# cat /sys/kernel/debug/clk/tclk/runit/clk_enable_count
0


- Simon
