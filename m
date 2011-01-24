From: stummala@codeaurora.org (Sahitya Tummala)
Date: Mon, 24 Jan 2011 18:14:06 +0530
Subject: [PATCH] drivers: mmc: msm: remove clock disable in probe
In-Reply-To: <4D39DBA4.2040107@codeaurora.org>
References: <1295374473-27872-1-git-send-email-dwalker@codeaurora.org>
	<AANLkTim-=40MM=TeH1XSQ-rio1ctwcZAs4qbf9SaxmdH@mail.gmail.com>
	<4D38FC55.2030601@codeaurora.org> <1295629086.19880.17.camel@m0nster>
	<4D39DBA4.2040107@codeaurora.org>
Message-ID: <1295873046.32231.54.camel@stummala-linux.in.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-01-21 at 11:16 -0800, Saravana Kannan wrote:

> I will look further into this if I have time, but at this point I'm 
> still skeptical whether this is the right fix. The reason I went from 
> "sure" to "skeptical" is due to the deferred clock delay code in the driver.

Saravana,

Let me try to make things clear regarding clocks management in this
driver - 

1. Before sending any MMC command msmsdcc_enable_clocks() will be called
(check the function msmsdcc_request()) and at the end of that command
disabling of clocks will be deferred by calling msmsdcc_disable_clocks()
(check the function msmsdcc_request_end()).

2. The driver ensures that clocks are enabled/disabled only once for any
number of calls to msmsdcc_enable_clocks/msmsdcc_disable_clocks. Thus,
there is no harm in calling msmsdcc_disable_clocks/msmsdcc_enable_clocks
twice.

Now coming to the actual problem -

During msmsdcc_probe(), clocks are enabled and at the end of probe
clocks are disabled in the current code. But just before disabling
clocks, there is a call to mmc_add_host(). This mmc_add_host() will
schedule the detect work to run in another thread context. The detect
work will send MMC commands for card detection. Thus, if clocks are
disabled immediately after calling mmc_add_host(), then we might end up
turning off clocks while the detect work commands are in progress.

Fix to this problem ?

1. The clocks will anyways be turned off at the end of MMC commands that
are sent by detect work.  Thus,  there is no need to disable clocks at
the end of probe. This is exactly the fix that Daniel submitted.

2. Otherwise, we can also move disabling of clocks just before
mmc_add_host() so that clocks are enabled and disabled in probe itself.
>From there on, clocks will be enabled for any MMC command and disabled
at the end of that request.

I would prefer Daniel's fix because the clocks are anyway going to be
turned on soon in mmc_add_host() and thus there will be no real
advantage of disabling before add_host and enabling immediately for
detect work MMC commands. Please let us know your comments.

-- 
Thanks,
Sahitya.
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
