From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jul 2016 11:17:48 +0200
Subject: Build regressions/improvements in v4.7-rc6
In-Reply-To: <CAMuHMdUDO0k86TTVTiCQGS2=H0dEXVW77NNfvt7fvWbwdpS=2g@mail.gmail.com>
References: <1467619946-424-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUDO0k86TTVTiCQGS2=H0dEXVW77NNfvt7fvWbwdpS=2g@mail.gmail.com>
Message-ID: <6183003.0tbSMroAbk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 4, 2016 10:21:45 AM CEST Geert Uytterhoeven wrote:
> On Mon, Jul 4, 2016 at 10:12 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v4.7-rc6[1] to v4.7-rc5[3], the summaries are:
> >   - build errors: +3/-2
> 
>   + /home/kisskb/slave/src/drivers/vhost/vhost.c: error: call to
> '__compiletime_assert_844' declared with attribute error: BUILD_BUG_ON
> failed: __alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE:  => 844:3
> 
> arm-randconfig
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/head/10562/ (260 out of 263 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/head/10532/ (260 out of 263 configs)

I don't see any changes in the code in this time frame, but this is the
code causing it:


struct vring_avail {    
        __virtio16 flags;
        __virtio16 idx;
        __virtio16 ring[];
};      

/* The virtqueue structure describes a queue attached to a device. */
struct vhost_virtqueue {
        struct vhost_dev *dev;
                        
        /* The actual ring of buffers. */
        struct mutex mutex; 
        unsigned int num; 
        struct vring_desc __user *desc;
        struct vring_avail __user *avail;
        struct vring_used __user *used;
        ...
};

	struct vhost_virtqueue *vq;
   BUILD_BUG_ON(__alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE);


The alignment of the *vq->avail should be '2' on all architectures,
however an ARM OABI compiler will have a padded structure with alignment '4'.

Looking at the build logs, I find it only in a single randconfig build
at http://kisskb.ellerman.id.au/kisskb/buildresult/12735927/ which apparently
enabled the vhost driver in combination with ARM_AEABI=n.

In my own randconfig builds I am forcing ARM_AEABI=y because there are a
couple of other problems with OABI.

If we want to avoid this one, we could make the inclusion of
drivers/vhost/Kconfig from arch/arm/kvm/Kconfig depend on CONFIG_AEABI,
or perhaps go further force-enable CONFIG_AEABI for ARMv6k and higher
(cmpxchg64() is broken on OABI too), and only include vhost if KVM
is enabled (KVM in turn requires ARMv7).

	Arnd
