From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jan 2014 16:03:30 +0100
Subject: [PATCH V2 5/6] power: reset: change xgene reboot driver to use
 both acpi and dts resource for reboot.
In-Reply-To: <CAL85gmB4erJ8C=YYysXuLaY9Tkr79Z=7pAgrv0JuSU+bkxwaxg@mail.gmail.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <201401082243.01694.arnd@arndb.de>
 <CAL85gmB4erJ8C=YYysXuLaY9Tkr79Z=7pAgrv0JuSU+bkxwaxg@mail.gmail.com>
Message-ID: <201401131603.31205.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, Feng Kan wrote:
> On Wed, Jan 8, 2014 at 1:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 07 January 2014, Feng Kan wrote:
> >> Enable the X-Gene reboot driver to use either the ACPI or the DTS
> >> resource using the platform driver method.
> >>
> >> Signed-off-by: Feng Kan <fkan@apm.com>
> >> ---
> >>  drivers/power/reset/xgene-reboot.c |   33 ++++++++++++++++++++++++++++-----
> >>  1 files changed, 28 insertions(+), 5 deletions(-)
> >>
> >
> > Shouldn't an ACPI based system always be able to reboot through the
> > UEFI reset_system call? I really don't think we want to support
> > ACPI on non-UEFI systems.
> >
> >         Arnd
> Thanks Arnd, I will retract the ACPI support for now. We are still
> trying to figure out how best to support ACPI.

Ok, that makes sense.

> The larger problem seems to be the fact that
> UEFI and ACPI were originally made for x86 and is ill suited for the
> arm64. I will see if I can find a better path for this patch.

I would strongly recommend to implement the standard UEFI reset
mechanism on arm64-linux and then ensure your firmware provides
the appropriate methods.

Note that any proper arm64 system that you want a standard Linux
distro to run on will likely need to implement UEFI anyway.

Regarding ACPI, I'm well aware of the problems you are facing, but
they have less to do with the intruction set (x86 vs arm64) and much
more with the lack of a standard hardware platform. There is work
underway to support a standardized subset of arm64 servers with ACPI,
but X-Gene is rather unlikely to fit into that subset because of how
it's just a collection of homegrown hardware blocks that are attached
in seemingly random ways without a clear structure and certainly
not following any standard.

This is not unusual for ARM SoCs, and we can have learned to
deal with it, but as we have no intention of supporting multiple
incompatible ACPI implementations in Linux, you should not spend
too much time thinking about ACPI on your platform.

	Arnd
