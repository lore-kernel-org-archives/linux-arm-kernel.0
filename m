From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 3 Apr 2012 17:26:32 +0100 (BST)
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <4F7B1273.6020003@compulab.co.il>
Message-ID: <1333470392.66217.YahooMailClassic@web29010.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Tue, 3/4/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Hmmm....
> If we change the GPSR and GPCR, the old levels should be
> reserved, right?
> Attached...

Yes, that sounds right: if resume() restores the old directions then
it makes sense for it to restore the old levels first. Otherwise it
encounters the same problem as suspend().

On that very subject, I notice that __mfp_config_gpio() also sets
directions without first setting levels.

Problem is, it is not obvious what levels it should set.
Perhaps it should likewise set the levels to the PGSR values, on the
tenuous presumption that any hardware should already be in low power
mode at the time __mfp_config_gpio() is called.
But then again maybe not. This is more tricky.

I'll give the patches a try before the end of the day.

Regards,
Paul
