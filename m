From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Feb 2018 20:52:19 +0800
Subject: [PATCH] phy: allwinner: sun4i-usb: poll vbus changes on A23/A33
 when driving VBUS
In-Reply-To: <a38e269f-abe9-0560-1542-c115c5a64605@ti.com>
References: <20180119092541.7508-1-wens@csie.org>
 <20180119144512.dqqbywavhwsyma2f@flea.lan>
 <a38e269f-abe9-0560-1542-c115c5a64605@ti.com>
Message-ID: <CAGb2v64i43RsN7rrPseRiDBJdFGNZW9gr6BrDCJNg2e=m1F8VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 16, 2018 at 7:20 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Friday 19 January 2018 08:15 PM, Maxime Ripard wrote:
>> On Fri, Jan 19, 2018 at 05:25:41PM +0800, Chen-Yu Tsai wrote:
>>> The AXP223 PMIC, like the AXP221, does not generate VBUS change
>>> interrupts when N_VBUSEN is used to drive VBUS for the OTG port
>>> on the board.
>>>
>>> This was not noticed until recently, as most A23/A33 boards use
>>> a GPIO pin that does not support interrupts for OTG ID detection.
>>> This forces the driver to use polling. However the A33-OlinuXino
>>> uses a pin that does support interrupts, so the driver uses them.
>>> However the VBUS interrupt never fires, and the driver never gets
>>> to update the VBUS status. This results in musb timing out waiting
>>> for VBUS to rise.
>>>
>>> This was worked around for the AXP221 by resorting to polling
>>> changes in commit 91d96f06a760 ("phy-sun4i-usb: Add workaround for
>>> missing Vbus det interrupts on A31"). This patch adds the A23 and
>>> A33 to the list of SoCs that need the workaround.
>>>
>>> Fixes: fc1f45ed3043 ("phy-sun4i-usb: Add support for the usb-phys on the
>>>                    sun8i-a33 SoC")
>>> Fixes: 123dfdbcfaf5 ("phy-sun4i-usb: Add support for the usb-phys on the
>>>                    sun8i-a23 SoC")
>>> Cc: <stable@vger.kernel.org> # 4.3.x: 68dbc2ce77bb phy-sun4i-usb:
>>>              Use of_match_node to get model specific config data
>>> Cc: <stable@vger.kernel.org> # 4.3.x: 5cf700ac9d50 phy: phy-sun4i-usb:
>>>              Fix optional gpios failing probe
>>> Cc: <stable@vger.kernel.org> # 4.3.x: 04e59a0211ff phy-sun4i-usb:
>>>              Fix irq free conditions to match request conditions
>>> Cc: <stable@vger.kernel.org> # 4.3.x: 91d96f06a760 phy-sun4i-usb:
>>>              Add workaround for missing Vbus det interrupts on A31
>>> Cc: <stable@vger.kernel.org> # 4.3.x
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>
>>> This list might get longer if the newer AXP8xx PMICs also have this
>>> behavior. We could switch to a boolean in the per-compatible data,
>>> or just always use polling. The yet-merged R40 support will have this
>>> issue as well, as the R40 is paired with the AXP221. But for now,
>>> I'd like to have something that is easier to backport to stable, so
>>> we can at least fix this for the A23 and A33.
>>>
>>> Also, checkpatch.pl doesn't like the stable kernel prerequisite lines.
>>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> merged, thanks!

Thanks.

After some more experimentation on the A83T/AXP813, it seems this
is pretty standard behavior for the AXP PMICs. If one uses N_VBUSEN
to enable VBUS, the user/system should already know that VBUS is
on or present. The VBUS-related logic in the PMIC, save for the
VBUS status bits, is disconnected in this case.

So it looks like we either enable this workaround for most if not
all of the Allwinner family, or fix this by polling in the power
supply driver itself. This would require polling once every 50ms,
which might be too much work for the system, but is necessary for
VBUS detection to work properly for MUSB. Or we could limit polling
to whenever the drivevbus regulator is enabled. This would involve
creating a reference between the USB power supply and regulator in
the device tree. (There doesn't seem to be a way to fetch a regulator
directly by its device node.) The power supply would then register
a notifier on the regulator for on/off events, and configure polling
accordingly.

Any suggestions?

ChenYu
