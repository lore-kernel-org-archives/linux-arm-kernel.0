From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 6 Oct 2017 16:33:10 +0100
Subject: Follow-up: How to deal with weird SCPI firmware and invalid DVFS
 frequencies
In-Reply-To: <a96ffcce-7399-97c6-10be-88869c77ccef@gmail.com>
References: <a96ffcce-7399-97c6-10be-88869c77ccef@gmail.com>
Message-ID: <98d54730-9756-6c00-64ce-1ec43d8cf770@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/17 21:32, Heiner Kallweit wrote:
> Few months ago we discussed how to deal with the Amlogic Meson SCPI
> DVFS cpu frequencies. To recap:
> SCPI DVFS provides some high frequencies which are usable only if
> just one CPU core is used. Else the system will just crash
> (even w/o being thermally loaded).
>

It simply can't be solved in kernel. The SCP firmware is the only place
where you can sanely solve the issue.

IIUC this system uses PSCI for CPU ON/OFF/SUSPEND. Even if you manage to
track CPU state in Linux, you simply can't manage what's happening in
higher exceptions(EL3 in this case). Some another CPU can brought/woken
up when Linux has set highest OPP, the system will still crash.

IMO, this can't be solved just in Linux alone that's impossible because
of the races I mentioned above.It should be solved it in the firmware.
I know the standard issue there is that you can't change the firmware.
But that's not a reason to create unusable system ever after adding lots
of code to deal with that in Linux as Linux is not in full control of this.

SCP is the one bringing/waking up other cores and can workaround this
issueby dropping the OPP when it's about to bring/wakeup second core.

> See also:
> https://patchwork.kernel.org/patch/9557349/
> https://patchwork.kernel.org/patch/9555761/
> 
> One idea was to introduce a DT param for the CPU nodes to configure
> a max frequency, and all DVFS freq's above this threashold would be
> ignored. However we didn't come to an agreement.
> 

NAK for that idea for reasons given above.

> Now, when dealing with SCPI again, another idea came to my mind:
> Still it would be about introducing such a DT parameter, however
> we would not completely ignore higher frequencies but just set
> the "turbo" flag of the opp.
> This way cpufreq would ignore these frequencies, however we still
> had the option to manually enable these frequencies via sysfs and
> use them on systems where just one CPU core is used.> (or more > general: manually enable the boost frequencies if system
> macthes certain criteria)
> 
> Does this sound better or would you still consider this to be too
> hacky?
> 

Unfortunately still hacky and yet not complete solution as it just
renders unstable system. System with reduced performance is better
compared to unstable system :)

-- 
Regards,
Sudeep
