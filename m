From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 9 Feb 2015 11:46:25 +0000
Subject: [PATCH v8 08/21] dt / chosen: Add linux,uefi-stub-generated-dtb
 property
In-Reply-To: <CAKv+Gu-oDRjYPC3SxSDVZ7rV7eG9DCct=kNS0xBVd28YoV5fSg@mail.gmail.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-9-git-send-email-hanjun.guo@linaro.org>
 <20150202134033.GR4278@bivouac.eciton.net>
 <20150202135051.GA3825@xora-haswell.xora.org.uk>
 <20150202163253.GG21175@leverpostej>
 <CAGCh1+nL7YMXYp42ekWAqmw_m5cy=s_7NszLDAXj=bUr2aZVig@mail.gmail.com>
 <54D5884A.6050009@linaro.org>
 <CAKv+Gu-oDRjYPC3SxSDVZ7rV7eG9DCct=kNS0xBVd28YoV5fSg@mail.gmail.com>
Message-ID: <20150209114624.GD4250@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 07, 2015 at 05:03:44AM +0000, Ard Biesheuvel wrote:
> On 7 February 2015 at 03:36, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > On 2015?02?06? 18:34, G Gregory wrote:
> > [...]
> >
> >>>>>>
> >>>>>> --------------------------------------------------------------------------------
> >>>>>>   linux,uefi-stub-kern-ver  | string | Copy of linux_banner from
> >>>>>> build.
> >>>>>>
> >>>>>> --------------------------------------------------------------------------------
> >>>>>> +linux,uefi-stub-generated-dtb  | bool | Indication for no DTB
> >>>>>> provided by
> >>>>>> +                        |      | firmware.
> >>>>>>
> >>>>>> +--------------------------------------------------------------------------------
> >>>>>
> >>>>>
> >>>>> Apologies for the late bikeshedding, but the discussion on this topic
> >>>>> previsously was lively enough that I thought I'd let it die down a bit
> >>>>> before seeing if I had anything to add.
> >>>>>
> >>>>> That, and I just realised something:
> >>>>> One alternative to this added DT entry is that we could treat the
> >>>>> absence of a registered UEFI configuration table as the indication
> >>>>> that no HW description was provided from firmware, since the stub does
> >>>>> not call InstallConfigurationTable() on the DT it generates. This does
> >>>>> move the ability to detect to after efi_init(), but this should be
> >>>>> fine for ACPI-purposes.
> >>>>>
> >>>> That would not work as expected in the kexec/Xen use case though as they
> >>>> may genuinely boot with DT from an ACPI host without UEFI.
> >>>
> >>>
> >>> I'm a little concerned by this case. How do we intend to pass stuff from
> >>> Xen to the kernel in this case? When we initially discussed the stub
> >>> prior to merging, we weren't quite sure if ACPI without UEFI was
> >>> entirely safe.
> >>>
> >>> The linux,uefi-stub-kern-ver property was originally intended as a
> >>> sanity-check feature to ensure nothing (including Xen) masqueraded as
> >>> the stub, but for some reason the actual sanity check was never
> >>> implemented.
> >>>
> >>>>> If that is deemed undesirable, I would still prefer Catalin's
> >>>>> suggested name ("linux,bare-dtb"), which describes the state rather
> >>>>> than the route we took to get there.
> >>>>>
> >>>> I agree.
> >>>
> >>>
> >>> I guess this would be ok, though it would be nice to know which agent
> >>> generated the DTB.
> >>>
> >>
> >> The most obvious scheme then is
> >>
> >> linux,bare-dtb = "uefi-stub";
> >>
> >> otherwise we generate a new binding for every component in the boot path.
> >
> >
> > Leif, Mark, any comments on this?
> >
> 
> As far as I remember, we did not finalize the decision to go with a
> stub generated property instead of some other means to infer that the
> device tree is not suitable for booting and ACPI should be preferred.
> 
> We will be discussing the 'stub<->kernel interface as a boot protocol'
> topic this week at Connect, so let's discuss it in that context before
> signing off on patches like these.

As some of us (at least myself) aren't at connect, it would be nice if
those discussions could be at least mirrored on the mailing list. I have
some concerns regarding how this is going to work long-term, and I'd
like to make sure we don't get stuck with something that limits what we
can do long-term.

Is there a session set aside for this, or is this a hallway track topic?

Thanks,
Mark.
