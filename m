From: rjui@broadcom.com (Ray Jui)
Date: Mon, 8 Dec 2014 08:55:20 -0800
Subject: [PATCH v2 1/5] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <2594176.SCRFa6Sb3O@wuerfel>
References: <1418006316-324-2-git-send-email-rjui@broadcom.com>
 <2594176.SCRFa6Sb3O@wuerfel>
Message-ID: <5485D7F8.6090305@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/8/2014 3:22 AM, Arnd Bergmann wrote:
> On Sunday 07 December 2014 18:38:32 Ray Jui wrote:
>> +Required properties:
>> +
>> +- compatible:
>> +    Currently supported Cygnus GPIO controllers include:
>> +    "brcm,cygnus-ccm-gpio": ChipcommonG GPIO controller
>> +    "brcm,cygnus-asiu-gpio": ASIU GPIO controller
>> +    "brcm,cygnus-crmu-gpio": CRMU GPIO controller
>
> How different are these? If they are almost the same, would it
> be better to use the same compatible string for all of them and
> describe the differences in extra properties?
>
> If they are rather different, maybe you should have a separate
> binding and driver for each?
>
> 	Arnd
>
They are quite similar with the following minor differences:
1) ChipcommonG GPIO controller uses a separate register block 
(0x0301d164) to control drive stregnth
2) Cannot control drive strength for the CMRU GPIO
3) CRMU GPIO controller's interrupt is not connected to GIC of A9. 
Currently that's taken care of by using a "no-interrupt" device tree 
property

I can change to use the common compatible string "brcm,cygnus-gpio". 
With an introduction of property "no-drv-stregnth" which should be set 
for CRMU GPIO controller. For ChipcommonG GPIO, it will have a second 
register block defined, so we'll know to use that second register block 
for drive strength configuration. For the rest, we assume normal drive 
strength configuration (i.e., ASIU in our case).

Looking at this again, it looks like the "no-interrupt" property is 
really redundant. For GPIO controller without interrupt connected to A9, 
we can simply leave its interrupt properties not defined. I'll get rid 
of it along with the above changes.
