From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 11 Feb 2016 21:15:55 +0100
Subject: [PATCH 3/3] ARM64: zynqmp: Use 64bit size cell format
In-Reply-To: <CAL_JsqJPXvz_9GFtNyN024+GD=iBHARCb=VdSi_36GjMWe=CnA@mail.gmail.com>
References: <2f160e012080d5d6de11238ade239bb0bb224f64.1455193571.git.michal.simek@xilinx.com>
 <36fb9c4c9b2019b854e84dc0a9a01252a6de2337.1455193571.git.michal.simek@xilinx.com>
 <CAL_JsqK0=LaXqJyr_rGKCzGgt5kFy79-4ARocTGpKved3JU-Ug@mail.gmail.com>
 <56BCD9CB.9030803@monstr.eu>
 <CAL_JsqJPXvz_9GFtNyN024+GD=iBHARCb=VdSi_36GjMWe=CnA@mail.gmail.com>
Message-ID: <56BCEBFB.3070209@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 11.2.2016 20:49, Rob Herring wrote:
> On Thu, Feb 11, 2016 at 12:58 PM, Michal Simek <monstr@monstr.eu> wrote:
>> Hi Rob,
>>
>> On 11.2.2016 17:13, Rob Herring wrote:
>>> On Thu, Feb 11, 2016 at 6:26 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>>> Use 64bit size cell format instead of 32bit for memory
>>>> description. Change 64bit sizes also for all others IPs.
>>>
>>> Why? As is, this change is completely pointless because nothing needs
>>> a >4GB size. Do you have peripherals with >4GB size?
>>
>> The change I need to do is to support more than 4GB memory. Memory space
>> is divided to some parts. 2GB connected to hard part below 4GB. There
>> there is 1GB connected to PL part below. Then 32GB hard part above of
>> 4GB and a lot of space for PL part (~230GB).
>>
>> PCIe can also address more than 256GB.
> 
> So I would expect some amount of the bus structure to be reflected in
> the DT. For example, hard and PL IP are probably in separate address
> ranges. I'd guess PL bus has additional logic to enable/disable it for
> reprogramming, so you'd need a different bus node anyway. For PCIe,
> it's probably its own bus too.

As you see right now there is separation already.

> 
>> That's why I stand before decision. Change size-cell for all IPs which
>> are currently listed. Or just change it for memory node which is listed
>> in mainline.
>> I am not quite sure how PCIe description will look like and if there is
>> any other IP which will required on current buses use sizes more that
>> 4GB. That's why I have change all sizes to support more than 4GB.
>>
>> But definitely current need is to support more than 4GB memory size and
>> I have no problem to use not empty ranges property and keep there
>> #size-cells = <1>;
> 
> Then why aren't you adding to the memory? (the bootloader sets the
> actual size is a valid answer)

I am not fully convinced about it. Bootloader can set it up but there
shouldn't be dependency on bootloader capability that it will do it.
Also you don't need to use fully featured bootloader for doing that.
It means that for board dtses make sense to fill memory node with
correct values. If bootloader is capable to rewrite it/fix it, then it
is fine. If not, you can use let's say default values.

Also the second part of the problem is. You have bootloader which is
aware about that you have 34GB of memory in two banks. 2GB below 4GB
limit and 32GB above. But if bootloader starts to rewrite memory node
where #size-cell = <1> with 32GB size it will probably messes it up.

That's why I see the value to setup size-cells = <2>; earlier rather
than later.
IRC someone mentioning that in past when I was pushing zynqmp DTS that
we should use #size-cells = <2>;

>> Both solution works for me. Definitely thank you for your comments.
> 
> Either way, I'd change this when you actually need the change, not by itself.

ok. Fair enough. I need this for at least memory node because boards are
using the same zynqmp.dtsi files. For all other buses I have no problem
to keep just size-cells = <1>; and setup ranges to make dtc happy.

Thanks,
Michal
