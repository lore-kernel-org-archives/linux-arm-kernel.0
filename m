From: s-anna@ti.com (Suman Anna)
Date: Tue, 9 Sep 2014 14:59:53 -0500
Subject: [PATCH v4 10/11] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <CAK=WgbYwGcSCxHfa880up1qKTroS=mi8UAf_Qh6Wz9n5x4D9rw@mail.gmail.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-11-git-send-email-d-gerlach@ti.com>
 <7h7g1dlp8b.fsf@linaro.org>
 <CAK=WgbYwGcSCxHfa880up1qKTroS=mi8UAf_Qh6Wz9n5x4D9rw@mail.gmail.com>
Message-ID: <540F5C39.7040201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On 09/09/2014 05:31 AM, Ohad Ben-Cohen wrote:
> On Tue, Sep 9, 2014 at 1:30 AM, Kevin Hilman <khilman@linaro.org> wrote:
>> To me, it's not terribly clear how you made the split between this PM
>> core code an the remoteproc code.  In the changelog for the remoteproc
>> patch, it states it's to "load the firmware for and boot the wkup_m3".
>> But, while parts of the IPC are here in pm33xx.c, parts of the IPC are
>> also inside the remoteproc driver, so I'm quite curious if that's OK
>> with the remoteproc maintainers.  Either way, please make it clearer how
>> and why you made the split, and please isolate the wkup_m3 IPC/protocol
>> from this code.  Think of people wanting to rework/extend the wkup_m3
>> firmware.  They shouldn't be messing around in here, but rather inside a
>> driver specificaly for the wkup_m3.
> 
> I haven't looked at the code very thoroughly yet, but generally a
> remoteproc driver should only implement the three start/stop/kick
> rproc_ops, and then register them via the remoteproc framework.
> Exposing additional API directly from that driver isn't something we
> immediately want to accept.
> 
> If relevant, we would generally prefer to extend remoteproc instead,
> so other platform-specific drivers could utilize that functionality as
> well. Or rpmsg - if we're missing some IPC functionality.

The WkupM3 cannot access DDR, and so we don't intend to use rpmsg. The
IPC with wkup_m3 is usually one of the last steps for putting the SoC
into a desired low-power state either during suspend or cpuidle, and the
communication uses a bank of fixed registers. The .kick is specific
to virtio-based communication, and so this is not gonna be used.

If you can take a closer look at the wkup_m3 remoteproc driver and give
your comments, then we can plan on the next steps. Especially as there
are also pieces pertaining to the PM layer knowing the WkupM3 has been
loaded and booted. There are already some pending comments on code
fragments from Santosh and myself, but let us know your inputs on the
integration aspects on PM, remoteproc and IPC with WkupM3.

regards
Suman
