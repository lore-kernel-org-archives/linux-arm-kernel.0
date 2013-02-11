From: lenb@kernel.org (Len Brown)
Date: Mon, 11 Feb 2013 17:42:55 -0500
Subject: [PATCH 06/16] ARM idle: delete pm_idle
In-Reply-To: <20130211161125.GM17833@n2100.arm.linux.org.uk>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
 <9838a4aeee256adeaef90efe56df2c9988206982.1360475150.git.len.brown@intel.com>
 <20130211160229.GB5676@MacBook-Pro.local>
 <20130211161125.GM17833@n2100.arm.linux.org.uk>
Message-ID: <511973EF.8080007@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 11:11 AM, Russell King - ARM Linux wrote:
> On Mon, Feb 11, 2013 at 04:02:30PM +0000, Catalin Marinas wrote:
>> On Sun, Feb 10, 2013 at 05:58:13AM +0000, Len Brown wrote:
>>> pm_idle() on ARM was a synonym for default_idle(),
>>> so simply invoke default_idle() directly.
>>
>> The clean-up looks fine as we already have an arm_pm_idle but longer
>> term I was thinking about having a common declaration similar to
>> pm_power_off that code under drivers/power/(reset/) can override (and
>> such driver may be shared by multiple architectures). OTOH, if you get
>> rid of the generic linux/pm.h declaration architectures can use a common
>> pm_idle name and type (though I think having it in the common header
>> would be better). For ARM this would mean s/arm_pm_idle/pm_idle/ on top
>> if your patch.
> 
> pm_idle() was that common declaration - but it had the side effect that
> it was defined to be called with interrupts disabled, but return with
> interrupts enabled.

Yeah, I expect that grew out of the x86 idiom "STI;HLT",
which dictated default_idle(), which in-turn dictated pm_idle().
x86's MWAIT instruction now has more flexibility WRT interrupts,
but the cast was already set...

Please let me know if you Ack the patch as is,
or would like it changed.

thanks,
-Len Brown, Intel Open Source Technology Center

> arm_pm_idle() "fixed" that weirdness such that it's now expected to
> return with IRQs in the same state that it was called.
> 
> pm_power_off() is a cross-arch hook already.
> 
