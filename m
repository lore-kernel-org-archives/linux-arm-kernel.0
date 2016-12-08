From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 8 Dec 2016 10:06:46 +0100
Subject: [PATCH] drm: hdlcd: Work properly in big-endian mode
In-Reply-To: <CAKb7UvhNx_OPqXS4wKj59ReRaQ4jkY7YJ4KfvVKj0DUniFjrGw@mail.gmail.com>
References: <f484518775c0bf063ae0a6f1e6c11bb404a7acc9.1481124156.git.robin.murphy@arm.com>
 <20161207155714.ldmshptddwvhsdop@phenom.ffwll.local>
 <548dc9d9-4d21-7f93-cc92-5bc3234f1b8f@arm.com>
 <CAKb7UvhNx_OPqXS4wKj59ReRaQ4jkY7YJ4KfvVKj0DUniFjrGw@mail.gmail.com>
Message-ID: <20161208090646.ovpd5mn3bco7ifoa@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 07:16:30PM -0500, Ilia Mirkin wrote:
> On Wed, Dec 7, 2016 at 11:42 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> > By comparison, the same use-cases (fbcon and fb-test) under the same
> > big-endian kernel do *not* show the same problem with nouveau driving a
> > PCIe 7600GT card, which led me to believe it was HDLCD-specific.
> 
> Just to randomly insert info here... NV11+ cards have a "big endian"
> mode, where you can do 32-bit mmio from a big-endian cpu, and the card
> will auto-swap those. There are similar additional bits that make
> operating and accelerating off a big-endian CPU tolerable. Some care
> has gone into the kernel to make sure that all that stuff works. (One
> of those bits is that data gets byteswapped on upload to VRAM by
> virtue of being uploaded by sticking data into a pushbuf, as I
> recall.)

But on the kms side nouveau.ko doesn't inform userspace that it's taking
big-endian buffers? That seems to be the crux here - should we auto-endian
gpus to the cpu's endianess (might not work everywhere, but probably
bigger chance that it works on gpus which do have endian control). Or
should we start enforcing the explicit DRM_FORMAT_BIG_ENDIAN flag?

If we opt for the former I really think we should nuke the endianess
indicator. Atm it seems entirely unused (at least in drivers), so that's
probably the right choice.

Plus updating docs ofc.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
