From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Jan 2017 08:18:41 -0600
Subject: [PATCH v1 2/2] arm: dts: mt2701: add nor flash node
In-Reply-To: <20170119091428.598eb987@bbrezillon>
References: <d7b866ad-5b2f-62d3-3aa3-6fa42803d625@gmail.com>
 <b850b751-1d8d-0053-cf1f-d5314542e5c3@gmail.com>
 <20170113172825.75d545a3@bbrezillon>
 <86c997be-f500-eaa1-3ba5-d21cff6223b7@gmail.com>
 <20170113175628.1793f433@bbrezillon>
 <0fafcd8d-cf99-de6b-728f-5e3637810b68@gmail.com>
 <20170114092958.022f2fc8@bbrezillon>
 <e7fa1542-f0e2-0e45-23b3-25d6491ae40d@gmail.com>
 <20170116094032.6f471f11@bbrezillon>
 <20170117143650.5db87148@free-electrons.com>
 <20170118222010.ivc6jxpnrumemvdf@rob-hp-laptop>
 <20170119103829.524ce715@free-electrons.com>
 <CAL_Jsq+EyHtC7THLCJcwgtVtVESMOdmi3T3bBxgOqJt6BCtCHQ@mail.gmail.com>
 <20170119091428.598eb987@bbrezillon>
Message-ID: <CAL_Jsq+S-FYy4SmjJ3fWzBugw2zCj5TQkkfUA8QVL7SLJW3E1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 2:14 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Hi Rob,
>
> On Wed, 18 Jan 2017 20:51:08 -0600
> Rob Herring <robh@kernel.org> wrote:
>
>> On Wed, Jan 18, 2017 at 5:38 PM, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com> wrote:
>> > Hello,
>> >
>> > On Wed, 18 Jan 2017 16:20:10 -0600, Rob Herring wrote:
>> >
>> >> > > Rob, Mark, any opinion?
>> >> >
>> >>
>> >> Sigh, is how to do compatibles really not yet understood?
>> >
>> > Well, it seems like not everyone necessarily understands what is the
>> > best strategy to adopt (me included).
>> >
>> >> > I agree that a clarification would be good. There are really two
>> >> > options:
>> >> >
>> >> >  1. Have two compatible strings in the DT, the one that matches the
>> >> >     exact SoC where the IP is found (first compatible string) and the
>> >> >     one that matches some other SoC where the same IP is found (second
>> >> >     compatible string). Originally, Linux only supports the second
>> >> >     compatible string in its device driver, but if it happens that a
>> >> >     difference is found between two IPs that we thought were the same,
>> >> >     we can add support for the first compatible string in the driver,
>> >> >     with a slightly different behavior.
>> >>
>> >> This. And no wildcards in the compatible string.
>> >
>> > OK. So it means that today we do something like:
>> >
>> >         compatible = "baz,foo-12", "baz,foo-00";
>> >
>> > and support only baz,foo-00 in the driver. If tomorrow we discover
>> > that there is in fact a difference between the two IP blocks, we can
>> > add support for baz,foo-12 in the driver, and handle the differences.
>> >
>> > But then, the DT still contains:
>> >
>> >         compatible = "baz,foo-12", "baz,foo-00";
>> >
>> > and therefore pretends that the IP block is compatible with
>> > "baz,foo-00" which is in fact *not* the case. It was a mistake to
>> > consider it as compatible. So we keep living with a DT that has
>> > incorrect information.
>>
>> I wouldn't say it's a mistake necessarily. The old compatible would
>> probably work to some extent. I'd assume it was tested to some level.
>> Or it could be other changes exposing a difference.
>
> One last question and I'm done: is something like that acceptable?
>
>         compatible = "<vendor>,<old-soc>","<vendor>,<new-soc>";
>
> This can happen when someone adds support for an unsupported feature
> on a brand new SoC, and then someone else use the same driver for an
> older SoC embedding the same IP but still wants to add a new compatible
> just in case these 2 IPs appear to be slightly different.

Yes, it's old and new compatible strings in this case and it's newest
compatible string first.

> Here the order of compat strings is no longer following a clear rule
> like 'most-specific compatible first' or 'newest IP/SoC version first',
> it's completely dependent on the order these IPs were supported in the
> OS (Linux). I'm perfectly fine with that BTW, just want to make sure
> this is authorized.

I guess we should say "newest compatible for IP first" instead. There
are some exceptions where we add fallbacks later on, but that falls
under the most-specific part.

It's order that the bindings are defined, not Linux support really,
but in practice those are the same.

Rob
