From: zbyszek@in.waw.pl (Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?=)
Date: Sat, 17 Jan 2015 17:03:19 +0100
Subject: [systemd-devel] Making udev emit a signal when it is done
 loading modules
In-Reply-To: <54BA20D0.7060402@redhat.com>
References: <54BA20D0.7060402@redhat.com>
Message-ID: <20150117160319.GO18247@in.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 09:44:00AM +0100, Hans de Goede wrote:
> We would like
> udev to emit a signal (ABI to be discussed) when it is done
> trying to load modules for everything which was already enumerated
> when it starts, iow when there are no new device events pending
> anymore when udev does its initial hotplug replay.
I think you can just create a unit like:

# disable-new-hardware.service
[Unit]
After=systemd-udev-settle.service systemd-modules-load.service
Wants=systemd-udev-settle.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/local/bin/ping-the-kernel

> So the question to you is would you be willing to include such
> functionality in udev?
I don't think udevd has enough knowledge. But a systemd unit like
the one above should work.

Zbyszek
