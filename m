From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Oct 2012 11:12:53 -0700
Subject: [PATCH 01/16] ARM: dts: exynos4210: Replace legacy GPIO bank
 nodes with pinctrl bank nodes
In-Reply-To: <5075A1EF.60900@wwwdotorg.org>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-2-git-send-email-t.figa@samsung.com>
 <CACRpkdZgH9TSr2uWQW+-8-U7BxJCscQgStVOndGixGmRz74TWw@mail.gmail.com>
 <5075A1EF.60900@wwwdotorg.org>
Message-ID: <20121010181253.GQ12552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [121010 09:36]:
> On 10/10/2012 01:26 AM, Linus Walleij wrote:
> > On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > 
> >> Seuqential patches from this series introduce SoC-specific data parsing
> >> from device tree.
> >>
> >> This patch removes legacy GPIO bank nodes from exynos4210.dtsi and
> >> replaces them with nodes and properties required for these patches.
> > 
> > So to be clear:
> > 
> >> +       pinctrl-bank-types {
> >> +               bank_off: bank-off {
> >> +                       samsung,reg-names = "func", "dat", "pud",
> >> +                                               "drv", "conpdn", "pudpdn";
> >> +                       samsung,reg-params = <0x00 4>, <0x04 1>, <0x08 2>,
> >> +                                               <0x0C 2>, <0x10 2>, <0x14 2>;
> >> +               };
> > 
> > This is starting to look like a firmware language, I have mixed
> > feelings about this. Shall this be read:
> > 
> > "Poke 4 into 0x00, poke 1 into 0x04, poke 2 into 0x08" etc?
> > 
> > We really need to discuss this, Grant has already NACK:ed
> > such approaches once.
> 
> Well, I don't think he NACK'd Tony Lindgren's generic pinctrl driver,
> which is doing this exact same thing. I did raise the same point about
> Tony's driver when he posted it, but nobody seemed inclined to NACK it
> based on that at the time, IIRC...

To summarize, using reg value pairs in DT makes sense if the amount
of data is huge. Otherwise we'll be describing indidual hardware bits
as properties in DT, or have to have huge amounts of static data in
the kernel.

Where it does not make sense is if there's a sequence of reads
and writes with test loops in between.. But that's does not look
to be the case here.

The reg value pairs will be readable when the DT preprocessing is
available, and that allows the values to be orred together while
DT properties don't. The alternative is to describe hardware register
bits as DT properties, which is very bloated.

But considering all this.. Are the samsung,reg-names really needed
by the kernel?

The pinctrl named modes actually are more generic from the pinctrl
client driver point of view as you can set up multiple states for
runtime PM.
 
> BTW, the idea here is IIRC to create a generic Samsung pinctrl driver
> that works across N different Samsung SoCs, each with different register
> layout, without having to encode the register layout into tables in the
> kernel.
> 
> > If you're still going to do this, it is mandatory
> > to NOT use magic hex numbers anymore, because Stephen has
> > merged preprocessor support to the DTC compiler so you
> > can use #defined macros.
> > 
> > See commit:
> > cd296721a9645f9f28800a072490fa15458d1fb7
> 
> That feature isn't enabled yet. While dtc has been modified to be able
> to accept input that's been generated/processed by cpp, there is still
> ongoing discussion about how/whether to actually enable *.dts to use
> that feature.

Hey finally! That's good news.

Regards,

Tony
