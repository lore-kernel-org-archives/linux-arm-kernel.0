From: per.fransson.ml@gmail.com (Per Fransson)
Date: Mon, 29 Nov 2010 13:46:26 +0100
Subject: [PATCH v2] Add call to non-crashing cores through IPI
In-Reply-To: <20101126040612.GA6598@lixom.net>
References: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101126040612.GA6598@lixom.net>
Message-ID: <AANLkTinF0Ndb9-3z1ZeMBjPRH5jXWNA+BL6QpS+--0A4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> ?void machine_crash_shutdown(struct pt_regs *regs)
>> ?{
>> + ? ? unsigned long msecs;
>
> Int should be enough here? Not that it makes a difference on ARM, but
> anyway. :)
>
>> +
>> ? ? ? local_irq_disable();
>> +
>> + ? ? atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
>> + ? ? smp_call_function(machine_crash_nonpanic_core, NULL, false);
>> + ? ? msecs = 1000; /* Wait at most a second for the other cpus to stop */
>> + ? ? while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
>> + ? ? ? ? ? ? mdelay(1);
>> + ? ? ? ? ? ? msecs--;
>> + ? ? }

The choice of type comes from the corresponding x86 code in

    arch/x86/kernel/reboot.c:nmi_shootdown_cpus()

Should we deviate?

Regards,
Per
