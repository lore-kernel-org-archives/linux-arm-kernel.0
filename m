From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Sep 2013 15:47:13 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130831193431.GI6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831191414.GG6617@n2100.arm.linux.org.uk>
 <20130831193431.GI6617@n2100.arm.linux.org.uk>
Message-ID: <20130902144713.GR3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 08:34:31PM +0100, Russell King - ARM Linux wrote:

> Here's the warning I get - I've left the syslog stamp in these as
> evidence for how long this has been known - and I reported these to
> Mark when I found them:

> Aug 10 15:17:18 cubox kernel: WARNING: at /home/rmk/git/linux-cubox/fs/proc/generic.c:356 proc_register+0xac/0x128()
> Aug 10 15:17:18 cubox kernel: proc_dir_entry 'asound/oss' already registered

You will recall that when you reported this I told you that OSS
emulation is not really supported with ASoC and that I would expect a
large proportion of drivers to fail when used with it.  There was no
remaining interest in OSS, the use cases that did exist were all desktop
based but those all seem to have gone away too now.

To clarify what this means is that if you want to use to use the
in-kernel OSS emulation you are pretty much on your own.

> I also get a load of these:

> Aug 10 16:09:27 cubox kernel: S!PDIF1: ASoC: no backend DAIs enabled for S/PDIF1

> from time to time as there's no way to tell ASoC in a DPCM confirmation
> that although the CPU DAI has capture capability, the capture side is
> not connected to any codec.

Yup, as I've said that's an issue.  There should be no need to tell the
framework anything extra, it should be able to figure it out for itself
based on information it already has - I've suggested just going through
and looking to see if there are any DAIs that could possibly be
connected before printing the warning, only checking if the user is
actually trying to do a capture should also do the trick.

> And here's the oops:

> Aug 10 22:06:17 cubox kernel: [<c030f724>] (snd_pcm_info+0xc8/0xd8) from [<c030f768>] (snd_pcm_info_user+0x34/0x9c)
> Aug 10 22:06:17 cubox kernel: [<c030f768>] (snd_pcm_info_user+0x34/0x9c) from [<c030a67c>] (snd_pcm_control_ioctl+0x274/0x280)

> This is caused because substream->ops is NULL.  Why that's the case,
> I don't know, but I believe the PCM which is trying to be operated on
> is the one registered against the backend (by snd_pcm_new_internal).

Liam did provide you with a workaround for this one along with a
suggested proper fix.  Have you had any success in using this
workaround, or with implementing the proper fix for that matter?  I
don't recall seeing any feedback on the results but perhaps I missed it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/63141e20/attachment.sig>
