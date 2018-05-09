From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Wed, 9 May 2018 07:56:57 +0000
Subject: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
In-Reply-To: <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-2-git-send-email-amelie.delaunay@st.com>
 <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
 <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
Message-ID: <55392fe7-20d2-9447-60f9-4bd226b60195@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/26/2018 02:49 PM, Linus Walleij wrote:
> On Mon, Apr 16, 2018 at 8:19 PM, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Apr 11, 2018 at 11:47:01AM +0200, Amelie Delaunay wrote:
>>> This patch adds documentation of device tree bindings for the
>>> STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.
>>>
>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
>>> +     stmfxpinctrl: stmfx at 42 {
>>> +             compatible = "st,stmfx-0300";
>>> +             reg = <0x42>;
>>> +             interrupt-parent = <&gpioi>;
>>> +             interrupts = <8 IRQ_TYPE_EDGE_RISING>;
>>> +             vdd-supply = <&v3v3>;
>>> +             status = "okay";
>>
>> Don't show status in examples.
>>
>>> +
>>> +             stmfxgpio: gpio {
>>
>> Why does this need to be a sub node? Are there functions beyond GPIO?
> 
> Amelie can answer to whether there are, I suspect there
> are and in the review of patch 2 I suggest a MFD parent
> and parent/child spawning of a MFD child for the GPIO
> and pin control device.
> 
> Yours,
> Linus Walleij
> 

Indeed, stmfx has other functions than GPIO. But, after comments done 
here: [1] and there: [2], it has been decided to move MFD parent/GPIO 
child drivers into a single PINCTRL/GPIO driver because of the following 
reasons:
- Other stmfx functions (IDD measurement and TouchScreen controller) are 
not used on any of the boards using an stmfx and supported by Linux, so 
no way to test these functions, and no need to maintain them while they 
are not being used.
- But, in the case a new board will use more than GPIO function on 
stmfx, the actual implementation allow to easily extract common init 
part of stmfx and put it in an MFD driver.

So I could remove gpio sub-node and put its contents in stmfx node and 
keep single PINCTRL/GPIO driver for the time being.
Please advise,

Thanks,
Amelie

[1] https://lkml.org/lkml/2018/2/12/265
[2] https://lkml.org/lkml/2018/2/21/1503
