From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 Sep 2013 17:50:23 +0100
Subject: [PATCH 3/3] KVM: ARM: Add support for Cortex-A7
In-Reply-To: <20130926161743.GD1389@cbox>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
 <1380210568-23175-4-git-send-email-jonathan.austin@arm.com>
 <20130926161743.GD1389@cbox>
Message-ID: <524465CF.4020401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/09/13 17:17, Christoffer Dall wrote:
> On Thu, Sep 26, 2013 at 04:49:28PM +0100, Jonathan Austin wrote:
>> This patch adds support for running Cortex-A7 guests on Cortex-A7 hosts.
>>
>> As Cortex-A7 is architecturally compatible with A15, this patch is largely just
>> generalising existing code. Areas where 'implementation defined' behaviour
>> is identical for A7 and A15 is moved to allow it to be used by both cores.
>>
>> The check to ensure that coprocessor register tables are sorted correctly is
>> also moved in to 'common' code to avoid each new cpu doing its own check
>> (and possibly forgetting to do so!)
>>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> The patch itself looks good, I'm wondering if we are creating potential
> confusion by not having a separate table for shared, but implementation
> defined, co-processors.  One option would be to have multiple levels of
> 'inheritance' of the the coprocessor table, so you could load the
> generic one, overload it with the a15 one, and then overload it with the
> a7 one.  That may be a bit over-engineerd though.

So my take on this is that it is OK to have default implementation
defined at the generic level, as long as the handling is "benign
enough". The core-specific code can always override it with something
more fun.

> Then again, if A7/A15 end up being just two cores out of many many more,
> it's a bit weird to have their register definitions in the coproc.c
> files and everyone elses in their own files, sort of pushing the problem
> under the rug.
> 
> Unless of course we just agree that there are probably not going to be
> that many cores and they're all just going to look a lot like each other
> wrt. to the impdef registers anyhow, so it makes sense to provide this
> default implementation...

There will probably be some Cortex-A12 code at one point, but I cannot
foresee massive changes, as it is supposed to be fairly similar to both
A7 and A15.

> If nobody else objects, I'm ok with merging this code (once I have a
> chance to test it).  We can always add more logic and move things around
> later, as there's no api breakage or anything like that.

Sounds good to me.

	M.
-- 
Jazz is not dead. It just smells funny...
