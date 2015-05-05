From: joel@jms.id.au (Joel Stanley)
Date: Tue, 5 May 2015 12:27:54 +0930
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <2953543.GNxjbWV8RC@wuerfel>
References: <55417F5A.4040300@linaro.org> <10771707.5UNQMOWJlc@wuerfel>
 <5546D4C0.5090105@linaro.org> <2953543.GNxjbWV8RC@wuerfel>
Message-ID: <CACPK8XfkxU+5Szn6=fdeiqCK5+yVYHZc+iaUb1eqowFQZt20LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 5, 2015 at 1:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 04 May 2015 10:09:04 Shannon Zhao wrote:
>> On 2015/4/30 17:56, Arnd Bergmann wrote:
>> > On Thursday 30 April 2015 10:29:53 Mark Rutland wrote:
>
>> > a) have an input device send the KEY_POWEROFF or KEY_REBOOT events to
>> >    user space, and have some process (e.g. desktop environment, or daemon)
>>
>> About this daemon, do we need a doc or spec to standardize it?
>
> There is probably documentation about this that we just need to locate.
> On my workstation, the power button device is owned by "systemd-logind",
> I'd assume something like that to be present elsewhere as well.
>
>> > b) Have a special driver that calls orderly_poweroff or orderly_reboot.
>> >    Only PowerPC (OPAL) uses the orderly_reboot() here, but a few platforms
>> >    (Xen, fsl_hypervisor, and some sparc and powerpc machines) as well
>> >    as some device drivers (thermal management etc) call this as well.
>> >    The effect is to call a user-configured binary (/sbin/reboot and
>> >    /sbin/poweroff by default).
>> >
>>
>> This looks good which reuses existing user space process.
>>
>
> Joel Stanly wrote that patch for PowerPC, maybe he can explain why
> this PowerPC is doing it this way instead of having an input device
> that sends KEY_RESTART. It's probably a good idea to have ARM and
> PowerPC normally do the same thing here, especially if there are
> problems with just using a gpio-key device.

We wanted to support reboot and poweroff on existing distributions
without having to rely on new userspace.

I chatted to a few people at linux.conf.au this year and we came to
the conclusion that the options were orderly_poweroff() or ACPI for
doing a graceful shutdown involving userspace. ACPI required acpid or
a desktop environment listening to the netlink message (plus we aren't
an ACPI machine) so that was out.

KEY_POWEROFF looks useful, but how would you support userspace that
does not have a systemd-logind, or anything listening to that input
event?

Cheers,

Joel
