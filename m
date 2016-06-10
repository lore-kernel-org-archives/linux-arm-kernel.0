From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 10 Jun 2016 11:27:37 +0200
Subject: [PATCH v3 1/4] USB: Fix of_usb_get_dr_mode_by_phy with a shared
 phy block
In-Reply-To: <20160609194936.GB2167@uda0271908>
References: <1465138776-6003-1-git-send-email-hdegoede@redhat.com>
 <20160609143004.GA2167@uda0271908>
 <9a05c16a-e8a2-02b7-c093-1131e27bcdd4@redhat.com>
 <20160609194936.GB2167@uda0271908>
Message-ID: <764e8d4b-4b8a-6b8a-db34-424efbc8ca93@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-06-16 21:49, Bin Liu wrote:
> Hi,
>
> On Thu, Jun 09, 2016 at 04:51:45PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 09-06-16 16:30, Bin Liu wrote:
>>> Hi,
>>>
>>> On Sun, Jun 05, 2016 at 04:59:33PM +0200, Hans de Goede wrote:
>>>> Some SoCs have a single phy-hw-block with multiple phys, this is
>>>> modelled by a single phy dts node, so we end up with multiple
>>>> controller nodes with a phys property pointing to the phy-node
>>>> of the otg-phy.
>>>>
>>>> Only one of these controllers typically is an otg controller, yet we
>>>> were checking the first controller who uses a phy from the block and
>>>> then end up looking for a dr_mode property in e.g. the ehci controller.
>>>>
>>>> This commit fixes this by adding an arg0 parameter to
>>>> of_usb_get_dr_mode_by_phy and make of_usb_get_dr_mode_by_phy
>>>> check that this matches the phandle args[0] value when looking for
>>>> the otg controller.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> Changes in v2:
>>>> -Add a args0 parameter instead of looking for nodes with a dr_mode property
>>>> Changes in v3:
>>>> -No changes
>>>> ---
>>>> drivers/usb/common/common.c  | 31 ++++++++++++++++++-------------
>>>> drivers/usb/phy/phy-am335x.c |  2 +-
>>>> include/linux/usb/of.h       |  4 ++--
>>>> 3 files changed, 21 insertions(+), 16 deletions(-)
>>>
>>> This breaks am335x.
>>>
>>> [   17.433166] /ocp/usb at 47400000/usb at 47401000: could not get #phy-cells
>>> for /ocp/usb at 47400000/usb-phy at 47401300
>>> [   17.443627] /ocp/usb at 47400000/usb at 47401800: could not get #phy-cells
>>> for /ocp/usb at 47400000/usb-phy at 47401b00
>>> [   17.454005] am335x-phy-driver 47401300.usb-phy: dr_mode 0
>>> [   17.460518] 47401300.usb-phy supply vcc not found, using dummy
>>> regulator
>>> [   17.469685] /ocp/usb at 47400000/usb at 47401000: could not get #phy-cells
>>> for /ocp/usb at 47400000/usb-phy at 47401300
>>> [   17.479998] /ocp/usb at 47400000/usb at 47401800: could not get #phy-cells
>>> for /ocp/usb at 47400000/usb-phy at 47401b00
>>> [   17.490342] am335x-phy-driver 47401b00.usb-phy: dr_mode 0
>>
>> That is weird, quoting: drivers/phy/phy-core.c: _of_phy_get():
>>
>>         ret = of_parse_phandle_with_args(np, "phys", "#phy-cells",
>>                 index, &args);
>>         if (ret)
>>                 return ERR_PTR(-ENODEV);
>>
>> So if #phy-cells is not defined, then the phy core should not
>> be able to work with the dts files in question at all.
>
> am335x phy does not use phy framework, so those phy core api is not
> called.
>
>>
>> All my patch does is make the way of_usb_get_dr_mode_by_phy parses
>> phy-handles be identical to how phy-core.c does it.
>>
>> I see that the usb0_phy node in arch/arm/boot/dts/am33xx.dtsi
>> indeed lacks a "#phy-cells = <0>;" line.
>>
>> Quoting: Documentation/devicetree/bindings/phy/phy-bindings.txt
>>
>> PHY device node
>> ===============
>>
>> Required Properties:
>> #phy-cells:     Number of cells in a PHY specifier;  The meaning of all those
>>                 cells is defined by the binding for the phy node. The PHY
>>                 provider can use the values in cells to find the appropriate
>>                 PHY.
>>
>> So not having #phy-cells defined for a phy-node clearly is a bug.
>
> am335x phy does not follow the bindings in phy/, but usb/phy/.

Ah, I did not know about those, that explains. I will send a v4 of
the patch which will keep compatibility with the usb/phy/ bindings
when the passed in arg0 == -1.

Note I will not be resending patch 2-4, please merge these as they
are (no changes are needed).

>>
>> A patch like the following should fix this:
>>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 52be48b..c4ff788d 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -557,6 +557,7 @@
>>  			};
>>
>>  			usb0_phy: usb-phy at 47401300 {
>> +				#phy-cells = <0>;
>
> This seems to be ok, but this patch would break the dt backward compatible.

I understand, as said above I'll do a new version of the patch preserving
compatibility.

>>  				compatible = "ti,am335x-usb-phy";
>>  				reg = <0x47401300 0x100>;
>>  				reg-names = "phy";
>>

Regards,

Hans
