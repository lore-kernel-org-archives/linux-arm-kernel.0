From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Feb 2017 18:18:49 +0000
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
In-Reply-To: <CAMuHMdX_pot+=rJfY1Kor4gYD4CgBYivngzCLwV36LELx+AA5Q@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd>
 <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
 <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com>
 <20170221172012.GD8605@leverpostej>
 <CAMuHMdX_pot+=rJfY1Kor4gYD4CgBYivngzCLwV36LELx+AA5Q@mail.gmail.com>
Message-ID: <20170221181849.GG8605@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 21, 2017 at 07:06:04PM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 21, 2017 at 6:20 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Feb 21, 2017 at 05:32:50PM +0100, Geert Uytterhoeven wrote:

> >> How can Linux know if using "deep" suspend will allow to wake-up the system
> >> according to configured wake-up sources, or not?
> >
> > My understanding is that if a device can wake the system from
> > PSCI_SYSTEM_SUSPEND, it should be described in the DT as a wakeup source
> > [1]. So we should be able to determine the set of devices which can wake
> > the system from a suspend. We shouldn't assume that other devices can
> > (though I don't precisely what we do currently).
> >
> > Otherwise, where PSCI_CPU_SUSPEND, we'd expect that most devices
> > (barring cpu-local timers) can wake up CPUs, and hence the system, by
> > raising an interrupt.
> 
> > [1] Documentation/devicetree/bindings/power/wakeup-source.txt
> 
> "wakeup-source" in DT is used as a mix of hardware description and software
> policy.  E.g. some keys on a keyboard may have it, others don't, while there's
> not always a technical reason for that.
> 
> Also, it doesn't specify from which suspend state it can wake-up.

Joy.

If we need to do something here, we should clarify the semantics of
wakeup-source and/or introduce a property which is explicitly for the
purpose of expressing HW capability to wake up from a specific power
state.

> On top of that, the Linux PM subsystem allows to configure wakeup by writing
> "enabled" to a device's "wakeup" file in sysfs.  Or you can use ethtool for
> Wake-on-LAN.

Sure; userspace can always do something silly here.

As I mentioned in my other reply, we could/should add an interface to
allow userspace to determine if it has a guaranteed wakeup, which would
allow us to do the right thing.

Thanks,
Mark.
