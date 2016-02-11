From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 11 Feb 2016 13:49:58 -0600
Subject: [PATCH 3/3] ARM64: zynqmp: Use 64bit size cell format
In-Reply-To: <56BCD9CB.9030803@monstr.eu>
References: <2f160e012080d5d6de11238ade239bb0bb224f64.1455193571.git.michal.simek@xilinx.com>
 <36fb9c4c9b2019b854e84dc0a9a01252a6de2337.1455193571.git.michal.simek@xilinx.com>
 <CAL_JsqK0=LaXqJyr_rGKCzGgt5kFy79-4ARocTGpKved3JU-Ug@mail.gmail.com>
 <56BCD9CB.9030803@monstr.eu>
Message-ID: <CAL_JsqJPXvz_9GFtNyN024+GD=iBHARCb=VdSi_36GjMWe=CnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 12:58 PM, Michal Simek <monstr@monstr.eu> wrote:
> Hi Rob,
>
> On 11.2.2016 17:13, Rob Herring wrote:
>> On Thu, Feb 11, 2016 at 6:26 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> Use 64bit size cell format instead of 32bit for memory
>>> description. Change 64bit sizes also for all others IPs.
>>
>> Why? As is, this change is completely pointless because nothing needs
>> a >4GB size. Do you have peripherals with >4GB size?
>
> The change I need to do is to support more than 4GB memory. Memory space
> is divided to some parts. 2GB connected to hard part below 4GB. There
> there is 1GB connected to PL part below. Then 32GB hard part above of
> 4GB and a lot of space for PL part (~230GB).
>
> PCIe can also address more than 256GB.

So I would expect some amount of the bus structure to be reflected in
the DT. For example, hard and PL IP are probably in separate address
ranges. I'd guess PL bus has additional logic to enable/disable it for
reprogramming, so you'd need a different bus node anyway. For PCIe,
it's probably its own bus too.

> That's why I stand before decision. Change size-cell for all IPs which
> are currently listed. Or just change it for memory node which is listed
> in mainline.
> I am not quite sure how PCIe description will look like and if there is
> any other IP which will required on current buses use sizes more that
> 4GB. That's why I have change all sizes to support more than 4GB.
>
> But definitely current need is to support more than 4GB memory size and
> I have no problem to use not empty ranges property and keep there
> #size-cells = <1>;

Then why aren't you adding to the memory? (the bootloader sets the
actual size is a valid answer)

> Both solution works for me. Definitely thank you for your comments.

Either way, I'd change this when you actually need the change, not by itself.

Rob
