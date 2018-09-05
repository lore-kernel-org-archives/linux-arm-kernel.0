From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 5 Sep 2018 20:09:50 +0100
Subject: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
In-Reply-To: <CAKv+Gu_zDJ11+CjgpBPRm2C66sUq6bzGGA2EBCZoDXa-3NdYNA@mail.gmail.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
 <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
 <CAKv+Gu_zDJ11+CjgpBPRm2C66sUq6bzGGA2EBCZoDXa-3NdYNA@mail.gmail.com>
Message-ID: <CACxGe6vSAjO3N-_6OHASHiDLpN+0b3=p54WWq93GgCY=YGQiKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 10:37 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 September 2018 at 12:13, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Tue, Sep 4, 2018 at 7:24 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>
> >> On 2 September 2018 at 04:54, Olof Johansson <olof@lixom.net> wrote:
> >> > On Thu, Aug 30, 2018 at 9:23 AM, Ard Biesheuvel
> >> > <ard.biesheuvel@linaro.org> wrote:
> >> >> On 30 August 2018 at 17:06, Olof Johansson <olof@lixom.net> wrote:
> >> >>> On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
> >> >>> <ard.biesheuvel@linaro.org> wrote:
> >> >>>> Don't be surprised if some future enhancements of the EFI stub code
> >> >>>> depend on !EFI_ARMSTUB_DTB_LOADER.
> >
> > That's an odd statement to make. The DTB loader code is well contained
> > and with defined semantics... True, the semantics are "I DON'T BELIEVE
> > FIRMWARE", but it is still well defined. What scenario are you
> > envisioning where EFI_ARMSTUB_DTB_LOADER would be explicitly excluded?
> >
>
> Well, to be honest, I don't have a real-world example at hand, but my
> concern is about cases where the firmware provided DTB and the
> override DTB diverge in a way that leaves it up to the EFI stub to
> reconcile them and/or to reason about which one it should prefer.
>
> One example could be OP-TEE support: currently, we put a
> /firmware/optee node in the DT to inform the OS that OP-TEE is running
> in the secure world. If we allow a DT to be provided via dtb= that
> provides such a node, we are blocking all future opportunities in
> future kernels to do any kind of preparatory OP-TEE related
> initialization in the EFI stub [while boot services are still
> available] unless we decide to make it the EFI stub's problem to
> reason about which version of the DT is the correct one to use. What
> if the firmware's DT has /firmware/optee/status = disabled and the
> dtb= one does not?
>
> Another trivial example is GRUB: passing dtb= via the command line
> will break initrds loaded via GRUB, since they are passed via the
> /chosen node.

Using 'dtb=' straight out means *I don't believe anything firmware
tells me*, so of course nothing like OP-TEE integration, command line
passing, dynamic configuration, or anything that firmware might want
to tell the kernel is going to work. Anyone who uses dtb= gets to keep
the pieces when they break stuff. That can be written down into policy
in the dtb= documentation if you like. I've just posted a patch to do
that.

g.
