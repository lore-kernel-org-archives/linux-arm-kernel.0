From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 21 Jan 2011 08:58:06 -0800
Subject: [PATCH] drivers: mmc: msm: remove clock disable in probe
In-Reply-To: <4D38FC55.2030601@codeaurora.org>
References: <1295374473-27872-1-git-send-email-dwalker@codeaurora.org>
	<AANLkTim-=40MM=TeH1XSQ-rio1ctwcZAs4qbf9SaxmdH@mail.gmail.com>
	<4D38FC55.2030601@codeaurora.org>
Message-ID: <1295629086.19880.17.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-01-20 at 19:24 -0800, Saravana Kannan wrote:
> On 01/19/2011 02:50 AM, Vitaly Wool wrote:
> > Hi,
> >
> > On Tue, Jan 18, 2011 at 7:14 PM, Daniel Walker<dwalker@codeaurora.org>  wrote:
> >> The probe function adds the MMC host which can start accepting request
> >> immediately. There is an assumption here that no requests happen
> >> immediatly, but it's not always the case. This assumption can causes
> >> a BUG() when the clocks are disabled. The fix is to just remove the
> >> clock disable in the probe function.
> >>
> >> Signed-off-by: Daniel Walker<dwalker@codeaurora.org>
> >
> > I can add acked-by and/or tested-by if needed.
> >
> > ~Vitaly
> 
> Nack from me. The fix is incorrect. The clocks are alread refcounted in 
> the clock driver. There should be no need to "leave it on because 
> someone else might access it". Every code that needs the clock should 
> have a clk_enable/disable around it and it would all work fine.

You appear to be wrong Saravana .. The clocks are off at that point,
which means there's no need to disable them twice. If you look at the
MMC code mmc_add_host() will disable the clocks.

Daniel


-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
