From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 06 Nov 2012 17:06:06 -0800
Subject: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC04AE5@DBDE01.ent.ti.com>
 (Vaibhav Bedia's message of "Tue, 6 Nov 2012 10:40:09 +0000")
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
 <87txt4aqyc.fsf@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EC04AE5@DBDE01.ent.ti.com>
Message-ID: <87r4o68bnl.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> On Mon, Nov 05, 2012 at 23:10:27, Kevin Hilman wrote:

[...]

>> 
>> Also, if there are drivers for these devices, won't this interfere?
>> 
>
> Hmm, I can think of the following scenarios
>
> 1. Runtime PM adapted drivers are compiled in - We'll have to ensure that
> in their suspend callbacks they end up doing omap_hwmod_idle() via the
> runtime PM APIs. 

That already happens for all omap_devices.

> In this case the omap_hwmod_enable() followed by omap_hwmod_idle() is
> not necessary in the PM code.

Correct.

> 2. The drivers are not compiled in - In this case, the hwmod code puts
> the IPs in standby during bootup so the first suspend-resume iteration
> will pass. During resuming, the SYSC configuration for forced standby will
> be lost, 

Please clarify how the SYSC is lost in this case.

> so in the subsequent iterations these IPs won't go standby and the
> hwmod code does not touch them since they never got enabled. In this case
> we do need the sequence that is there currently.
>
> 3. For some reason the respective drivers don't idle the IPs during suspend -
> (no_idle_on_suspend flag for the hwmod in DT?). In this scenario I think
> we should abort the suspend process since we know that the suspend is not
> going to work. 

Agreed.

> Is there some other scenario that needs to be covered?

You covered the ones I was thinking of.

> How about adding some flag in hwmod code for handling this? Something
> similar to what was done for MMC [1]. I think the problem that we have
> is in some ways similar to the one addressed in [1].

Except that in the absence of drivers, no hwmod code is executed on the
suspend/resume path.

Kevin
