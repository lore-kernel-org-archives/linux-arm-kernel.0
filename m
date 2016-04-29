From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2016 23:44:07 +0100
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
In-Reply-To: <CAD=FV=WzgGFzzpeYAPrOpMS684_G=XRoSRjTegK-vre=fX=kpw@mail.gmail.com>
References: <20160429195741.GY19428@n2100.arm.linux.org.uk>
 <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
 <20160429211328.GZ19428@n2100.arm.linux.org.uk>
 <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
 <20160429212920.GA19428@n2100.arm.linux.org.uk>
 <CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
 <20160429215017.GC19428@n2100.arm.linux.org.uk>
 <CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
 <20160429221606.GE19428@n2100.arm.linux.org.uk>
 <CAD=FV=WzgGFzzpeYAPrOpMS684_G=XRoSRjTegK-vre=fX=kpw@mail.gmail.com>
Message-ID: <20160429224407.GF19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 03:22:50PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Apr 29, 2016 at 3:16 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Apr 29, 2016 at 02:56:38PM -0700, Doug Anderson wrote:
> >> Russell,
> >>
> >> On Fri, Apr 29, 2016 at 2:50 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Fri, Apr 29, 2016 at 02:39:35PM -0700, Doug Anderson wrote:
> >> > [didn't read most of your reply]
> >> >
> >> >> Really I just reposted it several times because I notice that you seem
> >> >> to ignore many points of my emails.  I was really hoping to get you to
> >> >> address this point.  I notice that you still didn't.  Either you are
> >> >> just trying to annoy me, or you don't have an answer to how my patch
> >> >> series hurts you.
> >> >
> >> > I don't see you treating Rob with the same contempt that you have
> >> > treated me in this thread, despite Rob and myself both telling you
> >> > basically the same thing.
> >>
> >> Rob wrote a nice thoughtful reply and I tried to give a nice
> >> thoughtful reply back to him.  He raised some good points and I raised
> >> some good points back to him.  I look forward to his future thoughts
> >> on the topic.
> >
> > Meanwhile, I've pointed out that you appear to be coming from a
> > misunderstanding (that's certainly clear because you believed
> > initially that grub did something it doesn't), showing that the
> > "problem" you have is no different from the majority of other
> > systems running Linux, and you treat me with contempt.
> >
> > What are you going to do to resolve this?
> 
> As I tried to indicate in earlier emails, I don't actually care how
> grub works in this case.  It was originally meant to illustrate the
> other people's workflows and mine are not the same.  If they have a
> solution that works for them, that's great.

... and so far you haven't really showed how your workflow is soo
different from that found on a typical x86 or ARM platform not using
coreboot.  Give an example of how your workflow would differ from
using u-boot.

> I want my MMC and MMCBLK device numbers to be sane and consistent to
> help me parse through dmesg and sysfs.  If it happens to also make it
> easy / possible to specify a root filesystem using "mmcblkN" that's
> great and I'll probably take advantage of that.

While I can relate to that as a desire, the idea of having a stable
device namespace is something that has been rejected by kernel
developers over quite a period of time for all sorts of devices.

> I'm very sorry if those using SATA and ATA disks don't have a way to
> get sane and consistent device number ordering.  I really am.  ...but
> just because they don't have a well defined ordering doesn't mean
> those of us using MMC should have to suffer.  ...and I don't think
> giving a sane ordering to MMC devices hurts anyone, does it?

My reply would be... why should MMC have special handling that no
other subsystem has?

Here's another example.  Plug in several USB serial adapters.  Which
USB serial /dev/ttyUSB* device corresponds to which adapter?  The
answer is... it depends on the order you plug them in, which could
well be different from the order in which they are found if the
machine reboots.  That's a very real problem.

However, the answer to this problem is not to find some way to bind
a particular /dev/ttyUSB* node to a particular USB device, but to
use the solution(s) already provided - iow, /dev/serial/by-id or
/dev/serial/by-path trees which give a stable view of these devices.

Now, while that allows the appropriate /dev/ttyUSB* device to be
found, it doesn't solve the "which ttyUSB* entry in the kernel
message log corresponds with which adapter" (which is the basis
of your point #1.)  That's not solved, and isn't purposely isn't
solved for any kernel subsystem.

Another example - I have boards here with multiple RTCs... guess
what happens with those?  Yep, same problem.  They get dynamic
/dev/rtc* assignment.

Another example - I have a board with three ethernet devices...
yep, same problem again, the order depends on the driver probe
order, and they get dynamically assigned eth* names.

The list of subsystems that have this property is large, because
it's all dependent on the device/driver probing order.

So, please answer this question: why should _only_ MMC be treated
as a special case?  Please give a _technical_ reason rather than a
_personal_ reason.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
