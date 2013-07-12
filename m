From: dsd@laptop.org (Daniel Drake)
Date: Fri, 12 Jul 2013 10:05:45 -0600
Subject: [PATCH V3 1/3] dts: change Marvell prefix to 'marvell'
In-Reply-To: <20130712155733.GZ11908@titan.lakedaemon.net>
References: <1373352166-10064-1-git-send-email-zhangwm@marvell.com>
 <1373352166-10064-2-git-send-email-zhangwm@marvell.com>
 <20130709124900.GG11908@titan.lakedaemon.net>
 <CAN1soZxiOh6TpbUOCUzK8gNwmvjbT3ihkUWaw8tuZ7md+NVA2g@mail.gmail.com>
 <20130710122433.GO11908@titan.lakedaemon.net>
 <CAN1soZzMvront1-jcBW6-uRKNs0OZNGnmiOjKGZSM28bViB_8A@mail.gmail.com>
 <20130710215041.GR11908@titan.lakedaemon.net>
 <CAN1soZzuiukY9qASFNcH0k=zH8=uT=71bKejPss44FCzNy=X-A@mail.gmail.com>
 <CAMLZHHQGZvDssY-YxQ3ZW8FYhpG-H1-VbokOid33socRSPrMNw@mail.gmail.com>
 <20130712155733.GZ11908@titan.lakedaemon.net>
Message-ID: <CAMLZHHRrrHpSkNbabP9ALKBXemUw07=VmB6kBoD+4u05HQwQ_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 9:57 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> This also means we should do a patch for stable v3.5+ appending the
> "mrvl,..." string to the drivers that had it removed improperly, as
> Daniel discovered.  Daniel, since you are probably most familiar (and
> most able to test ;-) ), would you mind putting that patch together?

I will look at that. There was another case of a quiet mrvl->marvell
conversion that bit us around a year ago as well, so I will dig that
up too for consideration.

> So we don't have to keep it around forever, we could do as Arnd has
> suggested in the past (for an entirely different problem):
>
>         /* assuming it goes in for v3.12 */
>         if (WARN_ON(of_device_is_compatible(dev, "mrvl,..."))) {
>                 dev_info(&dev->dev, "compatible string \"mrvl,...\" being removed in v3.15\n");
>                 BUG_ON(LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0));
>         }
>
> * I can't find where Arnd's suggestion was, so this hack is completely
> my own.
>
> Keep in mind, the above hack is just a suggestion, it makes my skin
> crawl just looking at it... I'm open to other ideas.  Or, not doing it
> at all.

A new OpenFirmware or dtb file would want to keep the old mrvl
compatible string around in order to have compatibility with old
kernels. So I think that hack would have to be extended to "if device
is compatible with mrvl, but not marvell, then warn". And that seems
so ugly that my vote would be to avoid it. Especially while we don't
know of existing users who have a requirement of stability.

Daniel
