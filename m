From: robh@kernel.org (Rob Herring)
Date: Thu, 12 Nov 2015 19:38:23 -0600
Subject: [PATCH 1/3] devicetree: bindings: Document qcom board compatible
 format
In-Reply-To: <20151113001102.GF15032@codeaurora.org>
References: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
 <1445894712-14350-2-git-send-email-sboyd@codeaurora.org>
 <20151112164948.GA24938@rob-hp-laptop>
 <20151112194408.GC15032@codeaurora.org>
 <CAL_Jsq+5QD2Ce8snovw6vC31NvD5oB+Yos1VuZDjXfKa3fPvDQ@mail.gmail.com>
 <20151113001102.GF15032@codeaurora.org>
Message-ID: <CAL_Jsq+F+bxTmb_ShRmygf+NtoYeOMg5UawVXD8Ffks_EAFLcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 6:11 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 11/12, Rob Herring wrote:
>> On Thu, Nov 12, 2015 at 1:44 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 11/12, Rob Herring wrote:
>> >> On Mon, Oct 26, 2015 at 02:25:10PM -0700, Stephen Boyd wrote:
>>
>> >> > +Some qcom based bootloaders identify the dtb blob based on a set of
>> >> > +device properties like SoC, platform, PMIC, and revisions of those components.
>> >> > +To support this scheme, we encode this information into the board compatible
>> >> > +string.
>> >>
>> >> Why does all this need to be a single property?
>> >
>> > Because the different vendor properties were rejected by arm-soc
>> > maintainers and the board compatible string was suggested as the
>> > place to put such information.
>>
>> I'm surprised an 80+ character compatible stream is okay. The parts
>> giving me heartburn here are not mentioned in the previous discussion
>> nor the QCDT format.
>>
>> As presented previously I agree with the push back. However, we could
>> do standard properties for SOC and board versions rather than
>> something vendor specific. Then the existing kernel support for
>> versions could use it. We could also just make this compatible string
>> formatting standard for more than just QC boards.
>
> Some standard properties for these things sounds good to me.
> What's the existing kernel support for versions though? Is that
> just compatible string matching, or something else?

The soc_device stuff (and arm32 cpuinfo has a h/w version). Today I
think users are pulling version info from h/w registers, but if you
don't have h/w registers, then getting it from DT would make sense.


>> For mb, can't the tool just parse the memory node to get ram size
>> rather than parsing the compatible.
>
> Sure. Right now the bootloader injects the memory information
> during boot. I think it should work if we already have the memory
> information there. I don't have any usage of mb at the moment
> though, so if you want we can drop this field until a time that
> we need it.

If the bootloader injects it, then how do you know what to put into
the compatible string?

>> >> > +The 'panel' element must be one of the following strings:
>> >> > +
>> >> > +   720p
>> >> > +   fWVGA
>> >> > +   hd
>> >> > +   qHD
>> >>
>> >> How is this used?
>> >
>> > I believe this was added so that we could have different dtbs for
>> > devices that have different panels on them. I'm not sure this is
>> > still used though. It could be legacy.
>>
>> Dealing with multiple panels is fairly common. I think you could use
>> an alias to the panel node and match using its compatible or
>> resolution.
>
> So dtbtool will need to resolve the alias and then figure out
> which type of panel it is from compatible? Ok. I'd rather not
> write that code unless it's needed, so I hope this field is not
> used either.

Certainly better to figure out if it is needed first.

>> >> > +The 'boot' element must be one of the following strings:
>> >> > +
>> >> > +   emmc_sdc1
>> >> > +   ufs
>> >> > +
>>
>> Again, perhaps an alias would work here.
>>
>> >> > +The 'pmic' element must be one of the following strings:
>> >> > +
>> >> > +   pm8841
>> >> > +   pm8019
>> >> > +   pm8110
>> >> > +   pma8084
>> >> > +   pmi8962
>> >> > +   pmd9635
>> >> > +   pm8994
>> >> > +   pmi8994
>> >> > +   pm8916
>> >> > +   pm8004
>> >> > +   pm8909
>> >> > +
>> >> > +The 'pmic' element is specified in order of ascending USID. The PMIC in USID0
>> >> > +goes first, and then USID2, USID4, and finally USID6. Up to four PMICs may be
>> >> > +specified and no holes in the USID number space are allowed.
>> >>
>> >> What is USID?
>> >
>> > USID is Unique Slave IDentifier. It's an SPMI concept.
>>
>> Okay, then please say "SPMI USID" or something.
>
> Ok.
>
> In attempts to shorten the compatible string, we could use
> aliases for the USIDs too. Then it should be possible to pull out
> the information from the compatible fields of the PMIC nodes to
> construct the PMIC part of the string. I'd like to avoid having
> to go down the path of / -> soc -> spmi controller -> usidx,y,z
> and just go straight to the usid node from a phandle.

Yes. I was willing to draw the line after the PMIC, but seems Olof is less so.

> With that in mind, right now I'm using fdtget from python to grab
> the compatible string and parse it with a regex. If things need
> to become more complicated to start following phandles, etc. are
> there some python bindings to libfdt somewhere?

Not that I'm aware of. C is the only language you need. ;)

Rob
