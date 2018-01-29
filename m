From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 29 Jan 2018 16:35:35 +0000
Subject: [PATCH 01/16] arm64: capabilities: Update prototype for enable
 call back
In-Reply-To: <51abe4ec-5c4f-aa7e-c045-59057e2fd2f6@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-2-suzuki.poulose@arm.com>
 <20180123145204.GR22781@e103592.cambridge.arm.com>
 <5d32970c-ef6b-791b-4140-0e7de37364c8@arm.com>
 <20180125153611.GI5862@e103592.cambridge.arm.com>
 <51abe4ec-5c4f-aa7e-c045-59057e2fd2f6@arm.com>
Message-ID: <20180129163532.GY5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 04:57:22PM +0000, Suzuki K Poulose wrote:
> On 25/01/18 15:36, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 03:38:37PM +0000, Suzuki K Poulose wrote:
> >>On 23/01/18 14:52, Dave Martin wrote:
> >>>On Tue, Jan 23, 2018 at 12:27:54PM +0000, Suzuki K Poulose wrote:
> >>>>From: Dave Martin <dave.martin@arm.com>
> >>>>
> >>>>We issue the enable() call back for all CPU hwcaps capabilities
> >>>>available on the system, on all the CPUs. So far we have ignored
> >>>>the argument passed to the call back, which had a prototype to
> >>>>accept a "void *" for use with on_each_cpu() and later with
> >>>>stop_machine(). However, with commit 0a0d111d40fd1
> >>>>("arm64: cpufeature: Pass capability structure to ->enable callback"),
> >>>>there are some users of the argument who wants the matching capability
> >>>>struct pointer where there are multiple matching criteria for a single
> >>>>capability. Update the prototype for enable to accept a const pointer.

[...]

> >>>>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >>>>index ac67cfc2585a..cefbd685292c 100644
> >>>>--- a/arch/arm64/include/asm/cpufeature.h
> >>>>+++ b/arch/arm64/include/asm/cpufeature.h
> >>>>@@ -97,7 +97,8 @@ struct arm64_cpu_capabilities {
> >>>>  	u16 capability;
> >>>>  	int def_scope;			/* default scope */
> >>>>  	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
> >>>>-	int (*enable)(void *);		/* Called on all active CPUs */

[...]

> >>/*
> >>  * Called on all active CPUs if the capability associated with
> >>  * this entry is set.
> >>  */
> >
> >Maybe, but now we have the new concept of "setting" a capability.
> >
> >Really, this is enabling the capability for a CPU, not globally, so
> >maybe it could be renamed to "cpu_enable".
> >
> >Could we describe the method in terms of what it is required to do,
> >as well as the circumstances of the call, e.g.:
> >
> >/*
> >  * Take the appropriate actions to enable this capability for this cpu.
> >  * Every time a cpu is booted, this method is called under stop_machine()
> >  * for each globally enabled capability.
> >  */
> 
> Make sense, except for the "stop_machine" part. It is called under stop_machine
> for all CPUs brought up by kernel, for capabilities which are enabled from
> setup_cpu_features(), i.e, after all the CPUs are booted. But, it is called
> directly on the CPU, if the CPU is booted after it has been enabled on CPUs
> in the system. (e.g, a CPU brought up by the user - via __verify_local_cpu_caps -,
> or a capability that is enabled early by boot CPU - will post the changes in the next
> revision).

Fair enough.  Saying "this cpu" is probably sufficient to hint that
preemption will be disabled etc.

> >(I'm hoping that "globally enabled" is meaningful wording, though
> >perhaps not.)
> 
> Hmm.. "globally enabled" kind of sounds recursive for describing "enable" :-).
> How about "globally accepted" or "globally detected" ?

"Detected" is probably better, since this terminology at least exists
today in the code (if not very much).

Alternatively, the "enable" method could be renamed to something that
doesn't contain the word "enable" at all, like "cpu_setup" or similar.
That might avoid ambiguity about what is meant by "enable".  This has
no functional value though, and it's probably not worth the churn.

> >Also, what does the return value of this method mean?
> 
> Thats a good point. We ignore it. I believe it is best to leave it to the method
> to decide, what to do about it if there is a failure. It was there just to make
> sure we comply with what stop_machine expected. Now that we don't pass it to
> stop_machine directly, we could change it to void.
> >Previously, the return value was ignored, but other patches in this
> >series might change that.

If we don't change it to void, it would be good to have a comment saying
that it is ignored for now, and method implementations should return 0
for now.

Cheers
---Dave
