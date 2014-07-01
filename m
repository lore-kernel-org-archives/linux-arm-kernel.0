From: robherring2@gmail.com (Rob Herring)
Date: Tue, 1 Jul 2014 14:47:46 -0500
Subject: [Patch v7 3/3] usb: dwc3: qcom: Add device tree binding
In-Reply-To: <20140701180114.GA2082@qualcomm.com>
References: <1404144233-17222-1-git-send-email-agross@codeaurora.org>
 <1404144233-17222-4-git-send-email-agross@codeaurora.org>
 <CAL_JsqJTO4htxHMVtMG6mGLmgRtQ7igE1OCX_jXM4xabN76ntg@mail.gmail.com>
 <20140701180114.GA2082@qualcomm.com>
Message-ID: <CAL_JsqLjjDV50x5LCDeySvV0u4U1om-3KDkFHMd5WouC=eV8kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 1:01 PM, Andy Gross <agross@codeaurora.org> wrote:
> On Tue, Jul 01, 2014 at 12:04:35AM -0500, Rob Herring wrote:
>
> <snip>
>
>> > +- clock-names: Should contain the following:
>> > +  "core"               Master/Core clock, have to be >= 125 MHz for SS
>> > +                               operation and >= 60MHz for HS operation
>> > +
>> > +Optional clocks:
>> > +  "iface"              System bus AXI clock.  Not present on all platforms
>>
>> Really?, some platforms have a clockless bus?
>
> Some platforms require core and interface.  The specific platform I tested on
> does not have an iface clk.  I'll take a look at the ipq block diagram to see if
> they did something cute, but i don't believe there is one.

Usually, that difference just means all the clock inputs are connected
to the same clock source. But the binding should describe the inputs.
If the dwc3 core has 3 clocks and your wrapper logic varies, I would
say you should follow the dwc3 core and ignore the wrapper for
purposes of the binding (unless there is some complex clock tree
there).

> <snip>
>
>> > +
>> > +                       ranges;
>> > +
>> > +                       status = "disabled";
>> > +
>> > +                       dwc3 at 11000000 {
>> > +                               compatible = "snps,dwc3";
>>
>> This sub-node is just wrong. Why can't you have a single node with '
>> "qcom,dwc3", "snps,dwc3" ' for the compatible property? All you are
>> adding here is clocks. Does the Synopsys block have no clocks?
>>
>> I guess this is copied from other broken dwc3 bindings... That doesn't
>> mean you have to copy it.
>
> The dwc3 core does not deal with clocks.  That is why everyone has a wrapper.
> That, in addition to pm, has to be handled from the wrapper.  That's my take
> anyway.  I am sure Felipe can speak more to this.

That is a Linux driver issue which is irrelevant to the binding.

Rob
