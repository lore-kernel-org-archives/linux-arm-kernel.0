From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 26 Sep 2013 16:23:51 -0500
Subject: [PATCH v4] dt: update PSCI binding documentation for v0.2
In-Reply-To: <CAOesGMgM2JsWbBOujdiCZdKkHqTRuN0P=OsdKGiyzz6_aiGWSA@mail.gmail.com>
References: <1379625868-5395-1-git-send-email-robherring2@gmail.com>
 <CAOesGMjNhYTfPOr5NPEC9GWym-nuFE0hX_6+LW9bTv_E3iXbcQ@mail.gmail.com>
 <20130920102015.GH17453@e106331-lin.cambridge.arm.com>
 <CAOesGMid5pgcVD+oCjUr_75tv+C5QtVZt=Vt9kdiT_QPFOrzrg@mail.gmail.com>
 <CAL_JsqK1LE9rptajTOfvzNd1NQEihJzwm0YtJMzpUz-BhwJg5w@mail.gmail.com>
 <CAOesGMgM2JsWbBOujdiCZdKkHqTRuN0P=OsdKGiyzz6_aiGWSA@mail.gmail.com>
Message-ID: <CAHCPf3sqP2H_3GTmyAXr443SKAfdFztmfFvgphaKCz+MG8S9aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 2:34 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Sep 25, 2013 at 12:20 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On Wed, Sep 25, 2013 at 12:15 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Fri, Sep 20, 2013 at 3:20 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> On Fri, Sep 20, 2013 at 05:36:51AM +0100, Olof Johansson wrote:
>>>>> Hi,
>>
>> For some of us, bindings are already in production. Until we have some
>> way to document stable vs. unstable, it is not up to anyone but the
>> users of a binding to define the stability. If the users of a binding
>> can tolerate the change, then it is unstable and can change.
>
> Ok, so why review bindings at all then? Just implement what you want,
> ship it and force it on the rest of us for ever.
>
>> All this boils down to using '_' vs. '-', right? Come on. I'm all for
>> consistency, but let's be practical. There are plenty of documented
>> examples that use '_' starting with device_type.
>
> Next property I add will be called Device_Type then, if we're willing
> to not give a shit about best practices any more. Thanks for setting
> the direction and holding the bar high, Rob!

Rob, Olof,

The unwritten law regarding new OF properties is that they should be
using '-' and not '_'. The only reason device_type and a couple others
still exist is because of the legacy of Sun OpenPROM/OpenBoot which
preceded OpenFirmware and standardization - it stayed that way for
compatibility.

There shouldn't be an underscore in any new property name, even if
IEEE1275 and then PAPR and then ePAPR completely ignored it the issue,
mostly because by defining that _ is invalid, they would never be able
to use device_type. And while the use of device_type being completely
removed was proposed for the first few versions of PAPR and the
PowerPC device tree bindings that preceded it, it was obviously a
stupid idea.

~

What this binding achieves is the ability to override the numbers from
the docs (which can be hardcoded in the kernel since they are
hardcoded in the documentation) with custom numbers is all the binding
needs, and the numbering is entirely down to the documentation too -
as per the SMC convention and the latest PSCI, that magic 0x40000000
bit is what makes it 64-bit so no need to append or prepend any weird
values to the property names or function names.

Looking at it completely logically and from a conservative (resource
usage) standpoint: The original binding as implemented makes sense as
the interface was poorly defined and needed help, as the difference
between the original PSCI proposal and the 0.2 revision is the
*addition* of fixed function IDs and the SMC calling convention. There
is no need to define every PSCI function call number as a property and
associated value when for a version of the PSCI spec, that value is
locked down. The API is locked down. Adding new functions properties
to the DT doesn't make sense if you have an old kernel. If you supply
the value from the docs you're wasting space in the DT, and
potentially supplying more information than the OS kernel will know
what to do with anyway.

It follows that in the case where someone overrides a function call
with their own custom number for their own custom magic
implementation, this is by very definition *not PSCI 0.2 anymore* and
therefore the compatible property would be invalid anyway..

Which makes a device tree binding beyond..

psci {
    compatible = "arm,psci-0.2";
    method = "[sh]vc";
};

.. a complete overthinking of the problem. The original binding can
stick around in it's limited fashion, but I would have preferred the
above, since the property names have underscores (poo!) and don't
match the documentation anyway - it is a binding for binding's sake.
What it should have been is

psci {
    compatible = "arm,psci";
    method = "hvc";
    function-ids = 0xf00, 0xf01, 0xf02, 0xf03;
    function-names = "CPU_ON", "CPU_OFF", "CPU_SUSPEND", "CPU_MIGRATE";
};

Now the function names match the docs, the strcmp code matching those
strings will match the docs, and there's no reason to even discuss
what those property values would even need to be in the binding, since
they are in the original PSCI documentation. They could exist in a
binding only to remind people of the 4 functions that even existed.
Too late now, though.

Device trees aren't for offloading documentation data into, if we can
at all help it. Where data is fixed and documented, the documentation
is canonical and the device tree needn't replicate it for the benefit
of the operating system.

Rob wrote:

> This binding was written by Will Deacon and acked by Arnd and Nicolas not to mention the follow-up patches to use it over the last 9 months. Hardly a bunch of newbies that don't understand DT.

I would have expected better from Arnd who was there for the original
arch/ppc -> arch/powerpc thing and SLOF and PAPR and ePAPR and
probably had every real PowerPC OpenFirmware platform on his desk at
some point. I seem to recall you were around too - as was I. We should
have all caught it.. nobody did. Even when people do, sometimes people
won't listen anyway ;)

There are great examples of weirdo bindings making it into device
trees in the deep dark past of arch/ppc -> arch/powerpc while nobody
was looking, or shipped on some IBM blade before it was even a
specification. Sometimes things slip through the cracks. The fact that
there is no standards body or approval committee anymore (besides the
self-regulating agile monster we have now) doesn't help. Even the
Power.org TSCs didn't do a lot.

Until such a thing exists, we just have to do our best to fix stuff
after the fact, and until there *is* a standards committee or maybe
some kind of validation tool for obvious errors (underscores in
properties) or some kind of special syntax definition like an XML
schema that things can be validated against... plus a review process
where the driver author can be drilled about why that property needs
to be this way or what the benefit is for providing it.. device trees
as ABI is a moronic gesture. Where device trees are in flux, ways need
to be standardized to fix device trees before Linux is loaded. This is
*easy as pie* on a real OpenFirmware box. In U-Boot it is a bit of a
bitch to do, but it's definitely possible to completely rework the FDT
in memory once loaded and add and remove and rename properties..  this
ends up being a distro problem, but the distro guys don't want to own
it.

-- 
Matt Sealey <neko@bakuhatsu.net>
