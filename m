From: dh.herrmann@gmail.com (David Herrmann)
Date: Sat, 17 Jan 2015 17:03:09 +0100
Subject: [systemd-devel] Making udev emit a signal when it is done loading
 modules
In-Reply-To: <54BA20D0.7060402@redhat.com>
References: <54BA20D0.7060402@redhat.com>
Message-ID: <CANq1E4QBcH4ZyZ-+j0chW8NAVKQvz=qinjC1kUjHaE9Vq3j0Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Sat, Jan 17, 2015 at 9:44 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Dear udev developers,
>
> We (me and some kernel devs mostly) would like to add support to
> the kernel for userspace telling the kernel that it is done with
> the *initial* loading of modules, with the purpose of cleaning up
> (disabling) unused harware resources like e.g. regulators and
> clocks.
>
> Currently the kernel does this cleanup just before it starts init
> (which may very well be init from a ramdisk). In some cases this
> is too early really, because later on a module may get loaded
> which needs this resources, these resources will then get turned
> on again by the loaded driver, and most of the time this is not
> an issue, but sometimes it is.
>
> I realize very well that there is no magic moment where udev is
> really ever done loading modules, but the case which we want to
> support only involves devices which are *already enumerated*, but
> may not yet have a driver loaded, when udev starts. We would like
> udev to emit a signal (ABI to be discussed) when it is done
> trying to load modules for everything which was already enumerated
> when it starts, iow when there are no new device events pending
> anymore when udev does its initial hotplug replay.
>
> So the question to you is would you be willing to include such
> functionality in udev ?  Note this signal would need to be emitted
> when udev from the real rootfs is done with the initial module
> loading, as the real rootfs may very well have more modules
> available then the initrd.

We spent quite some time making module loading 'on demand'. This
means, udev is by no means the only one loading modules. Furthermore,
udev might broadcast events which is reacted on by external listeners.
We cannot rely on them *not* loading modules.

A notion of "settled" would be handy in a lot of situations, but I
doubt that we can enforce it in udev.

Thanks
David
