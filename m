From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 26 Mar 2018 09:49:51 +0200
Subject: [PATCH 1/4] dt-bindings: clock: meson: update documentation with
 hhi syscon
In-Reply-To: <CAL_JsqKPFbA4duG8tUKwdJTtxXOG+3kMTwu2qAVxb9zgPckL3g@mail.gmail.com>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
 <20180315115545.1884-2-jbrunet@baylibre.com>
 <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop>
 <1521385797.6569.90.camel@baylibre.com>
 <CAL_JsqKPFbA4duG8tUKwdJTtxXOG+3kMTwu2qAVxb9zgPckL3g@mail.gmail.com>
Message-ID: <8712ae70-9771-4438-68e2-9e4b37332de8@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/2018 04:04, Rob Herring wrote:
> On Sun, Mar 18, 2018 at 10:09 AM, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> On Sun, 2018-03-18 at 07:52 -0500, Rob Herring wrote:
>>> On Thu, Mar 15, 2018 at 12:55:42PM +0100, Jerome Brunet wrote:
>>>> The HHI register region hosts more than just clocks and needs to
>>>> accessed drivers other than the clock controller, such as the display
>>>> driver.
>>>>
>>>> This register region should be managed by syscon. It is already the case
>>>> on gxbb/gxl and it soon will be on axg. The clock controllers must use
>>>> this system controller instead of directly mapping the registers.
>>>
>>> Sounds like a kernel problem, not a DT one.
>>
>> It's a platform problem, so it has much a kernel problem (solution already
>> merged) as a DT problem
>>
>> DT wise, we've got two devices mapping the same region
>>
>> in arch/arm64/boot/dts/amlogic/meson-gx.dtsi:
>>> system-controller at 0
>>
>> which is used by the display device.
>>
>> and in arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi (same for gxl)
>>> clock-controller at 0
>>
>> It has worked so far because the clock controller claims the region w/o
>> reserving it but it remains unsafe since both device may access the same region.
>> The fix is to have the clock controller go through the existing syscon.
> 
> We certainly want to avoid multiple nodes using the same mmio region.
> 
> 
>>> With a single child, there is really no point to this change. A single
>>> node can provide multiple functions. Look at nodes that are both reset
>>> and clock providers.
>>
>> There is more than a single user, as explained above and in the cover letter of
>> this series.
> 
> Right, but a single node can support more than a single user (or
> provider). You don't have to have multiple nodes to have multiple
> users/providers.
> 
> Rob
> 

Hi Rob,

It's a question about user/provider, the syscon node represents the entire mmio
region which has multiple sparse registers for multiple features, is used
indirectly by the display driver, ... and has multiple features, non limited to,
clock controller, multiple power domains,... and it is simpler to represent these
as subnodes instead of a big fat node.

Today, it is already represented like this within the Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
So this binding is only an extension for the clock controller which was mis-architectured
at the time due to a mis-knowledge of the HW architecture.

Neil
