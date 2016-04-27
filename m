From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 27 Apr 2016 09:34:44 -0500
Subject: [PATCH v2 2/2] Documentation: devicetree: Add PL310 PM bindings
In-Reply-To: <20160427140849.GA9612@zardoz.amer.corp.natinst.com>
References: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
 <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
 <1461015411-14000-3-git-send-email-brad.mouring@ni.com>
 <CAL_JsqL-LCt06ZYQL4FEu7vEdHaFCvBe5xnHbkZTf55yAf5Svw@mail.gmail.com>
 <20160419224122.GE19428@n2100.arm.linux.org.uk>
 <CAL_Jsq+SzUaNGy8LtqHv9T8i3x9WLHd-5eCb4=z4DMRwZo8XfA@mail.gmail.com>
 <20160427085947.GG19428@n2100.arm.linux.org.uk>
 <CAL_JsqJucGXLi0LS1ZoSCQJOceNBShauLLC4ZakZHnRmTYF4fg@mail.gmail.com>
 <20160427140849.GA9612@zardoz.amer.corp.natinst.com>
Message-ID: <CAL_JsqJOLjSMuW0f8RLD-byDU5yp1YEFLkauPETH2OUYpzgV4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 9:08 AM, Brad Mouring <brad.mouring@ni.com> wrote:
> On Wed, Apr 27, 2016 at 07:48:18AM -0500, Rob Herring wrote:
>> On Wed, Apr 27, 2016 at 3:59 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Wed, Apr 20, 2016 at 09:04:39AM -0500, Rob Herring wrote:
>> >> On Tue, Apr 19, 2016 at 5:41 PM, Russell King - ARM Linux
>> >> <linux@arm.linux.org.uk> wrote:
>> >> > On Tue, Apr 19, 2016 at 04:38:14PM -0500, Rob Herring wrote:
>> >> >> On Mon, Apr 18, 2016 at 4:36 PM, Brad Mouring <brad.mouring@ni.com> wrote:
>> >> >> > Document the DT bindings for controlling ARM PL310 Power Control
>> >> >> > settings.
>> >> >> >
>> >> >> > Signed-off-by: Brad Mouring <brad.mouring@ni.com>
>> >> >>
>> >> >> What happened to Josh's ack?
>> >> >>
>> >> >> > ---
>> >> >> >  Documentation/devicetree/bindings/arm/l2c2x0.txt | 4 ++++
>> >> >> >  1 file changed, 4 insertions(+)
>> >> >> >
>> >> >> > diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
>> >> >> > index fe0398c..c1c756e 100644
>> >> >> > --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
>> >> >> > +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
>> >> >> > @@ -84,6 +84,10 @@ Optional properties:
>> >> >> >  - prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
>> >> >> >    <1> (forcibly enable), property absent (retain settings set by
>> >> >> >    firmware)
>> >> >> > +- arm,dynamic-clock-gating : L2 dynamic clock gating. Value: <0> (forcibly
>> >> >> > +  disable), <1> or property absent (forcibly enable)
>> >> >> > +- arm,standby-mode: L2 standby mode enable. Value <0> (forcibly disable),
>> >> >> > +  <1>  or property absent (forcibly enable)
>> >> >>
>> >> >> What happened to "retain settings set by firmware"?
>> >> >
>> >> > I said we shouldn't.  Current behaviour is that we enable these features,
>> >> > and moving to missing-means-retain means that everything today ends up
>> >> > with these features disabled.  IOW, it's yet another change of actual
>> >> > behaviour that every platform would see.
>> >>
>> >> Right, but then the properties are different from prefetch-instr and
>> >> others IIRC. We're letting the OS define the binding. If BSD doesn't
>> >> enable these settings currently, then there is a mismatch between the
>> >> binding and actual behavior. Saying "retain firmware settings" also
>> >> defines specific OS behavior. I think absent should mean OS is free to
>> >> do whatever it wants which could be retain firmware settings, enable
>> >> or disable. In other words, it is undefined as this ship has already
>> >> sailed.
>> >
>> > I agree with "the ship has already sailed" but I disagree with the
>> > rest of your comment.  The ship has already sailed in that we have
>> > an established behaviour which has been there for 18 months.  Given
>> > the time period, it's not something I'm going to change at this
>> > stage, sorry.
>> >
>> > Why?  Such a change will go unnoticed, and it's particularly hard
>> > to debug why battery life has reduced.
>> >
>> > I guess we need to find a way to ensure that the default behaviour
>> > stays.  Whether that's by _everyone_ updating their DT files with
>> > the new properties or some other way, I don't care.  I only care
>> > that we retain the behaviour we've had for the last 18 months.
>>
>> I'm not suggesting that we change behavior at all. I'm only suggesting
>> that we leave it undefined in the binding documentation because the
>> behavior is possibly OS specific and can't really be defined there.
>>
>> Rob
>
> Ah, thanks for clarifying. However, I do have some additional
> clarifying questions:
>
> When you note that it should be left undefined in the binding
> documentation, do you mean document the actual, well-defined behavior
> and leave it at that, or document the well-defined behavior and note
> that, in the case where the binding is missing, behavior is OS
> specific (my interpretation of your comment), or completely removed
> from the documentation altogether (I'd want to know the reasoning if
> this is what you meant, for my own edification).

The 2nd case. Missing property should be documented as undefined or OS
specific. However, that does make this property different from others
already present. So perhaps we should document recommended OS behavior
even though Linux doesn't follow it. Something like: "If not present,
retaining the firmware setting is recommended. However, the actual
behavior may be OS specific."

Rob
