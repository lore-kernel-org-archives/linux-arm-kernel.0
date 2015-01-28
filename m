From: lennart@poettering.net (Lennart Poettering)
Date: Wed, 28 Jan 2015 02:38:52 +0100
Subject: [systemd-devel] Making udev emit a signal when it is done
 loading modules
In-Reply-To: <20150117160319.GO18247@in.waw.pl>
References: <54BA20D0.7060402@redhat.com>
 <20150117160319.GO18247@in.waw.pl>
Message-ID: <20150128013852.GA8177@gardel-login>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 17.01.15 17:03, Zbigniew J?drzejewski-Szmek (zbyszek at in.waw.pl) wrote:

> On Sat, Jan 17, 2015 at 09:44:00AM +0100, Hans de Goede wrote:
> > We would like
> > udev to emit a signal (ABI to be discussed) when it is done
> > trying to load modules for everything which was already enumerated
> > when it starts, iow when there are no new device events pending
> > anymore when udev does its initial hotplug replay.
> I think you can just create a unit like:
> 
> # disable-new-hardware.service
> [Unit]
> After=systemd-udev-settle.service systemd-modules-load.service
> Wants=systemd-udev-settle.service
> 
> [Service]
> Type=oneshot
> RemainAfterExit=yes
> ExecStart=/usr/local/bin/ping-the-kernel
> 
> > So the question to you is would you be willing to include such
> > functionality in udev?
> I don't think udevd has enough knowledge. But a systemd unit like
> the one above should work.

To clarify this: if people do this, then this pulls in
systemd-udev-settle.service, which slows down boot. Every service that
does that is hence a majour source of slowness. 

It's a hack to use this, not a solution. 

Lennart

-- 
Lennart Poettering, Red Hat
