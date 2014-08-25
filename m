From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Aug 2014 16:16:29 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <53FB3E7F.4000503@redhat.com>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
Message-ID: <20140825141600.GA14763@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
> On 08/25/2014 03:39 PM, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
> >> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
> >>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
> >>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
> >>> [...]
> >>>>> If not, perhaps the clock driver should force the clock to be
> >>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> >>>>
> >>>> I'm sorry, but I'm not going to take any code that will do that in our
> >>>> clock driver.
> >>>>
> >>>> I'm not going to have a huge list of ifdef depending on configuration
> >>>> options to know which clock to enable, especially when clk_get should
> >>>> have the consumer device as an argument.
> >>>
> >>> Are you saying is that you want to solve a platform-specific problem by
> >>> pushing code into simple, generic drivers so that your platform code can
> >>> stay "clean"?
> >>
> >> Are you saying that this driver would become "dirty" with such a patch?
> > 
> > Yes. Others have said the same and even provided alternative solutions
> > on how to solve what's seemingly a platform-specific problem in a
> > platform-specific way.
> 
> This is not platform specific, any platform with a complete clock driver
> will suffer from the same problem (the clock driver disabling unclaimed
> ahb gates, and thus killing the video output) if it wants to use simplefb
> for early console support.

It is platform specific in that your platform may require certain clocks
to remain on. The next platform may require power domains to remain on
during boot and yet another one may rely on regulators to stay on during
boot. By your argument simplefb will need to be taught to handle pretty
much every type of resource that the kernel has.

> As for the suggestion to simply never disable the plls / ahb gates by blocking
> them from ever being disabled in the sunxi clock driver, that is not really
> a solution either, as we want to be able to turn these things off to safe
> power on screen blank once control has been turned over to the kms driver.

Then perhaps part of the hand-off procedure between simplefb and DRM/KMS
should involve marking PLLs or "gates" as properly managed.

> And while at it let me also tackle the don't use simplefb only use kms argument,
> that means that the clocks will be turned off until the kms module loads, which
> will cause noticable screen flicker / video output resync, something which we've
> been trying to get rid of for years now.
> 
> And no, build in the kms driver is not an answer either. That works nicely for
> firmware, but not for generic Linux distributions supporting a wide range
> of boards.

Odd... I didn't offer any of those two as solutions to the problem.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/5a2fa3c4/attachment-0001.sig>
