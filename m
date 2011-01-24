From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 24 Jan 2011 11:40:20 -0800
Subject: [PATCH] drivers: mmc: msm: remove clock disable in probe
In-Reply-To: <1295873046.32231.54.camel@stummala-linux.in.qualcomm.com>
References: <1295374473-27872-1-git-send-email-dwalker@codeaurora.org>	
	<AANLkTim-=40MM=TeH1XSQ-rio1ctwcZAs4qbf9SaxmdH@mail.gmail.com>	
	<4D38FC55.2030601@codeaurora.org>
	<1295629086.19880.17.camel@m0nster>	
	<4D39DBA4.2040107@codeaurora.org>
	<1295873046.32231.54.camel@stummala-linux.in.qualcomm.com>
Message-ID: <4D3DD5A4.6020607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2011 04:44 AM, Sahitya Tummala wrote:
> On Fri, 2011-01-21 at 11:16 -0800, Saravana Kannan wrote:
>
>> I will look further into this if I have time, but at this point I'm
>> still skeptical whether this is the right fix. The reason I went from
>> "sure" to "skeptical" is due to the deferred clock delay code in the driver.
>
> Saravana,
>
> Let me try to make things clear regarding clocks management in this
> driver -
>
> 1. Before sending any MMC command msmsdcc_enable_clocks() will be called
> (check the function msmsdcc_request()) and at the end of that command
> disabling of clocks will be deferred by calling msmsdcc_disable_clocks()
> (check the function msmsdcc_request_end()).
>
> 2. The driver ensures that clocks are enabled/disabled only once for any
> number of calls to msmsdcc_enable_clocks/msmsdcc_disable_clocks. Thus,
> there is no harm in calling msmsdcc_disable_clocks/msmsdcc_enable_clocks
> twice.
>
> Now coming to the actual problem -
>
> During msmsdcc_probe(), clocks are enabled and at the end of probe
> clocks are disabled in the current code. But just before disabling
> clocks, there is a call to mmc_add_host(). This mmc_add_host() will
> schedule the detect work to run in another thread context. The detect
> work will send MMC commands for card detection. Thus, if clocks are
> disabled immediately after calling mmc_add_host(), then we might end up
> turning off clocks while the detect work commands are in progress.
>
> Fix to this problem ?
>
> 1. The clocks will anyways be turned off at the end of MMC commands that
> are sent by detect work.  Thus,  there is no need to disable clocks at
> the end of probe. This is exactly the fix that Daniel submitted.
>
> 2. Otherwise, we can also move disabling of clocks just before
> mmc_add_host() so that clocks are enabled and disabled in probe itself.
>> From there on, clocks will be enabled for any MMC command and disabled
> at the end of that request.
>
> I would prefer Daniel's fix because the clocks are anyway going to be
> turned on soon in mmc_add_host() and thus there will be no real
> advantage of disabling before add_host and enabling immediately for
> detect work MMC commands. Please let us know your comments.

Sahitya,

Thanks a lot for the detailed explanation. It certainly makes it easier 
to understand what's going on.

Going to the fix, the 2nd way would work without unnecessarily turning 
on/off clocks if you didn't ensure that clk_enable/clk_disable is not 
called more than once. They already maintain ref count, so there is no 
need for doing it again in your driver.

Also, having the driver do something like "if I already disabled the 
clock, then ignore this new disable request I got", _could_ mask a lot 
of incorrect behavior.

Having said that, the way the msm sdcc driver is designed today, I'm 
willing to consider Daniel's patch as acceptable first step fix. You 
might still want to look into seeing if this could be modified to take 
advantage of the ref counting done in the clock code.

Thanks,
Saravana


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
