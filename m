From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 12 Apr 2012 13:59:08 +0300
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <1333470392.66217.YahooMailClassic@web29010.mail.ird.yahoo.com>
References: <1333470392.66217.YahooMailClassic@web29010.mail.ird.yahoo.com>
Message-ID: <4F86B57C.1080506@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Sorry for a delay, I've been a bit busy with work...

On 04/03/12 19:26, Paul Parsons wrote:
> --- On Tue, 3/4/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> Hmmm....
>> If we change the GPSR and GPCR, the old levels should be
>> reserved, right?
>> Attached...
> 
> Yes, that sounds right: if resume() restores the old directions then
> it makes sense for it to restore the old levels first. Otherwise it
> encounters the same problem as suspend().
> 
> On that very subject, I notice that __mfp_config_gpio() also sets
> directions without first setting levels.

Hmmm... this is not good, but...

> 
> Problem is, it is not obvious what levels it should set.
> Perhaps it should likewise set the levels to the PGSR values, on the
> tenuous presumption that any hardware should already be in low power
> mode at the time __mfp_config_gpio() is called.
> But then again maybe not. This is more tricky.

Well, it looks like most of the cases the __mfp_config_gpio() is called
during init time and the levels are setup only later and PGSR still has
its reset values.
This leaves the direction outputs without a defined level, but having
the MFP_CFG_IN() as the default setting is the right thing and probably
assures the "safeness" of the __mfp_config_gpio().
Also, that is exactly why we should not use the MFP_CFG_OUT() directly.

I agree with you that probably the __mfp_config_gpio() function
should not touch the GPDR, but changing this has affect on all PXA2xx
boards, so I would *not* touch that until there is a real issue.

> 
> I'll give the patches a try before the end of the day.

Thanks


-- 
Regards,
Igor.
