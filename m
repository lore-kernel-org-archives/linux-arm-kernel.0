From: mgrosen@ti.com (Grosen, Mark)
Date: Mon, 27 Jun 2011 18:31:41 +0000
Subject: [RFC 5/8] remoteproc: add davinci implementation
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F29@dbde02.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-6-git-send-email-ohad@wizery.com>
	<4E035B78.3080200@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
	<4E04A9AE.3030801@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2F29@dbde02.ent.ti.com>
Message-ID: <FFF198FBBF957F4393BA834040FEFFA202EC99@DFLE35.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Nori, Sekhar
> Sent: Friday, June 24, 2011 8:44 AM
> 
> Hi Mark,

Sekhar, thanks for your feedback and ideas. Comments below.

Mark

> Since procedure to set the boot address varies across DaVinci
> platforms, you could have a callback populated in platform data
> which will be implemented differently for original DaVinci and
> DA8xx devices.

I looked at DM6467 and it's the same as OMAPL13x, except at a different
address. Rather than a callback, it could be just an address in the
platform data.

> 
> Also, all PSC accesses are better off going through clock
> framework to ensure proper locking and modularity.
> 
> To assert/de-assert local reset when enabling or disabling PSC,
> you could use a flag in the clock structure to indicate the need
> for this. This way, if there is any other module needing a local
> reset, it can just define the same flag. Similarly, if the DSP
> does not need a local reset on a particular platform, that
> platform can simply skip the flag.
> 
> This can be done in a manner similar to how the support for
> a forced transition PSC was added here:
> 
> https://patchwork.kernel.org/patch/662941/

Yes, I like this idea - much cleaner. For example, the start() method
becomes (pseudo-code):

start()
{
    /* bootaddrreg derived from platform data */
    bootaddrreg = boot_address;

    clk_enable();
}

Referring to your patch above, would it be better to just pass
the flags into the davinci_psc_config() function rather than breaking out more
arguments for each flag?

Mark
