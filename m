From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 8 Dec 2016 00:59:33 +0100
Subject: [PATCH] drm: hdlcd: Work properly in big-endian mode
In-Reply-To: <36dcbbc5-607a-1773-17e4-af2a9810a06e@arm.com>
References: <f484518775c0bf063ae0a6f1e6c11bb404a7acc9.1481124156.git.robin.murphy@arm.com>
 <20161207155714.ldmshptddwvhsdop@phenom.ffwll.local>
 <548dc9d9-4d21-7f93-cc92-5bc3234f1b8f@arm.com>
 <36dcbbc5-607a-1773-17e4-af2a9810a06e@arm.com>
Message-ID: <20161207235932.2i7hu6swkd5rrcby@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 04:50:31PM +0000, Robin Murphy wrote:
> On 07/12/16 16:42, Robin Murphy wrote:
> > On 07/12/16 15:57, Daniel Vetter wrote:
> >> On Wed, Dec 07, 2016 at 03:31:40PM +0000, Robin Murphy wrote:
> >>> Under a big-endian kernel, colours on the framebuffer all come out a
> >>> delightful shade of wrong, since we fail to take the reversed byte
> >>> order into account. Fortunately, the HDLCD has a control bit to make it
> >>> automatically byteswap big-endian data; let's use it as appropriate.
> >>>
> >>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>
> >> fourcc codes (and the drm fourcc codes) are supposed to be little-endian.
> >> All of them. So either we fix up the drivers and userspace to set that
> >> flag correctly (which would mean hdlcd should expose twice as many
> >> formats, each one with the little and big endian mode).
> > 
> > AFAICS, SIMPLEFB_FORMATS *is* supposed to be explicitly little-endian
> > modes. I see that DRM_FORMAT_BIG_ENDIAN exists, but nothing in-tree ever
> > sets it :/
> > 
> > My vague (and probably wrong) assumption was that the HDLCD is still
> > expecting little-endian data, but the the CPU is writing framebuffer
> > data as host-endian words, hence what the HDLCD thinks is xRGB is
> > actually RGBx under a big-endian kernel - It's certainly consistent
> > between kernel (fbcon) and userspace (fb-test[1]): white is yellow, blue
> > is black, green is red and red is green. I don't know how to test
> > "proper" DRM (I've failed to get X to work with the Arch Linux ARM
> > distro I have on there at the moment).
> > 
> > Once again I'm somewhat out of my depth here - I just found a thing that
> > seemed appropriate and visibly resolved the immediate problem :)
> > By comparison, the same use-cases (fbcon and fb-test) under the same
> > big-endian kernel do *not* show the same problem with nouveau driving a
> > PCIe 7600GT card, which led me to believe it was HDLCD-specific.
> 
> Off the back of that, upon closer inspection, nv_crtc_commit() would
> appear to already be doing very much the equivalent thing to what I'm
> doing in this patch, so now I have no idea whether this is right or
> everything's wrong.

Congrats for finding a really big can of worms. Unfortunately I can't
really help you with figuring out what's the right choice here :(

Trying to fix up everything is probably going to be lots of work, but
assuming that everything is broken for big endian is probably correct.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
