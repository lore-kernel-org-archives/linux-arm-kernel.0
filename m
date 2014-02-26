From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 26 Feb 2014 13:48:20 +0200
Subject: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
In-Reply-To: <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
 <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
Message-ID: <530DD484.5040703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/14 21:30, Paul Walmsley wrote:
> On Wed, 19 Feb 2014, Paul Walmsley wrote:
> 
>> On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
>>
>>> This patch adds a simple method of rounding: during the iteration, the 
>>> code keeps track of the closest rate match. If no exact match is found, 
>>> the closest is returned.
>>
>> So that's one possible rounding policy; maybe it works fine for a display 
>> interface PLL, at least for some values of "closest rate".  But another 
>> might be "only allow a selection from a set of pre-determined rates 
>> characterized by the silicon validation team".  Or another rounding 
>> function might need to select a more distant rate that minimizes jitter, 
>> EMI, or power consumption.  
> 
> Thought about this some more.  Do you only need this for the DSS PLL, or 
> do you need it for one of the core OMAP PLLs?
> 
> If the former, then how about modifying your patch to create a separate 
> round_rate function that's only used for the DSS PLL that implements the 
> behavior that you want?
> 
> That would eliminate any risk of impacting other users on the system.  And 
> would also allow this change to get into the codebase much faster, since 
> there's no need for clk API changes, etc.

The DSS internal PLLs are handled by the DSS driver, which does all
kinds of iteration to find good clocks. This patch is for a dedicated
display PLL, present on, for example, BeagleBoneBlack.

If you think that's better approach, I can take a look how it can be
done (I'm not too familiar with the clock framework). Or maybe there's a
possibility to have a flag of some kind, which allows rounded values to
be returned? That sounds like an easy addition too.

Note that the same change is needed for DT and non-DT boots. Having
separate round function would mean create a new clock "driver" (i.e.
compatibility string), wouldn't it? Adding a flag sounds easier.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/75cf370f/attachment.sig>
