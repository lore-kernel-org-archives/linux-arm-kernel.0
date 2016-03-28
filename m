From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 29 Mar 2016 00:13:55 +0200
Subject: [RFC PATCH v1 0/4] Add Rockchip RGA support
In-Reply-To: <CACvgo516ewfwGCpV=noX+re1x8t3Sp1t39Sha+A2-tQ5YsoihA@mail.gmail.com>
References: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
 <1571169.Hy8an0n7lM@diego>
 <CACvgo516ewfwGCpV=noX+re1x8t3Sp1t39Sha+A2-tQ5YsoihA@mail.gmail.com>
Message-ID: <17189219.y56YqHz6yR@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 28. M?rz 2016, 23:07:59 schrieb Emil Velikov:
> On 28 March 2016 at 22:46, Heiko St?bner <heiko@sntech.de> wrote:
> > Am Montag, 28. M?rz 2016, 22:35:36 schrieb Emil Velikov:
> >> On 28 March 2016 at 19:44, Heiko St?bner <heiko@sntech.de> wrote:
> >> > Am Montag, 28. M?rz 2016, 13:21:02 schrieb Emil Velikov:
> >> >> On 22 March 2016 at 00:42, Heiko Stuebner <heiko@sntech.de> wrote:
> >> >> > Hi Yakir,
> >> >> > 
> >> >> > Am Montag, 21. M?rz 2016, 20:17:46 schrieb Yakir Yang:
> >> >> >> On 03/21/2016 07:29 PM, Heiko St?bner wrote:
> >> >> >> > Am Montag, 21. M?rz 2016, 17:28:38 schrieb Yakir Yang:
> >> >> >> >> This patch set would add the RGA direct rendering based 2d
> >> >> >> >> graphics
> >> >> >> >> acceleration module.
> >> >> >> > 
> >> >> >> > very cool to see that.
> >> >> >> 
> >> >> >> ;)
> >> >> >> 
> >> >> >> >> This patch set is based on git repository below:
> >> >> >> >> git://people.freedesktop.org/~airlied/linux drm-next
> >> >> >> >> commit id: 568d7c764ae01f3706085ac8f0d8a8ac7e826bd7
> >> >> >> >> 
> >> >> >> >> And the RGA driver is based on Exynos G2D driver, it only
> >> >> >> >> manages
> >> >> >> >> the
> >> >> >> >> command lists received from user, so user should make the
> >> >> >> >> command
> >> >> >> >> list
> >> >> >> >> to data and registers needed by operation to use.
> >> >> >> >> 
> >> >> >> >> I have prepared an userspace demo application for testing:
> >> >> >> >>    https://github.com/yakir-Yang/libdrm-rockchip
> >> >> >> >> 
> >> >> >> >> That is a rockchip libdrm library, and I have write a simple
> >> >> >> >> test
> >> >> >> >> case
> >> >> >> >> "rockchip_rga_test" that would test the below RGA features:
> >> >> >> >> - solid
> >> >> >> >> - copy
> >> >> >> >> - rotation
> >> >> >> >> - flip
> >> >> >> >> - window clip
> >> >> >> >> - dithering
> >> >> >> > 
> >> >> >> > Did you submit your libdrm changes as well?
> >> >> >> > 
> >> >> >> > Userspace-interfaces need to be stable so the other side must
> >> >> >> > also
> >> >> >> > get
> >> >> >> > accepted - even before the kernel change if I remember correctly.
> >> >> >> 
> >> >> >> Got it, and I just saw exynos_fimg2d already landed at mainline
> >> >> >> libdrm.
> >> >> >> But I don't find the way to submit patches to libdrm, would you
> >> >> >> like
> >> >> >> share some helps here ;)
> >> >> > 
> >> >> > Looking at the libdrm sources on cgit.freedesktop.org, I did not
> >> >> > find
> >> >> > any
> >> >> > specific manual on submitting patches.
> >> >> > 
> >> >> > But looking at the dri-list archive, dri-devel at lists.freedesktop.org
> >> >> > is
> >> >> > the
> >> >> > right list and looking at the libdrm history it looks like Emil
> >> >> > Velikov
> >> >> > <emil.l.velikov@gmail.com> seems to be doing maintenance-stuff in
> >> >> > libdrm.
> >> >> > And as a 3rd recipient, please also include the linux-rockchip list.
> >> >> > 
> >> >> > @Emil, please shout if I read that wrong :-)
> >> >> 
> >> >> You got it spot on Heiko. There are a few notes though...
> >> >> 
> >> >> As one reuses the existing hardware/IP block, it would be better to
> >> >> avoid copy/pasting code around.
> >> >> 
> >> >> Namely:
> >> >>  - (if possible) factor out the exynos g2d kernel functionality to a
> >> >> 
> >> >> separate kernel module and wire up the rockhip (via dt ?) to use it
> >> >> 
> >> >>  - factor out the g2d specifics out of exynos_drm.h (into
> >> >> 
> >> >> exynos_g2d_drm.h perhaps ?) and make sure exynos_drm.h includes the
> >> >> new header
> >> > 
> >> > I think the IP blocks themself are quite different between Rockchip's
> >> > RGA
> >> > and Samsung's g2d and I guess the similarities are more along the lines
> >> > on how that gets integrated into the respective drm driver and
> >> > userspace.
> >> 
> >> In this case, the exynos_g2d_drm.h seems like a good idea. As I'm
> >> obviously biased, it's better to check how others feel on the topic.
> >> 
> >> >>  - if neither of these are possible, then please ensure that the new
> >> >> 
> >> >> header uses correct types (see the docs [1]), use MIT/X11 license (if
> >> >> possible) and link where upstream userspace is happy with the
> >> >> interface (ideally more than a simple test app like libdrm)
> >> >> These might sound like an overkill, although getting UAPI right and
> >> >> maintaining it forever forces us to do so.
> >> > 
> >> > As for a real-world usecase, maybe the armsoc xserver might be somewhat
> >> > easy to use. While the core changes I did are in the core project
> >> > already, I'm still keeping the actual Rockchip support separate [0] due
> >> > to the not-yet- resolved create_gem ioctl.
> >> > 
> >> > Anyway, the armsoc xserver has some exa implementation hooks were I
> >> > guess
> >> > it might be relatively easy to hook up soc-specific things.
> >> 
> >> Ouch the armsoc ddx... Last time I've checked it felt like a place
> >> where everyone is doing his own thing, with no actual reviews and/or
> >> maintainer.
> > 
> > The development rate is pretty low and maintainership is unclear but the
> > per- soc voodoo is quite limited to the GEM-creation and everything else
> > seems somewhat nice when compared for example to the older versions of
> > the ddx.> 
> >> Iirc most/all of it's functionality was achievable with
> >> modesetting ddx (with or without glamor) ? I take it that things have
> >> changed and/or I misunderstood something ?
> > 
> > I don't really understand that whole stack or how xservers work on a whole
> > ;-) I was merely able to make the _binary_ mali-driver work with this one
> > and remembered that there were hooks for future per-soc exa functions.
> > 
> > I guess for that glamor thing you'd need an actual gpu driver and not that
> > libGL-override voodoo those crazy binary drivers do.
> > 
> > At least the modesetting ddx didn't like mali-binary-driver.
> 
> A quick rundown of the whole thing (simplified and maybe slightly off)
> - the modesetting DDX (merged in xserver for a few releases now),
> relies on GBM for buffer management and GL{,ES} for acceleration. On
> the KMS side it's as generic as any other driver should be.
> 
> I'm not sure how well modesetting works without gbm, but it should be
> able to build at least. About getting it (or others) to work with
> binary blobs... I guess you know what my and others' view is. Place
> the fact that one tries to upstream a kernel interface which,
> indirectly, interacts with such a module makes things even more ...
> lovely.
> 
> Sorry to be the bearer of bad news. If you have other ideas or others
> feels like I'm overly dramatic let me know, please.

I have the feeling we're going quite a bit off-topic right now :-) .
The binary-driver-crazyness, hasn't really anything to do with Yakir's support 
for the RGA (which is about raster-graphics-acceleration, so 2d stuff).

And me mentioning the armsoc-ddx was merely a means to allow some sort of 
different userspace user, as requested in your original mail ;-) .

Maybe you know a better use-case on where to demonstrate the viability of the 
userspace API for it as originally requested.
