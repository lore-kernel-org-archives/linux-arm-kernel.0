From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jun 2014 00:07:19 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <CAL_JsqK-9L6vLJSUuQDsNuHQOxahDM0uuQPtyq6XyuoBh5xDcg@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <CAL_JsqKw-C6uZBU3hccGmdofXcCcUKTV6z7Af6KwYwnZiy3HoQ@mail.gmail.com>
 <201406182122.29623@pali>
 <CAL_JsqK5j8PvYfq+tct4RMr63TWDYGfi_TA28k5m4KyG=UuNbg@mail.gmail.com>
 <20140618214752.GL32514@n2100.arm.linux.org.uk>
 <CAL_JsqK-9L6vLJSUuQDsNuHQOxahDM0uuQPtyq6XyuoBh5xDcg@mail.gmail.com>
Message-ID: <20140618230719.GM32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 05:27:16PM -0500, Rob Herring wrote:
> On Wed, Jun 18, 2014 at 4:47 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Jun 18, 2014 at 03:46:19PM -0500, Rob Herring wrote:
> >> On Wed, Jun 18, 2014 at 2:22 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> >> > Also I still did not know why DT kernel does not report Revision
> >> > number which is passed by bootloader via atags. Any idea?
> >>
> >> Probably because no one cared until now and revision info for every
> >> SOC is different. I would like to see revision info set in the DT in a
> >> standard way and remove the various SOC specific kernel
> >> implementations.
> >
> > Except... that's not what it is.  What that revision field was originally
> > invented for was the Netwinder to indicate the _platform_ revision.
> 
> Okay. DT describes the platform, so having a top-level revision in the
> DT could be similar, but...
> 
> >
> > From what I've seen, almost everyone else sets this to zero in their
> > boot loaders - it is /very/ rarely used.  However, I think OMAP (ab)uses
> > it by putting the SoC revision into it at kernel boot time.  That's
> > not what it is supposed to be used for.
> 
> it could suffer the same abuse as the ATAG.

I think the (ab)use I mentioned above has been eliminated (it was
being used for the SoC revision).  It's worth grepping for system_rev
to find where it's used now, and it's looks like it's all platform
level.

> The problem with soc-device is it is optional and at the whim of the
> platform to add. Adding it also causes the the platform devices to
> change paths because people make the soc device the bus parent.

It's got to be optional, but anyone with a SoC should be strongly
encouraged to use it, especially when converting to DT - again, this
is probably one of those numerous "missed opportunities" since the
DT conversion fundamentally changes the names of all platform
devices in that heirarchy.

I'm tempted to say that we went through that device name change,
and as far as I saw, there was not one complaint about those devices
changing names.  So, I suspect it isn't that big a deal to encourage
SoCs to make use of this.

> Sysfs
> paths to devices are not considered part of the ABI, but still this is
> a silly reason to change the path. If we want soc-device to be used,
> then it should always exist and have a default version.

So what do we do on systems which aren't a SoC?  Make up some random
information for the SoC stuff?  That's just wrong.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
