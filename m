From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 9 Oct 2017 20:16:20 +0530
Subject: [PATCH v3 03/22] dt-bindings: arm: scmi: add ARM MHU specific
 mailbox client bindings
In-Reply-To: <CAL_JsqKy+WzEiHRS0BrE3_3Md4CGOr0e2ZZ_vBCB-Opgg49s+A@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-4-git-send-email-sudeep.holla@arm.com>
 <20171005232031.7373ni5ssln4wlpr@rob-hp-laptop>
 <CABb+yY1ra5bgRB1VND+NvCcDFqfggG04a+JPWFZ+HpNg08eR8g@mail.gmail.com>
 <CAL_Jsq+0paGePmJVjsyFJiHx0UaDPjQrbe3C030U+fuUkWCJ+A@mail.gmail.com>
 <CABb+yY2v8D9NFVsG9OwSpL8cswKihY6OUru8QA6Jfq5YmVVD7A@mail.gmail.com>
 <CAL_JsqKy+WzEiHRS0BrE3_3Md4CGOr0e2ZZ_vBCB-Opgg49s+A@mail.gmail.com>
Message-ID: <CABb+yY0KNafWbD00hBVrNNGnFDcU0v6KXXY2D2K7KNouak1HdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 9, 2017 at 7:22 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Oct 6, 2017 at 9:26 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Fri, Oct 6, 2017 at 9:24 PM, Rob Herring <robh@kernel.org> wrote:
>>> On Fri, Oct 6, 2017 at 6:01 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>>> On Fri, Oct 6, 2017 at 4:50 AM, Rob Herring <robh@kernel.org> wrote:
>>>>> On Thu, Sep 28, 2017 at 02:11:27PM +0100, Sudeep Holla wrote:
>>
>>>>>
>>>>>> +- mbox-data : For each phandle listed in mboxes property, an unsigned 32-bit
>>>>>> +           data as expected by the mailbox controller
>>>>>
>>>>> Shouldn't that be cells as part of mboxes property?
>>>>>
>>>> A MHU client can send any number of commands (such u32 values) over a channel.
>>>> This client (SCMI) sends just one command over a channel, but other
>>>> clients may/do send two or more.
>
> The above definition doesn't support 2 or more as it is 1-1 with channels.
>
I thought you suggested to make controller driver accept the command
as another cell in client's mboxes property.
Which we can't do.

>>> Okay, then I guess I don't understand why this is in DT.
>>>
>> Yeah the client has to provide code (u32 value) for the commands it
>> sends, and that value is going to be platform specific. For example,
>> on Juno the ITS_AN_SCMI_COMMAND may be defined as BIT(7) while on my
>> platform it may be 0x4567
>>
>> For MHU based platforms, it becomes easy if the u32 is passed from DT.
>> And that should be ok since that is like a h/w parameter - a value
>> chosen/expected by the remote firmware.
>
> Could it ever be more than 1 cell?
>
SCMI sends sub-commands via SHMEM, so it is always going to be 1cell for _scmi_.
However many firmwares are unlikely to use just one command over a
channel - say, the protocol is trivial or the linux and remote have no
SHMEM.

> I guess being in DT is fine, but I'm still not sure about the naming.
> The current name suggests it is part of the mbox binding. Do we want
> that or should it be SCMI specific? Then "data" is vague. Perhaps
> "scmi-commands"?
>
Sure. I have no problem with whatever we wanna call it.

thnx
