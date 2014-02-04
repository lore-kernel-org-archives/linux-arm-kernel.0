From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 18:18:31 +0000
Subject: [PATCH] regulator: core: Make regulator object reflect
 configured voltage
In-Reply-To: <CAJAp7OjCnJ=P9Gi20=D9gybREiSaqd1CaQ0K=9fGbCzU1gTFLw@mail.gmail.com>
References: <1391493268-3242-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20140204110531.GR22609@sirena.org.uk>
 <CAJAp7OjCnJ=P9Gi20=D9gybREiSaqd1CaQ0K=9fGbCzU1gTFLw@mail.gmail.com>
Message-ID: <20140204181831.GP22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 10:02:14AM -0800, Bjorn Andersson wrote:
> On Tue, Feb 4, 2014 at 3:05 AM, Mark Brown <broonie@kernel.org> wrote:

> > Why not do this at the time we apply the voltage?  That would seem to be
> > more robust, doing it in a separate place means that we might update one
> > bit of code and not the other or might change the execution path so that
> > one gets run and the other doesn't.

> I do share your concerns about having this logic mirrored here is
> risky, unfortunately the regulator object is created upon request from
> a consumer; so it is not available when regulator_register() calls
> set_machine_constraints().

Oh, hang on - that's what you mean by a regulator object...   I don't
think this fixes the problem you think it does.  What is the actual
problem you're trying to fix here?  The min_uV and max_uV on a consumer
struct are supposed to be the request from that consumer, they should
only be set if the consumer actually made a request for a voltage range.

> An alternative is to drop the conditional setting of
> REGULATOR_CHANGE_VOLTAGE from of_regulator.c and force the regulator
> drivers to set this flag explicitly; to avoid the difference in
> behavior depending on configuration.

Why would having each individual driver open code things help?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/9e18bf84/attachment.sig>
