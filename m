From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 20 Oct 2009 07:12:43 -0700
Subject: [PATCH 38/46] davinci: fix compilation error when using
	mach/system.h
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDF23F9F@dbde02.ent.ti.com>
	(Sekhar Nori's message of "Tue\, 20 Oct 2009 18\:29\:58 +0530")
References: <1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
	<20091019141346.GD13614@n2100.arm.linux.org.uk>
	<87my3ns07s.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDF23F9F@dbde02.ent.ti.com>
Message-ID: <871vkyqhlw.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Nori, Sekhar" <nsekhar@ti.com> writes:

> On Tue, Oct 20, 2009 at 00:03:11, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>>
>> > On Fri, Oct 16, 2009 at 12:09:42PM -0700, Kevin Hilman wrote:
>> >> From: Sekhar Nori <nsekhar@ti.com>
>> >>
>> >> include/mach/system.h uses the cpu_do_idle() function which is
>> >> defined in asm/proc-fns.h. Without this patch including system.h
>> >> leads to error of the sort:
>> >>
>> >> error: implicit declaration of function 'cpu_do_idle'
>> >
>> > The right answer might actually be to ensure that arch/arm/kernel/process.c
>> > includes this file, so that all mach/system.h files don't have to.
>>
>> Maybe it should be more explicit, but at least on 2.6.32, process.c
>> already triggers an include of <asm/proc-fns.h> (linux/mm.h ->
>> asm/pgtable.h -> asm/proc-fns.h.
>>
>> IIRC, the problem was not with arch/arm/kernel/process.c other
>> mach-davinci files using <mach/system.h> for some reason.
>>
>> After Sergei's major #include cleanup for mach-davinci/*, I don't
>> think this is actually necessary anymore.
>>
>> Sekhar, I'll drop this patch from davinci-next unless you think this
>> is still necessary for some reason.
>
> Kevin, I made this patch because I started using arch_idle() for entering
> WFI mode in the da850 cpuidle driver.
>
> The Marvell Kirkwood cpuidle driver uses a call to cpu_do_idle() directly,
> but calling arch_idle sounded more appropriate to me in case the arch
> needs to do something special for entering idle (though not actually the
> case with da850).

For now, I think we should stick to calling cpu_do_idle() directly.

Kevin
