From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 1 Dec 2015 17:38:54 +0000
Subject: [PATCH v2 2/6] arm64: Move kill_cpu_early to smp.c
In-Reply-To: <20151201163138.GA29045@leverpostej>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
 <1448982731-17182-3-git-send-email-suzuki.poulose@arm.com>
 <20151201152826.GA28370@leverpostej> <565DC5DB.7070905@arm.com>
 <20151201163138.GA29045@leverpostej>
Message-ID: <565DDB2E.2010308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 16:31, Mark Rutland wrote:
> For PSCI 0.2+ we can query AFFINITY_INFO to discover whether a CPU is
> whether or not it is in the firmware (i.e. whether or not it is
> potentially in the kernel), so we can certainly query this in some
> cases.
>
> We already do this in the usual hotplug-off case; see cpu_kill.

OK, good to know.

>> Correct, I didn't think about kexec. May be we could indicate the result
>> back (that we are looping in kernel) in secondary_data and that could solve
>> the synchronisation part ?
>
> I think we need to have two flags, a cpu-must-die flag in secondary
> data, and a global stuck-in-the-kernel flag.
>
> The CPU wanting to die could set its cpu-must-die flag, signal the
> completion, then cpu_die(). The CPU awaiting the completion would then
> check cpu-must-die, and if so, cpu_kill() that CPU. If not set, we had a
> successful onlining.

Correct.

>
> We need stuck-in-the-kernel flag to account for CPUs which didn't manage
> to turn the MMU on (which are either in the spin-table, or failed when
> they were individually onlined).

Did you mean to say "turn the MMU off" ?

Cheers
Suzuki
