From: robh@kernel.org (Rob Herring)
Date: Wed, 13 Jun 2018 07:57:47 -0600
Subject: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
In-Reply-To: <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
Message-ID: <CAL_JsqL1xWCEYG1knOfUjmw7Y59Sx1ss5o2RyRm-fxoYXbDrJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 7:35 AM, Suzuki K Poulose
<Suzuki.Poulose@arm.com> wrote:
> Hi Matt,
>
> Thanks for your comments, responses inline.
>
> On 13/06/18 13:49, Matt Sealey wrote:
>>
>> Suzuki,
>>
>> Why not use ?unit??
>>
>> I believe we had this discussion years ago about numbering serial ports
>> and sdhci (i.e. how do you know it?s UART0 or UART1 from just the address?
>> Some SoC?s don?t address sequentially *or* in a forward direction) - I
>> believe it?s not exactly codified in ePAPR, not am I sure where it may be
>> otherwise, but it exists.
>
>
> We have different situation here. We need to know *the port number* as
> understood by the
> hardware, so that we can enable *the specific* port for a given path.
>
>>
>> I agree with Rob on the slave-mode nonsense, this is an SPI controller
>> concept weirdly stuffed into a directed graph which implicitly tells you the
>> data direction - it?s a rooted tree (just like DT!).

OF graph is not directional. All links must be bi-directional and in
fact dtc checks that now. The parent node should know the numbering
and direction of each port.

> Btw, the "slave-mode" is not a standard DT graph binding. It is not part of
> the
> generic DT graph binding. In fact the generic bindings stay away from the
> direction
> aspect and explicitly mentions the same.

I really don't like slave-mode nor coresight,hwid.

I would prefer to see getting rid of both and splitting ports into
"in-ports" and "out-ports" nodes instead of a single "ports" node.
Then you don't need any of these properties and reg can be used as the
hwid.

Rob
