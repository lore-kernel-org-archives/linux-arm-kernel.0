From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 3 Nov 2017 10:08:07 +0000
Subject: [PATCH 11/17] coresight etr: Handle driver mode specific ETR
 buffers
In-Reply-To: <20171102202658.GD23320@xps15>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-12-suzuki.poulose@arm.com>
 <20171102202658.GD23320@xps15>
Message-ID: <c0a55562-77f5-35cb-6db9-4452ebef34f2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/17 20:26, Mathieu Poirier wrote:
> On Thu, Oct 19, 2017 at 06:15:47PM +0100, Suzuki K Poulose wrote:
>> Since the ETR could be driven either by SYSFS or by perf, it
>> becomes complicated how we deal with the buffers used for each
>> of these modes. The ETR driver cannot simply free the current
>> attached buffer without knowing the provider (i.e, sysfs vs perf).
>>
>> To solve this issue, we provide:
>> 1) the driver-mode specific etr buffer to be retained in the drvdata
>> 2) the etr_buf for a session should be passed on when enabling the
>>     hardware, which will be stored in drvdata->etr_buf. This will be
>>     replaced (not free'd) as soon as the hardware is disabled, after
>>     necessary sync operation.
> 
> If I get you right the problem you're trying to solve is what to do with a sysFS
> buffer that hasn't been read (and freed) when a perf session is requested.  In
> my opinion it should simply be freed.  Indeed the user probably doesn't care
> much about that sysFS buffer, if it did the data would have been harvested.

Not only that. If we simply use the drvdata->etr_buf, we cannot track the mode
which uses it. If we keep the etr_buf around, how do the new mode user decide
how to free the existing one ? (e.g, the perf etr_buf could be associated with
other perf data structures). This change would allow us to leave the handling
of the etr_buf to its respective modes.

And whether to keep the sysfs etr_buf around is a separate decision from the
above.


Cheers
Suzuki
