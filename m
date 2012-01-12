From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 12 Jan 2012 12:24:06 +0000
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A777@HQMAIL01.nvidia.com>
References: <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0DF1E6.40602@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A777@HQMAIL01.nvidia.com>
Message-ID: <20120112122406.GG7180@jl-vm1.vm.bytemark.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote:
> Timur Tabi wrote at Wednesday, January 11, 2012 1:33 PM:
> > Stephen Warren wrote:
> > > Well, the EDID needs to be read on every hotplug event, so it's certainly
> > > not a one-time thing.
> > 
> > What is the hotplug event that triggers an EDID read?
> 
> For monitors attached to user-accessible connectors, whenever the user
> physically plugs in a new monitor, you need to read the EDID since it
> could be a new monitor. DVI and HDMI have explicit hotplug detect lines
> to trigger this. I'm not sure how it works for VGA; perhaps you have to
> manually reprobe.

For VGA, some ports have load sensors (same with S-video, TV out).
It's good if those are exposed in the driver :)

Also if you detect DDC1 signal from an old monitor, you'll easily know
when it stops.  Many send DDC1 when nothing is received over DDC2
after a timeout (I vaguely recall 2 seconds or 120 vsyncs.)

If the VGA monitor responds on DDC2 at all (note that surprisingly
many VGA cables are missing the wires so it's not a given), you can
repeatedly probe it with a short command, not even reading anything,
just an address probe.  Or you can read a short range of bytes to
verify it's the same model and serial number.  Be careful in both
cases to prevent contact bounce from turning into an EDID write
though.

On VGA (or DVI-A sometimes) the fact they switch between DDC1 and DDC2
on detecting the I2C clock transitions is, I suspect, why some video
drivers think they need to wiggle the GPIOs first before sending the
EDID transactions.

> Of course, if this thread is talking about built-in LCD displays where
> the connectivity is fixed, this is a non-issue, but it's still a relevant
> general design discussion; hopefully whatever solution that's picked would
> work for DVI/HDMI even if you're dealing with LCDs right now.

Userspace occasionally wants to talk over DDC to DVI/HDMI as well.
Either to retrieve extended EDID, or to send/receive DDC/CI commands,
or to do its own version of the VGA monitor change detection described
above.

For all the above reasons I think the DDC/EDID support in the kernel
should be moving gently towards a (very small) DDC/EDID mini-subsystem
shared by video drivers.  I.e. it should be exposed as a well-known
I2C bus name, and if it's GPIO bit-banging I2C, that should be exposed
as well.

-- Jamie
