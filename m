From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Sat, 06 Sep 2014 17:34:47 +0200
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <201409051552.05447@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201409051338.40988@pali> <20140905134542.GD20164@leverpostej>
 <201409051552.05447@pali>
Message-ID: <540B2997.4070600@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.09.2014 15:52, schrieb Pali Roh?r:
> On Friday 05 September 2014 15:45:42 Mark Rutland wrote:
>> On Fri, Sep 05, 2014 at 12:38:40PM +0100, Pali Roh?r wrote:
>>> On Wednesday 18 June 2014 18:54:24 Pali Roh?r wrote:
>>>> Machine name from board description is some generic name
>>>> on DT kernel. DT provides machine name property which is
>>>> specific for board, so use it instead generic one when
>>>> possible.
>>>>
>>>> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
>>>> ---
>>>>
>>>>  arch/arm/kernel/setup.c |    7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/kernel/setup.c
>>>> b/arch/arm/kernel/setup.c index 8a16ee5..fbc7b4f 100644
>>>> --- a/arch/arm/kernel/setup.c
>>>> +++ b/arch/arm/kernel/setup.c
>>>> @@ -875,10 +875,13 @@ void __init setup_arch(char
>>>> **cmdline_p)
>>>>
>>>>  	setup_processor();
>>>>  	mdesc = setup_machine_fdt(__atags_pointer);
>>>>
>>>> -	if (!mdesc)
>>>> +	if (mdesc)
>>>> +		machine_name = of_flat_dt_get_machine_name();
>>>> +	else
>>>>
>>>>  		mdesc = setup_machine_tags(__atags_pointer,
>>>>
>>>> __machine_arch_type); machine_desc = mdesc;
>>>> -	machine_name = mdesc->name;
>>>> +	if (!machine_name)
>>>> +		machine_name = mdesc->name;
>>>>
>>>>  	if (mdesc->reboot_mode != REBOOT_HARD)
>>>>  	
>>>>  		reboot_mode = mdesc->reboot_mode;
>>>
>>> So, do you really want to break userspace which reading file
>>> /proc/cpuinfo (after migration from boardcode --> DT)?
>>
>> You have no guarantee model name in the DT == the name in a
>> board file anyhow, and trying to force that is wrong. So
>> further to Russell's reply, I must NAK this from a DT
>> perspective.
>>
>> Realistically your userspace is already broken if relying on
>> such things. You built something that only ever worked for a
>> particular arbitrary string. So it was already broken for
>> every other board, and there was never any guarantee that new
>> boards where your userspace could have worked would share the
>> same name.
>>
>> You're trying to fix the wrong side of the equation.
> 
> So what is your suggestion for identifing board (name/type) which 
> will work with any kernel (and will not be broken again by kernel 
> later)?

/proc/device-tree/compatible should give you a nul-separated list of
compatible strings for the machine. Ideally they're even documented
under Documentation/devicetree/bindings/arm/.

But as Mark said, depending on what you are actually trying to
distinguish in userspace, there may be better ways.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140906/61e3eb45/attachment-0001.sig>
