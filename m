From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 12 Dec 2013 14:05:14 +0100
Subject: regulator-core has_full_constraints set too late for dt using
 boards ?
In-Reply-To: <20131212122347.GK11044@sirena.org.uk>
References: <52A88805.1080704@redhat.com>
 <20131211160225.GB11468@sirena.org.uk> <52A98C72.2040203@redhat.com>
 <20131212104208.GG11044@sirena.org.uk> <52A9A9DB.5050102@redhat.com>
 <20131212122347.GK11044@sirena.org.uk>
Message-ID: <52A9B48A.8040601@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/12/2013 01:23 PM, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 01:19:39PM +0100, Hans de Goede wrote:
>
>> Note my patch to not do a dev_err when no regulator is found for
>> regulator_get_optional still is needed in -next.
>
> It's sitting in my review queue, it's not very well described so it's
> not clear that you've selected the correct criteria and I need to find
> time to actually look at it properly.

I did not want to add a third boolean parameter to indicate
_regulator_get() was being called from regulator_get_optional.

Since regulator_get_optional is the only one calling
_regulator_get() with both allow_dummy and exclusive set to
false I've added the following condition to printing the
error:

	if (!(!allow_dummy && !exclusive))

Simplified to:

	if (allow_dummy || exclusive)

Which means that it will get printed in all cases it would
get printed previously, except when called from
regulator_get_optional.

Alternatively a third "optional" boolean parameter could
get added to _regulator_get() and the test for printing the
error could become:

	if (!optional)

Let me know if you would prefer doing things that way and
I'll respin the patch.

Thanks & Regards,

Hans
