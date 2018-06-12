From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Jun 2018 22:22:19 -0700
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845: Add I2C, SPI,
 and UART9 nodes
In-Reply-To: <20180612050108.GU510@tuxbook-pro>
References: <20180607204608.27688-1-dianders@chromium.org>
 <20180612050108.GU510@tuxbook-pro>
Message-ID: <CAD=FV=X4X+-oAX9YJ3rQkGXeWwu7XT_9-xNSG5ooJwm027ygAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 11, 2018 at 10:01 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Thu 07 Jun 13:46 PDT 2018, Douglas Anderson wrote:
>
>> This adds nodes to SDM845-dtsi for all the I2C ports, all the SPI
>> ports, and UART9.  Note that I2C / SPI / UART are a bit strange on
>> sdm845 because each "serial engine" has 4 pins associated with it and
>> depending on which firmware has been loaded into the serial engine
>> (loaded by the BIOS) the serial engine can behave like an I2C port, a
>> SPI port, or a UART.  As per the landed bindings that means that we
>> need to create one node for each possible mode that the port could be
>> in.  With 16 serial engines that means 16 x 3 = 48 nodes.
>>
>> We get away with only creating 33 nodes for now because it seems very
>> likely that SDM845-based boards will actually all use the same UART
>> (UART 9) for debug purposes.  While another UART could be used for
>> something like Bluetooth communication we can cross that path when we
>> come to it.  Some documentation that I saw implied that using a UART
>> for "high speed" communications actually needs yet another different
>> serial engine firmware anyway.
>>
>> Note that quick measurements adding all these nodes adds ~10k of extra
>> space per dtb that they're included with.  If this becomes a problem
>> we may need to think of a different way to structure this so that
>> boards only get the nodes they need (or figure out how to get dtc to
>> strip 'disabled' nodes).  For now it seems OK.
>>
>> These nodes were programmatically generated with a fairly dumb python
>> script.  See http://crosreview.com/1091631 for the source.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks for the review!

One note is that I have since come to find that it might not be so
wise to define the sleep pinctrl state here.  For the SPI driver at
least I dug in and I saw the the sleep state is selected when we're
runtime PMed.  ...and with the currently posted SPI driver that can
happen in some cases even when the chip select is supposed to be kept
low.  For now it's more prudent to keep the "sleep" state out of the
device tree and we can always add it in later.

I'll plan to re-spin the patch on Wednesday (I'm unavailable tomorrow).

For other's reference: I chatted offline with Bjorn offline and this
sounded fine to him.


-Doug
