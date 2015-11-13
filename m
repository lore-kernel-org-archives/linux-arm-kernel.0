From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Nov 2015 18:09:21 -0800
Subject: [PATCH 1/3] devicetree: bindings: Document qcom board compatible
 format
In-Reply-To: <CAL_Jsq+F+bxTmb_ShRmygf+NtoYeOMg5UawVXD8Ffks_EAFLcQ@mail.gmail.com>
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
 <1445894712-14350-2-git-send-email-sboyd@codeaurora.org>
 <20151112164948.GA24938@rob-hp-laptop>
 <20151112194408.GC15032@codeaurora.org>
 <CAL_Jsq+5QD2Ce8snovw6vC31NvD5oB+Yos1VuZDjXfKa3fPvDQ@mail.gmail.com>
 <20151113001102.GF15032@codeaurora.org>
 <CAL_Jsq+F+bxTmb_ShRmygf+NtoYeOMg5UawVXD8Ffks_EAFLcQ@mail.gmail.com>
Message-ID: <20151113020921.GH15032@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12, Rob Herring wrote:
> On Thu, Nov 12, 2015 at 6:11 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 11/12, Rob Herring wrote:
> >> On Thu, Nov 12, 2015 at 1:44 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> > On 11/12, Rob Herring wrote:
> >> >> On Mon, Oct 26, 2015 at 02:25:10PM -0700, Stephen Boyd wrote:
> >>
> >> >> > +Some qcom based bootloaders identify the dtb blob based on a set of
> >> >> > +device properties like SoC, platform, PMIC, and revisions of those components.
> >> >> > +To support this scheme, we encode this information into the board compatible
> >> >> > +string.
> >> >>
> >> >> Why does all this need to be a single property?
> >> >
> >> > Because the different vendor properties were rejected by arm-soc
> >> > maintainers and the board compatible string was suggested as the
> >> > place to put such information.
> >>
> >> I'm surprised an 80+ character compatible stream is okay. The parts
> >> giving me heartburn here are not mentioned in the previous discussion
> >> nor the QCDT format.
> >>
> >> As presented previously I agree with the push back. However, we could
> >> do standard properties for SOC and board versions rather than
> >> something vendor specific. Then the existing kernel support for
> >> versions could use it. We could also just make this compatible string
> >> formatting standard for more than just QC boards.
> >
> > Some standard properties for these things sounds good to me.
> > What's the existing kernel support for versions though? Is that
> > just compatible string matching, or something else?
> 
> The soc_device stuff (and arm32 cpuinfo has a h/w version). Today I
> think users are pulling version info from h/w registers, but if you
> don't have h/w registers, then getting it from DT would make sense.

Ah ok. The version here is mostly about specifying some minimum
version or greater that the dtb matches against. If we were to
actually put the real version we may need more blobs for the
different combinations of board and SoC versions. So perhaps
leaving that in compatible string is the right way to go?

> 
> 
> >> For mb, can't the tool just parse the memory node to get ram size
> >> rather than parsing the compatible.
> >
> > Sure. Right now the bootloader injects the memory information
> > during boot. I think it should work if we already have the memory
> > information there. I don't have any usage of mb at the moment
> > though, so if you want we can drop this field until a time that
> > we need it.
> 
> If the bootloader injects it, then how do you know what to put into
> the compatible string?

Presumably the bootloader finds the matching size compatible
element and then populates the memory info that just happens to
match the same size. I don't know if this is happening, but it
certainly seems possible to have the same memory size at
different starting addresses. So we could simplify that situation
by having one size in the compatible that works for either
starting address. In summary, I don't 

> 
> > With that in mind, right now I'm using fdtget from python to grab
> > the compatible string and parse it with a regex. If things need
> > to become more complicated to start following phandles, etc. are
> > there some python bindings to libfdt somewhere?
> 
> Not that I'm aware of. C is the only language you need. ;)

Urgh. I converted dtbtool to python to make it simpler and avoid
that compilation step. I guess I'll explore wrapping some calls
to the C library inside dtbtool itself for this particular
purpose. It would be nice though if I could get a python object
for the root of the unflattened dtb that could be iterated and
inspected. I'll take a look at doing that sometime.

I'm thinking the aliases would be something like this:

	usid0 = <&pmic0>;
	usid2 = <&pmic1>;
	usid4 = <&pmic2>;
	usid6 = <&pmic3>;

We could specify usid1,3,5,7 too, but they're the same as the
0,2,4,6 ones.

So far I think all that will change is dropping the mb/panel
elements and parsing the PMIC ids from compatible strings and DT
traversal. Sounds right?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
