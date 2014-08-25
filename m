From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Aug 2014 16:58:54 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140825141600.GA14763@ulmo.nvidia.com>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
Message-ID: <20140825145854.GA15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 04:16:29PM +0200, Thierry Reding wrote:
> On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> > On 08/25/2014 03:39 PM, Thierry Reding wrote:
> > > On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> > >> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> > >>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> > >>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> > >>> [...]
> > >>>>> If not, perhaps the clock driver should force the clock to be
> > >>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> > >>>>
> > >>>> I'm sorry, but I'm not going to take any code that will do that in our
> > >>>> clock driver.
> > >>>>
> > >>>> I'm not going to have a huge list of ifdef depending on configuration
> > >>>> options to know which clock to enable, especially when clk_get should
> > >>>> have the consumer device as an argument.
> > >>>
> > >>> Are you saying is that you want to solve a platform-specific problem by
> > >>> pushing code into simple, generic drivers so that your platform code can
> > >>> stay "clean"?
> > >>
> > >> Are you saying that this driver would become "dirty" with such a patch?
> > > 
> > > Yes. Others have said the same and even provided alternative solutions
> > > on how to solve what's seemingly a platform-specific problem in a
> > > platform-specific way.
> > 
> > This is not platform specific, any platform with a complete clock driver
> > will suffer from the same problem (the clock driver disabling unclaimed
> > ahb gates, and thus killing the video output) if it wants to use simplefb
> > for early console support.
> 
> It is platform specific in that your platform may require certain clocks
> to remain on.

The platform doesn't. simplefb does. simplefb is the obvious consumer
for these clocks, and given the current API and abstraction we have,
it should be the one claiming the clocks too.

> The next platform may require power domains to remain on during boot
> and yet another one may rely on regulators to stay on during
> boot. By your argument simplefb will need to be taught to handle
> pretty much every type of resource that the kernel has.

And I wouldn't find anything wrong with that. We're already doing so
for any generic driver in the kernel (AHCI, EHCI comes to my mind
first, there's probably a lot of others). Why wouldn't we do as such
for this one?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/066f03bd/attachment-0001.sig>
