From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 9 Sep 2018 12:07:33 +0100
Subject: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
In-Reply-To: <dc26dc1b-c022-341b-18ba-c009275e5ee9@broadcom.com>
References: <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
 <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com>
 <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
 <1f8095f1-1f0c-0791-31c4-c7b986c4ce1f@broadcom.com>
 <CACxGe6tbuDzEaBqOD7Z3nWMW0Nkcf22MFbD3BL+KBqnKEo2tQw@mail.gmail.com>
 <dc26dc1b-c022-341b-18ba-c009275e5ee9@broadcom.com>
Message-ID: <20180909110732.GA63296@iMac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 11:04:36AM -0700, Scott Branden wrote:
> On 18-09-05 11:00 AM, Grant Likely wrote:
> > On Wed, Sep 5, 2018 at 6:27 PM Scott Branden <scott.branden@broadcom.com> wrote:
> > > On 18-09-05 02:40 AM, Ard Biesheuvel wrote:
> > > > On 4 September 2018 at 19:19, Scott Branden <scott.branden@broadcom.com> wrote:
> > > > > Rather than introduce EFI_ARMSTUB_DTB_LOADER, why not have
> > > > > the efistub use CONFIG_OF to determine whether it supports dtb= or not?
> > > > > 
> > > > > That way ACPI-only distros disable devicetree support entirely.
> > > > > 
> > > > Unfortunately, CONFIG_OF cannot be disabled on arm64 even on ACPI-only builds.
> > > OF shouldn't be automatically selected in the arm64/Kconfig.  It should
> > > have a config parmaeter like other archs as mips and arm.  I can
> > > submit a patch so it functions the same way as other archs so it
> > > is not always selected.  It will be good to add a USE_OF config
> > > options like the other archs (or simply remove the select from the
> > > Kconfig and choose OF directly in the defconfig. This will have
> > > the added benefit of doing away with OF support when its not
> > > needed on an ARM64 platform.  ACPI is already not automatically
> > > selected for all ARM64 platforms, nor should devicetree.
> > We don't do that on Arm because a devicetree is always required at
> > boot time. Even on ACPI systems a tiny DTB is used containing just a
> > /chosen node for passing the kernel command line and the initrd
> > location.
> 
> Seems bizarre DTB is not needed for x86 to boot from UEFI with ACPI
> support?? I'll look into it further at some point in order to remove such
> anomaly.? There should be no need for such devicetree reliance.

I'd say don't waste time on this, the patch would not get merged ;). As
Grant said, we use a tiny dtb to pass the command line, initrd to the
kernel. You'd have to invent an alternative (setup_header, ATAGs) and I
really don't see the point of increased complexity just because of some
philosophical arguments against OF.

-- 
Catalin
