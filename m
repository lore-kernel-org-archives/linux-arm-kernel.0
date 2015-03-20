From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Mar 2015 11:41:42 +0000
Subject: [PATCH v3] arm64: enforce x1|x2|x3 == 0 upon kernel entry as per
 boot protocol
In-Reply-To: <CAKv+Gu-=n8fbdFeZX=EEpLypOdu0xXePzXH4-gOn6SqufA6CGg@mail.gmail.com>
References: <20150319104100.GB18473@leverpostej>
 <1426762852-13699-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150319133612.GD18473@leverpostej>
 <CAKv+Gu-=n8fbdFeZX=EEpLypOdu0xXePzXH4-gOn6SqufA6CGg@mail.gmail.com>
Message-ID: <20150320114142.GF14766@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +     if (boot_args[1] || boot_args[2] || boot_args[3]) {
> >> +             pr_err("WARNING: boot protocol violation detected (x1 == %llx, x2 == %llx, x3 == %llx)\n",
> >> +                     boot_args[1], boot_args[2], boot_args[3]);
> >> +             pr_err("WARNING: your bootloader may fail to load newer kernels\n");
> >
> > If we ever decide to use x1-x3 for something, and try to boot an older
> > kernel, that warning is going to be a bit misleading. That could matter
> > for VMs where we're going to see old kernel images for a long time.
> >
> > I would like the warning to mention that could be the case.
> >
> > It would also be nice if the message were consistently spaced regardless
> > of the values of x1-x3, so we should zero-pad them (and as that takes a
> > resonable amount of space, let's give them a line each).
> >
> > So could we change the warning to be something like:
> >
> >         pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
> >                "\tx1: %016llx\n\tx2: %016llx\n\tx3: %016llx\n"
> >                "This indicates a broken bootloader or old kernel\n",
> >                boot_args[1], boot_args[2], boot_args[3]);
> >
> 
> OK, I have applied this change.
> 
> But I would like to note that we should probably only extend the boot
> protocol in a way that would not trigger this on older kernels in the
> first place.
> I.e., assign a bit in the flags field in the header, which indicates
> whether some boot protocol enhancement is supported by the kernel
> being loaded, and only allow x1/x2/x3 to be non-zero if said
> enhancement defines that.

Good point.

Given that, if you want to restore your original last line, that would
be fine with me (and my Ack still applies).

Mark.
