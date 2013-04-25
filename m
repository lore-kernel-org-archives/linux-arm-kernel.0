From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Apr 2013 08:45:03 +0200
Subject: [PATCH] cpuidle: add maintainer entry
In-Reply-To: <51781B48.30208@gmail.com>
References: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
 <51781B48.30208@gmail.com>
Message-ID: <5178D0EF.3090004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2013 07:50 PM, Rob Herring wrote:
> On 04/24/2013 08:34 AM, Daniel Lezcano wrote:
>> Currently the cpuidle drivers are spread across the different archs.
>>
>> The patch submission for cpuidle are following different path: the cpuidle core
>> code goes to linux-pm, the ARM drivers goes to arm-soc or the SoC specific
>> tree, sh goes through sh arch tree, pseries goes through PowerPC and
>> finally intel goes through Len's tree while acpi_idle goes under linux-pm.
>>
>> That makes difficult to consolidate the code and to propagate modifications
>> from the cpuidle core to the different drivers.
>>
>> Hopefully, a movement has initiated to put the cpuidle drivers into the
>> drivers/cpuidle directory like cpuidle-calxeda.c and cpuidle-kirkwood.c
>>
>> Add an explicit maintainer entry in the MAINTAINER to clarify the situation
>> and prevent new cpuidle drivers to goes to an arch directory.
>>
>> The upstreaming process is unchanged: Rafael takes the patches to merge them
>> into its tree but with the acked-by from the driver's maintainer. So the header
>> must contains the name of the maintainer.
> 
> Shouldn't MAINTAINERS contain the driver maintainers too?

It should contains the upstream maintainer for the subsystem, and
optionally a co-maintainer.

The MAINTAINERS file gives informations about the patch submission path.

The file's header should contain the maintainer of the driver, so the
submitted patches will go to the subsystem maintainer for upstreaming
and to the driver maintainer for acked-by.

If you add an entry in MAINTAINERS like:

ARM/CALXEDA HIGHBANK ARCHITECTURE
M:      Rob Herring <rob.herring@calxeda.com>
L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
S:      Maintained
F:      arch/arm/mach-highbank/
+F:	drivers/cpuidle/cpuidle-calxeda.c

That will add confusion while we are trying to clarify the situation
with a single entry point for the patches submission. If someone wants
to submit a patch for this driver, it will look at the MAINTAINERS file
and won't know if it should send the patch against arm-soc or linux-pm.

At some exceptions, this is how is organized the different drivers, for
cpufreq, clocksource, ...

>> This organization will be the same than cpufreq.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  MAINTAINERS                        |    7 +++++++
>>  drivers/cpuidle/cpuidle-calxeda.c  |    4 +++-
>>  drivers/cpuidle/cpuidle-kirkwood.c |    5 +++--
>>  3 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 61677c3..effa0f3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2206,6 +2206,13 @@ S:	Maintained
>>  F:	drivers/cpufreq/
>>  F:	include/linux/cpufreq.h
>>  
>> +CPUIDLE DRIVERS
>> +M:	Rafael J. Wysocki <rjw@sisk.pl>
>> +L:	linux-pm at vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/cpuidle/*
>> +F:	include/linux/cpuidle.h
>> +
>>  CPU FREQUENCY DRIVERS - ARM BIG LITTLE
>>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>>  M:	Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
>> index e344b56..2378c39 100644
>> --- a/drivers/cpuidle/cpuidle-calxeda.c
>> +++ b/drivers/cpuidle/cpuidle-calxeda.c
>> @@ -1,7 +1,6 @@
>>  /*
>>   * Copyright 2012 Calxeda, Inc.
>>   *
>> - * Based on arch/arm/plat-mxc/cpuidle.c:
> 
> This file may have moved, but it existed at the time this was committed.
> So the comment still applies and documents what part of the file the FSL
> and Linaro copyright applies to.

Ok. As this file moved to arch/arm/mach-imx and changed a lot, may be we
can add the tag #v3.7 in the comment...

> Of course most of what was copied here was the boilerplate which your
> patch series removes. The heart of the functionality was developed by me.
> 
>>   * Copyright 2012 Freescale Semiconductor, Inc.
>>   * Copyright 2012 Linaro Ltd.
>>   *
>> @@ -16,6 +15,9 @@
>>   *
>>   * You should have received a copy of the GNU General Public License along with
>>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + *
>> + * Author    : Rob Herring <rob.herring@calxeda.com>
>> + * Maintainer: Rob Herring <rob.herring@calxeda.com>
> 
> As mentioned above, this doesn't seem right.

It is based on Robert Lee's cpuidle driver for imx, but you wrote this
driver, no ?

If I refer to commit be6a98d3f00c292d347465d96acbec9d8c2783cf, you are
author of this driver. Suffice to say the driver was initially based on
imx, which is the case in the top of the header.

I suggest to keep the Author and the Maintainer because if, in the
future, you don't want to maintain anymore the driver and someone wants
to know the initial author of the driver for any reasons, he can check
that in the file header without archaeological digs in the git history.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
