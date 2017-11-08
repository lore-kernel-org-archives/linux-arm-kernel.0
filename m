From: james.morse@arm.com (James Morse)
Date: Wed, 08 Nov 2017 15:11:26 +0000
Subject: [PATCH 15/13] firmware: arm_sdei: move the frozen flag under
 the spinlock
In-Reply-To: <20171101155941.19432-1-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171101155941.19432-1-james.morse@arm.com>
Message-ID: <5A031E9E.2090809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/17 15:59, James Morse wrote:
> dpm_suspend() calls the freeze/thaw callbacks for hibernate before
> disable_non_bootcpus() takes down secondaries.
> 
> This leads to a fun race where the freeze/thaw callbacks reset the
> SDEI interface (as we may be restoring a kernel with a different
> layout due to KASLR), then the cpu-hotplug callbacks come in to
> save the current state, which has already been reset.
> 
> We solve this with a 'frozen' flag that stops the hotplug callback
> from overwriting the saved values.
> 
> This patch moves the flag under the 'events' spinlock we take
> in the hotplug callbacks, to avoid depending on cpu-hotplug's
> mechanics to ensure the callback sees the correct value.

Scratch this. All this has really done is moved the race around. Will had a much
better suggestion that makes it look like all the CPUs are down. That makes
hotplug and power-management behave the same.


Thanks,

James
