From: per.forlin@stericsson.com (=?ISO-8859-1?Q?Per_F=F6rlin?=)
Date: Wed, 4 Jul 2012 16:19:26 +0200
Subject: [PATCH] ARM: reboot: disable nonboot CPUs
In-Reply-To: <20120704095053.GJ16319@n2100.arm.linux.org.uk>
References: <1341388262-3801-1-git-send-email-per.forlin@stericsson.com>
 <20120704095053.GJ16319@n2100.arm.linux.org.uk>
Message-ID: <4FF450EE.4040409@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2012 11:50 AM, Russell King - ARM Linux wrote:
> On Wed, Jul 04, 2012 at 09:51:02AM +0200, Per Forlin wrote:
>> Disable the nonboot CPUs to safely migrate tasks and interrupts
>> to the boot CPU. This will prevent the nonboot CPUs to
>> interfer or block the boot CPU from being able to reboot
>> the system successfully.
>>
>> This reboot issue was detected on u8500 when using ab8500 to initaite a
>> system restart. The issue happens because smp_send_stop() stops the CPUs
>> wihouth migrating all resources.
>> If not issuing smp_send_stop() u8500 reboots successfully.
>>
>> It's optional to support CONFIG_PM_SLEEP_SMP therefore smp_send_stop()
>> can't simply be replaced by disable_nonboot_cpus()
> 
> I don't understand what or why you're trying to do this, it seems to be
> unreliable to rely upon conditional sleep support to make system reboot
> to work.
> 
> Yes, we know at the moment that smp_send_stop() results in the secondary
> CPUs ending up spinning in the kernel, which is then potentially replaced
> buy whatever happens after boot, but short of creating a new per-subarch
> function, I don't see much other alternative.
> 
> Doesn't your kernel restart trigger a system hardware reset in any case?
> That's about the only reliable way to do a system restart with SMP.

Thanks for your reply,

The system doesn't reset in the case when calling smp_send_stop().
This is because the reboot mechanism has a couple of dependencies and some of them lives on CPU1.
The reboot is performed by an external chip that eventually switches of a regulator that triggers the restart.
After smp_send_stop() the mailbox communication with the external chip fails, therefore the reboot doesn't happen.
Right now I don't know in detail why this communication fails.

Here are my options
1. Run disble_nonboot_cpus() to migrate resources from CPU1 to CPU0
2. Skip calling smp_send_stop(), that works fine on my platform.
3. Make sure there are no reboot-dependencies on CPU1. Currently I lack the detail understanding of what these dependencies are.

BR
Per
