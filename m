From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 May 2014 15:11:46 +0300
Subject: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
In-Reply-To: <alpine.DEB.2.02.1405072210360.23579@utopia.booyaka.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <20140424182914.GD4659@saruman.home> <20140424184457.GH22987@atomide.com>
 <20140429155111.GC633@saruman.home> <535FD2E0.1050806@ti.com>
 <alpine.DEB.2.02.1405072210360.23579@utopia.booyaka.com>
Message-ID: <5370BA82.8030703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 01:16, Paul Walmsley wrote:

>> It's true that the original patch changes the dpll behavior when an
>> exact match is not found. However, I think our drivers always request an
>> exact match, and in that case the original patch doesn't change the
>> behavior in practice.
>>
>> In theory it's possible that a driver requests a non-exact clock from
>> the dpll, and when it gets an error, it does something else.
> 
> The path that worries me at the moment is the set-rate path.  That calls 
> __clk_round_rate() (if the user hasn't called it already) and silently 
> tries to set the clock to the altered rate.

Hmm, so you mean a driver could call set_rate, and presume it only uses
exact rates the dpll can produce, and presumes that set_rate returns an
error if the dpll cannot produce the requested rate?

Isn't that what I said? If a driver has such behavior, I think it still
doesn't work, as (correct me if I'm wrong) we always have the
clk-divider after a dpll. And the clk-divider doesn't handle the error,
so neither can the driver.

Or what kind of scenario do you have in mind?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/97da8289/attachment.sig>
