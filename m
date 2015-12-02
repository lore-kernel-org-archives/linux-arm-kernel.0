From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Dec 2015 21:03:44 +0000
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151202203810.GH9866@lunn.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <3059482.yN34NFeWWY@wuerfel>
 <20151202192825.GF8644@n2100.arm.linux.org.uk>
 <4984219.tZoFdLBDNB@wuerfel>
 <20151202202240.GH8644@n2100.arm.linux.org.uk>
 <20151202203810.GH9866@lunn.ch>
Message-ID: <20151202210344.GI8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 09:38:10PM +0100, Andrew Lunn wrote:
> I agree. We have multiplatform dove already, it is in mach-mvebu. Do
> we really need both mach-dove and mach-mvebu dove in one kernel?

Only to support my efforts in adding further Dove support.  As you
know, we've recently added PMU support, and I've recently sent you
patches for the remaining clocks.  Both of those are laying the
foundations for the next big piece, which is support for the GPU
on Dove.

Most of the effort that's been going on recently has been for the GPU
support has been invisible to most people, because much of that is
around hammering out the DRM API for it, and getting the thing stable.
This is a bigger project than just Dove, other SoCs also have the same
GPU family in them, even having multiple separate GPU cores.  It's
taken a lot of effort and time to hammer this out between three people
Lucas, Christian, and myself.

Some of the problems are only visible using the graphics stack which
I have: xf86-video-armada (which is 2D GPU accelerated for any of these
GPUs which support it) vs Christian's MESA (which obviously uses the 3D
GPU.)  On Dove, it's fairly simple, because the GPU core there is a
combined 2D/3D affair, but iMX6 has separate cores, so I've had to come
up with a way to synchronise between the cores (which obviously can have
an effect on the user API, and therefore must be resolved prior to the
initial submission.)

The mach-dove code is key to my involvement with this.

So, please realise that things have been _real_ busy on Dove, even though
you have not seen much from me: that'll be quite normal when most of the
effort is going on outside of something being Dove platform specific.

What Lucas and myself have been working towards since 4.2 is to get the
kernel GPU driver into a state where we can get it merged: we've had the
DRM people review it, and they've provided feedback.  It's taken a long
time to work through that feedback, which included totally ripping out
the existing locking and replacing it with a completely new locking scheme
- which is never an easy thing to do.  (Lucas had a few goes, I also had a
few goes, and eventually we ended up with something that is fairly sane but
has one very hairy place which was difficult to solve.)

Getting this sorted so I can then drop the galcore chunk of code out of
my dove tree will be a major step forwards for me, and will allow me to
eliminate the reason that I've not been willing to publish the tree in
full (because, despite galcore being a supposedly open source kernel
driver which lots of people - including companies - seem happy to
distribute, there is at least one file in it which do not carry the open
source boilerplate, but instead carry a more restrictive license, which
as far as I'm concerned makes me unable to publish this code.)

Talking about publishing... I do wonder what use that would be.  A while
back, people were asking me to publish it, and I arranged to publish as
much as I could, which included BMM, vmeta, PMU and other associated
components.  The result of that came to nothing at all, except a more
complicated git tree for me to manage which has added to my workload, and
thus slowed me down more...  in hind sight, I don't know why I bothered.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
