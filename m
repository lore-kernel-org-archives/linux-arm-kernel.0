From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Apr 2015 14:29:25 +0100
Subject: [PATCH v3 2/5] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <CAKv+Gu9b9Now_B_xftJDFyGxs8DGOTRZeGQjgOusiPh8Qvi0uw@mail.gmail.com>
References: <1426698308-726-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426698308-726-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150409114911.GB18488@leverpostej>
 <CAKv+Gu_dqMtLhLdCjj-eWn+tiAkwwXvNE6LJv7GPkx4aqTqsdA@mail.gmail.com>
 <20150409131223.GA9527@leverpostej>
 <CAKv+Gu9b9Now_B_xftJDFyGxs8DGOTRZeGQjgOusiPh8Qvi0uw@mail.gmail.com>
Message-ID: <20150409132925.GB9527@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 02:16:23PM +0100, Ard Biesheuvel wrote:
> On 9 April 2015 at 15:12, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >> +NOTE: versions prior to v4.1 require, in addition to the requirements
> >> >> +listed above, that the dtb be placed above the kernel Image inside the
> >> >> +same naturally aligned 512 MB region.
> >> >
> >> > Minor nit: This would read a little better if we just said "versions
> >> > prior to v4.1 also require that ...", dropping "in addition to the
> >> > requirements listed above".
> >> >
> >>
> >> OK
> >>
> >> Actually, I realized that this is incorrect anyway: it is not the same
> >> naturally aligned 512 MB region, it is actually 'within 512 MB of the
> >> start of the kernel Image' since that itself is naturally aligned to
> >> 512 MB in the virtual address space.
> >
> > Surely starting at TEXT_OFFSET bytes below the kernel image? ;)
> >
> 
> Only if you find it acceptable that people start putting their FDT in
> the TEXT_OFFSET region ... :-)

Unfortunately people are already doing such things (which is one reason
I moved the page tables out of the region).

It also means that the region of TEXT_OFFSET bytes below 512M from the
start of the image is unusable...

[...]

> >> I was going to suggest to use SZ_2M for the masking, but map a 4 MB
> >> window. That way, we can relax the requirement from "should not cross
> >> a 2 MB boundary' to 'should not exceed 2 MB in size', which is
> >> arguable easier to adhere to, since the latter is a property of the
> >> DTB itself, whereas the former is a property of whatever your malloc()
> >> gives you. That means the mask would remain SZ_2M, and the size would
> >> become SZ_4M
> >
> > That sounds good so long as it doesn't get in the way of increasing
> > FIX_FDT_SIZE in future.
> >
> 
> No, it shouldn't. And it actually makes it more obvious when we do
> increase it later which values should be left alone (SZ_2M) and which
> values should be increased (the higher ones)

Sounds good to me then.

> Yes. I am currently looking into a way to make early_fixmap_init() not
> rely on __va(), and if that is easily doable, I will propose something
> for the FDT which is quite close to the latest submitted version. But
> otherwise, it may be a bit more complicated, and the FDT mapping needs
> more work.

Ok. I'll keep an eye out then.

Mark.
