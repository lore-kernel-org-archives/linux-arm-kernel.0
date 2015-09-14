From: binmlist@gmail.com (Bin Liu)
Date: Mon, 14 Sep 2015 14:06:41 -0500
Subject: [linux-sunxi] [PATCH] musb: sunxi: Ignore VBus errors in
 host-only mode
In-Reply-To: <55F70A67.3020502@redhat.com>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
 <55C31963.2010701@schinagl.nl> <55C3709C.4080609@redhat.com>
 <55C47041.3000603@schinagl.nl> <55E93D8C.9020804@schinagl.nl>
 <55F1CA9B.3070204@redhat.com> <20150910183017.GN9885@lukather>
 <55F1CE2E.7010409@redhat.com>
 <CADYTM3Z89oa3akqFaaY4BqJrQ4j+scQawRK0xRkthQde=OQ5tg@mail.gmail.com>
 <55F6E0CA.2010004@redhat.com>
 <CADYTM3Y10PsRZ3x9vf73px4T28M0naHnwyyRMZyPdrXc_Y-vLA@mail.gmail.com>
 <55F6FF28.80109@redhat.com>
 <CADYTM3b3w+c=F2MG+UZbWNHA6zpXPfFo4A2sNnajobBhPmBpAw@mail.gmail.com>
 <55F702EE.5070903@redhat.com>
 <CADYTM3b3U0iPGiWdnRiXL4WoAjP=_PvZazuArgJgvJ9fJNPV0g@mail.gmail.com>
 <55F70A67.3020502@redhat.com>
Message-ID: <CADYTM3a0Ov9dGwfC_zqMaa9D67C+Nd9N_wu1-pgxyH25Et1ukw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 14, 2015 at 12:56 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 14-09-15 19:53, Bin Liu wrote:
>
> <snip>
>
>>>> This is my first time looking at dts handling in drivers, so I might
>>>> be completely wrong, but I am thinking that since the controller node
>>>> links to the phy node, so the controller node is the parent of the phy
>>>> node, so if there is an of api can look it up?
>>>
>>>
>>>
>>> If the phy is a child of the controller, then yes this would work,
>>> but in the case of sunxi the phy is a built-in mmio mapped peripheral
>>> just like the controller, so they sit at the same level and have no
>>> parent child relation.
>>
>>
>> musb_dsps dts is the same.
>>
>> sun8i-a33.dtsi:
>>
>>      soc {
>>          usb_otg: {
>>              phys = <&usbphy 0>;
>>          }
>>          usbphy: {
>>          }
>>      }
>>
>> As in the example above, usb_otg node refers to usbphy node, so I am
>> wondering if there is an of api to look up the usb_otg properties in
>> the usbphy driver.
>
>
> That would boil down to hardcoding the node name / path compatible
> which is not acceptable from a devicetree pov.

Okay, I got this sorted out - querying dr_mode in the phy driver:

struct device_node *p;
struct device_node *t = NULL;
const char *dr_mode_str;
enum usb_dr_mode dr_mode;

do {
    t = of_find_node_with_property(t, "phys");
    if (!t)
        goto end;

    p = of_parse_phandle(t, "phys", 0);
    if (p == pdev->dev.of_node)
        break;
while (true);

of_property_read_string(t, "dr_mode", &dr_mode_str);
dr_mode = of_usb_get_dr_mode(dr_mode_str);

end:

Regards,
-Bin.

>
> Really having to duplicate the dr_mode is not that bad / such big
> a deal.
>
> Regards,
>
> Hans
