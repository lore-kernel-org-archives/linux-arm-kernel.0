From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 Feb 2017 19:06:04 +0100
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
In-Reply-To: <20170221172012.GD8605@leverpostej>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd> <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
 <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com>
 <20170221172012.GD8605@leverpostej>
Message-ID: <CAMuHMdX_pot+=rJfY1Kor4gYD4CgBYivngzCLwV36LELx+AA5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Feb 21, 2017 at 6:20 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Feb 21, 2017 at 05:32:50PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Feb 21, 2017 at 12:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> > On 21/02/17 11:07, Pavel Machek wrote:
>> >>> Enable support for "shallow" suspend mode, also known as "Standby" or
>> >>> "Power-On Suspend".
>> >>>
>> >>> As secondary CPU cores are taken offline, "shallow" suspend mode saves
>> >>> slightly more power than "s2idle", but less than "deep" suspend mode.
>> >>> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
>> >>> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
>> >>> an optional API in PSCI v1.0.
>> >>
>> >> If system supports "shallow" suspend, why does not PSCI implement it?
>> >
>> > Yes it can, and IIUC it already does on this platform with CPU_SUSPEND.
>> > All it now needs is just to use existing "freeze" suspend mode in Linux.
>>
>> How can Linux know if using "deep" suspend will allow to wake-up the system
>> according to configured wake-up sources, or not?
>
> My understanding is that if a device can wake the system from
> PSCI_SYSTEM_SUSPEND, it should be described in the DT as a wakeup source
> [1]. So we should be able to determine the set of devices which can wake
> the system from a suspend. We shouldn't assume that other devices can
> (though I don't precisely what we do currently).
>
> Otherwise, where PSCI_CPU_SUSPEND, we'd expect that most devices
> (barring cpu-local timers) can wake up CPUs, and hence the system, by
> raising an interrupt.

> [1] Documentation/devicetree/bindings/power/wakeup-source.txt

"wakeup-source" in DT is used as a mix of hardware description and software
policy.  E.g. some keys on a keyboard may have it, others don't, while there's
not always a technical reason for that.

Also, it doesn't specify from which suspend state it can wake-up.

On top of that, the Linux PM subsystem allows to configure wakeup by writing
"enabled" to a device's "wakeup" file in sysfs.  Or you can use ethtool for
Wake-on-LAN.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
