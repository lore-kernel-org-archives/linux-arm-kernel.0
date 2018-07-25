From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jul 2018 16:16:41 +0100
Subject: [RFC V4 0/3] arm_pmu: acpi: variant support and QCOM Falkor
 extensions
In-Reply-To: <CAGbRU0QLSpNEtcryuPPZE98zAo7peEmcDqcQiLi1zO6cfKML2A@mail.gmail.com>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
 <20180713153318.GB3049@arm.com>
 <CAGbRU0QLSpNEtcryuPPZE98zAo7peEmcDqcQiLi1zO6cfKML2A@mail.gmail.com>
Message-ID: <20180725151641.GC6866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2018 at 03:35:45PM -0500, J. Agust?n Vega-Fr?as wrote:
> On Fri, Jul 13, 2018 at 10:33 AM, Will Deacon <will.deacon@arm.com> wrote:
> > I'm mostly ok with this approach, but I have a concern with the way in which
> > the sysfs interface for carving up the config fields is implemented. If this
> > is intended to be a strict extension to the armv8 pmu architecture, then I
> > don't think you should be overriding the attr_groups entirely. Rather, you
> > should be taking the attr_groups from pmuv3 and then extending them in a way
> > which avoids overlapping field allocations by construction.
> >
> > As it stands, you already have an overlap between the pcc bit and the
> > chained counter bit which Suzuki has implemented and it will be very easy to
> > introduce API breakage if we don't enforce this as part of the design.
> >
> > Will
> 
> FYI, I left Qualcomm on July 6, one of my former colleagues will submit
> new iterations of this series. I will continue to comment on this and future
> patchsets as a courtesy to my former colleagues and the community.
> 
> Thanks for pointing out the sysfs issue. My suggestion on how to address it is:
> 
> 1. Reserve config and config1 for architectural format attributes and
>    config2 for extension format attributes.
> 2. Add a struct attribute ** parameter to the extension init function so
>    extensions can return the new attributes.
> 3. The extension framework code in arm_pmu_acpi.c can then allocate a new
>    attribute array to contain the base and extension attributes and ensure
>    all the new attributes are on config2.
> 
> Though a more elaborate approach can be implemented to find conflicts in
> bit usage within config fields, it would require much more code for a
> relatively simple problem. Thoughts?

As long as you're happy to live inside config2, that sounds sensible to me.

Will
