From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 14:04:19 +0100
Subject: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <540F7BE2.8060403@redhat.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
 <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
 <540F7BE2.8060403@redhat.com>
Message-ID: <20140910130419.GJ28488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 11:14:58PM +0100, Jon Masters wrote:
> On 09/09/2014 01:17 PM, Bjorn Helgaas wrote:
> > On Mon, Sep 1, 2014 at 8:57 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> >> From: Al Stone <al.stone@linaro.org>
> >>
> >> Introduce one early parameters "off" for "acpi" to disable ACPI on
> >> ARM64.
> > 
> > It might be worth mentioning the purpose of this in the changelog (and
> > maybe the documentation).  I don't think this parameter is supported
> > on ia64, and on x86 it seems like it's mostly used as a "fix" by
> > Ubuntu users who consider the problem resolved when they find this
> > parameter.  That just means we don't get a chance to fix the real
> > underlying problem, so I'm not sure it's a real benefit to have the
> > parameter.
> 
> >> -       acpi=           [HW,ACPI,X86]
> >> +       acpi=           [HW,ACPI,X86,ARM]
> >>                         Advanced Configuration and Power Interface
> >>                         Format: { force | off | strict | noirq | rsdt }
> >>                         force -- enable ACPI if default was off
> >> @@ -175,6 +175,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >>                                 strictly ACPI specification compliant.
> >>                         rsdt -- prefer RSDT over (default) XSDT
> >>                         copy_dsdt -- copy DSDT to memory
> >> +                       For ARM64, ONLY "acpi=off" is available.
> 
> Something along the lines of:
> 
> "The purpose of disabling ACPI on 64-bit ARM server platforms is to
> allow for an orderly adoption of ACPI on early systems that may also
> provide a DeviceTree based boot option initially. The acpi= option
> disables both parsing of any tables passed in through the EFI System
> Table RSDP and also disables the runtime ACPI interpreter on arm64".

Please, let's keep this polarised rhetoric out of the Linux kernel. If ACPI
support gets merged for arm64, then the community has a commitment to
support it alongside devicetree. There isn't a migration path because
nothing is being replaced and we shouldn't dictate to users in which
circumstances they are allowed to use one firmware interface over another.

Other entities (server vendors, distributions, firmware guys, ...) can make
up their own rules, but attempting to peddle their agenda in the upstream
kernel is completely inappropriate.

It's blindingly obvious that acpi=off is there to disable ACPI at boot.
We either support that option or we don't -- none of this `oh, well you
can use it in this specific case I suppose' rubbish. I'm not questioning
your use-case, but there's really no need to talk about an `orderly
adoption' when all you need to say is that your ACPI is busted and passing
acpi=off lets you boot with a devicetree.

Yes, I'm being pedantic, but it's really important not to get the upstream
messaging wrong about ACPI. Devicetree is absolutely *not* going away and
people can choose to use whatever they prefer, however they prefer to use
it.

Will
