From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jun 2014 12:09:45 +0100
Subject: MMC is *still* broken...
In-Reply-To: <53943307.5070202@redhat.com>
References: <20140605183615.GG23430@n2100.arm.linux.org.uk>
 <86oay7noer.fsf@void.printf.net>
 <CAOesGMgp+r3TTuhctqxVxW8abj467UpPwch3iN=e8rsXeF1p-A@mail.gmail.com>
 <53943307.5070202@redhat.com>
Message-ID: <20140608110945.GN23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 08, 2014 at 11:55:19AM +0200, Hans de Goede wrote:
> 4) Implementation wise I think we all agree that we want to use a platform
> device + driver. So the mmc-core would check for a subnode with reg == 0 and if
> there is one instantiate a platform device from this, using the subnode as the
> platform devices of_node, and the platform driver for the powerup will be bound
> using the compatible string of the subnode.

I really don't think so on the platform device/driver issue.  Greg keeps
saying that he wants to kill these off, so really we need to stop inventing
new use cases for them.  We're just making more work for ourselves for
when Greg decides to put a block on any further platform drivers - at that
point, we will be forced to rewrite it not to use platform drivers.

So, we need to take account of that today, and *not* use a platform device/
driver for this.

What's also disappointing is that we're close to six months on this issue,
and we still don't have a proper solution to the problem, meanwhile we have
devices out there in the wild where mainline kernels can't be used with
wifi/bt because of our lack of progress on this issue.

While it is important to get interfaces correct, we also can't sit around
being indecisive like this - because the result is we just end up driving
people away from mainline to vendor kernels.  That's exactly what has
been happening.

99% of people run Jon Nettleton's kernels on the Cubox-i because that's
the only modern kernel which supports most of the hardware... why should
anyone bother with mainline given that even 9 months down the line (it's
been 9 months since developers had the initial hardware), mainline kernels
remain mostly crippled on this hardware... anything beyond MMC or NFS boot
and basic GUI... forget it with mainline... not even the eSATA port works
with mainline kernels.

This rather makes me wonder why I'm even bothering _trying_ to get support
for this hardware into mainline - I'm probably completely wasting my time
on that.

(Note: I'm not blaming you, Hans, for this - I'm merely pointing out the
amount of time that has been collectively wasted on this topic and we
*still* seem to be no closer to any kind of solution to it.  Much of that
is because we can't decide on a reasonable DT description.  Board files
with platform data was /loads/ easier because we could come up with
solutions to these kinds of problems much faster there...)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
