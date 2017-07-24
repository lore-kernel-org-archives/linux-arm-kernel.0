From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 24 Jul 2017 13:47:12 +0200
Subject: [PATCH 3/3] dt-bindings: clock: amlogic,gxbb-aoclkc: Update
 bindings
In-Reply-To: <20170721204439.GJ19878@codeaurora.org>
References: <1499336663-23875-1-git-send-email-narmstrong@baylibre.com>
 <1499336663-23875-4-git-send-email-narmstrong@baylibre.com>
 <20170710035031.rdbi64ookkbq6zeo@rob-hp-laptop>
 <20170721204439.GJ19878@codeaurora.org>
Message-ID: <1a971e80-1f91-c446-7e28-d193354b2859@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2017 10:44 PM, Stephen Boyd wrote:
> On 07/09, Rob Herring wrote:
>> On Thu, Jul 06, 2017 at 12:24:23PM +0200, Neil Armstrong wrote:
>>> On the first revision of the bindings, only the gates + resets were known
>>> in the AO Clock HW, but more registers used to configures AO clock are known
>>> to be spread among the AO register space.
>>> This patch adds these registers to the Ao Clock bindings with direct access
>>> and shared extcon access.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt         | 11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> This looks like the binding might be too specific with a reg list of 
>> single registers, and you should define a system controller node 
>> instead. Depends on what else is in the "A0" block.
>>
> 
> Agreed. Why can't we expand the size in DT and then access the
> registers directly in the driver. Hopefully it keeps working to
> apply the dts patch without the driver patch too (and
> vice-versa), because the kernel can only make a mapping as small
> as a page which would cover these newly added reg properties
> anyway.
> 

Hi Rob, Stephen,

Thanks for your feedback, but on these Amlogic platforms, the AO register bank is
filled with interleaved registers used for various purposes.

For instance, the first 1k of registers are :

0-c RTI_STATUS
c-14 RTI_PWR_CNTL
14-1c PIN_MUX
1c RTI_STATUS
24-30 GPIO
30 JTAG_CONFIG
34 WD
38-40 CPU_CTRL
40 RTI_GEN_CTRL
44 CPU_CTRL
4c-58 TIMER
58 OSCIN
60 AHB2DDR
...


And so on, and the clock related registers are split among this space.

For sure, this could be declared as an system controller node, but this would imply completely
re-designing the actual clock driver and drop the actual bindings.
(and with re-writting the clock gate code to use regmap registers access)

Anyway, I'm open to suggestions...

Neil
